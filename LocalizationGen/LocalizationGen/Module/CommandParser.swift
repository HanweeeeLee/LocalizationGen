//
//  CommandParser.swift
//  LocalizationGen
//
//  Created by hanwe lee on 2021/04/27.
//

import Cocoa

class CommandParser {
    static func parse(commands: [String]) -> CommandModel? {
        var inputPath: String = ""
        var outputPath: String = ""
        var platform: Platform = .apple
        var fileName: String = ""
        var localColumnKeys: [String] = []
        var keyColumnKey: String = ""
        
        for i in 0..<commands.count {
            let command: String = commands[i]
            let keyValueArr: [String] = command.components(separatedBy: "=")
            if keyValueArr.count != 2 {
                continue
            }
            switch keyValueArr[0] {
            case CommandDefine.INPUT_PATH:
                inputPath = keyValueArr[1]
            case CommandDefine.OUTPUT_PATH:
                outputPath = keyValueArr[1]
            case CommandDefine.PLATFORM:
                switch keyValueArr[1] {
                case Platform.apple.rawValue:
                    platform = .apple
                default:
                    continue
                }
            case CommandDefine.FILE_NAME:
                fileName = keyValueArr[1]
            case CommandDefine.LOCAL_COLUMN_KEYS:
                let columnKeyArr = keyValueArr[1].components(separatedBy: "&")
                if columnKeyArr.count == 0 {
                    continue
                }
                for j in 0..<columnKeyArr.count {
                    localColumnKeys.append(columnKeyArr[j])
                }
            case CommandDefine.KEY_COLUMN_KEY:
                keyColumnKey = keyValueArr[1]
            default:
                continue
            }
        }
        
        if inputPath == "" || outputPath == "" || fileName == "" || localColumnKeys.count == 0 || keyColumnKey == "" {
            return nil
        }
        else {
            return CommandModel(inputPath: inputPath, outputPath: outputPath, platform: platform, fileName: fileName, localColumnKeys: localColumnKeys, keyColumnKey: keyColumnKey)
        }
    }
}
