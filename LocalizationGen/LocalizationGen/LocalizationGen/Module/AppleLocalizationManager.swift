//
//  AppleLocalizationManager.swift
//  LocalizationGen
//
//  Created by hanwe lee on 2021/04/27.
//

import Cocoa

class AppleLocalizationManager: LocalizationFileMakerProtocol {
    
    // MARK: property
    var model: CommandModel
    let fileManager: FileManager = FileManager.default
    var keyColumnIndex: Int = -1
    var localColumnIndex: [String: Int] = [String: Int]()
    var cvsFileString: String = ""
    var cvsMatrix: [[String]] = []
    let commaSymbol = "#!@#@!@#@!##$$@" // Temporary string for commas
    
    // MARK: life cycle
    init(model: CommandModel) {
        self.model = model
        initLocalColumnIndex()
        guard let cvsString = readCVSFile() else { return }
        self.cvsFileString = cvsString
        self.cvsMatrix = makeCVSMatrix(originString: cvsString)
    }
    
    // MARK: private function
    
    private func initLocalColumnIndex() {
        for i in 0..<model.localColumnKeys.count {
            localColumnIndex[model.localColumnKeys[i]] = -1
        }
    }
    
    private func readCVSFile() -> String? {
        guard let contentsData: Data = fileManager.contents(atPath: model.inputPath) else { print("fail read CVS File.") ; return nil }
        guard let contentsString: String = String(data: contentsData, encoding: .utf8) else { print("fail read CVS File.") ; return nil }
        return contentsString
    }
    
    private func makeCVSMatrix(originString: String) -> [[String]] {
        var returnValue: [[String]] = []
        let rowDivision: [String] = Array(originString.components(separatedBy: "\r\n"))
        
        for i in 0..<rowDivision.count {
            if i == 0 {
                if !setIndexs(firstRow: rowDivision[i]) {
                    print("setIndex error")
                    break
                }
            }
            else {
                let item: String = convertDivisionableString(rowDivision[i])
                let itemDivision: [String] = recoverWriteableArray(Array(item.components(separatedBy: ",")))
                returnValue.append(itemDivision)
            }
        }
        return returnValue
    }
    
    private func convertDivisionableString(_ inputed: String) -> String {
        var returnValue = inputed
        let inputedArr = Array(inputed)
        var startIndex: Int = -1
        var endIndex: Int = -1
        for i in 0..<inputedArr.count {
            let item = inputedArr[i]
            if item == "\"" {
                if startIndex == -1 {
                    startIndex = i
                } else {
                    endIndex = i
                }
            }
            if startIndex != -1 && endIndex != -1 {
                let element: String = String(inputedArr[startIndex...endIndex])
                var newElement: String = element
                newElement = newElement.replacingOccurrences(of: "\"", with: "")
                newElement = newElement.replacingOccurrences(of: ",", with: self.commaSymbol)
                startIndex = -1
                endIndex = -1
                returnValue = returnValue.replacingOccurrences(of: element, with: newElement)
            }
        }
        return returnValue
    }
    
    private func recoverWriteableArray(_ inputed: [String]) -> [String] {
        var returnValue = [String]()
        
        for item in inputed {
            let newItem = item.replacingOccurrences(of: self.commaSymbol, with: ",")
            returnValue.append(newItem)
        }
        
        return returnValue
    }
    
    private func setIndexs(firstRow: String) -> Bool {
        var returnValue: Bool = false
        
        let columns = Array(firstRow.components(separatedBy: ","))
        for i in 0..<columns.count {
            if model.keyColumnKey == columns[i] {
                self.keyColumnIndex = i
            }
            for j in 0..<model.localColumnKeys.count {
                if model.localColumnKeys[j] == columns[i] {
                    localColumnIndex[model.localColumnKeys[j]] = i
                }
            }
        }
        
        if self.keyColumnIndex != -1 && isContainInvalidValueAtLocalColumnIndex() {
            returnValue = true
        }
        
        return returnValue
    }
    
    private func isContainInvalidValueAtLocalColumnIndex() -> Bool {
        var returnValue: Bool = true
        let allKeys = Array(self.localColumnIndex.keys)
        for i in 0..<allKeys.count {
            if self.localColumnIndex[allKeys[i]] == -1 {
                returnValue = false
                break
            }
        }
        return returnValue
    }
    
    private func makeLocalizationLine(key: String, value: String) -> String {
        var returnValue: String = ""
        returnValue.append("\"\(key)\" = \"\(value)\";\n")
        
        return returnValue
    }
    
    @discardableResult private func makeFileFromString(_ writedString: String, path: String) -> Bool {
        guard let writeData: Data = writedString.data(using: .utf8) else { return false }
        return self.fileManager.createFile(atPath: path, contents: writeData, attributes: nil)
    }
    
    private func getOutputFullPath(localeKeyword: String) -> String {
        var fullPath: String = ""
        var outputPath: String = self.model.outputPath
        if outputPath.last == "/" {
            outputPath.removeLast()
        }
        var fileName: String = self.model.fileName
        if fileName.contains(".") {
            let range: Range<String.Index> = fileName.range(of: ".")!
            let index: Int = fileName.distance(from: fileName.startIndex, to: range.lowerBound)
            let removedRange = fileName.index(fileName.startIndex, offsetBy: index)..<fileName.endIndex
            fileName.removeSubrange(removedRange)
        }
        fileName.append(".strings")
        fullPath = outputPath + "/\(localeKeyword)\(".lproj")/" + fileName
        autoCreateLocaleDirectory(dir: outputPath + "/\(localeKeyword)\(".lproj")") // todo 옵션으로 빼기
        return fullPath
    }
    
    private func autoCreateLocaleDirectory(dir: String) {
        var isDir: ObjCBool = true
        if !self.fileManager.fileExists(atPath: dir, isDirectory: &isDir) {
            let dirUrl: URL = URL(fileURLWithPath: dir)
            try? self.fileManager.createDirectory(at: dirUrl, withIntermediateDirectories: false, attributes: nil)
        }
    }
    
    // MARK: internal function
    
    func makeLocalizationFile() {
        for i in 0..<self.localColumnIndex.count {
            var localizationFileString: String = "/*\(CommonDefine.SIGNATURE)*/\n"
            for j in 0..<cvsMatrix.count {
                let key: String = cvsMatrix[j][self.keyColumnIndex]
                if key == "" {
                    continue
                }
                guard let columnIndex = self.localColumnIndex[model.localColumnKeys[i]] else { return }
                let value: String = cvsMatrix[j][columnIndex]
                localizationFileString.append(makeLocalizationLine(key: key, value: value))
            }
            makeFileFromString(localizationFileString, path: getOutputFullPath(localeKeyword: model.localColumnKeys[i]))
        }
    }
    
    
    
}
