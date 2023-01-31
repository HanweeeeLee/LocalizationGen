//
//  CommandModel.swift
//  LocalizationGen
//
//  Created by hanwe lee on 2021/04/27.
//

import Cocoa

struct CommandModel {
    let inputPath: String
    let outputPath: String
    let platform: Platform
    let fileName: String
    let localColumnKeys: [String]
    let keyColumnKey: String
    
    init(inputPath: String, outputPath: String, platform: Platform = .apple, fileName: String, localColumnKeys: [String], keyColumnKey: String) {
        self.inputPath = inputPath
        self.outputPath = outputPath
        self.platform = platform
        self.fileName = fileName
        self.localColumnKeys = localColumnKeys
        self.keyColumnKey = keyColumnKey
    }
}
