//
//  CommandDefine.swift
//  LocalizationGen
//
//  Created by hanwe lee on 2021/04/27.
//

import Cocoa

enum Platform: String {
    case apple = "Apple"
}

class CommandDefine {
    static let INPUT_PATH: String = "inputPath"
    static let OUTPUT_PATH: String = "outputPath"
    static let PLATFORM: String = "platform" // 일단 Apple만 합시다.
    static let FILE_NAME: String = "fileName"
    static let LOCAL_COLUMN_KEYS: String = "localColumnKeys"
    static let KEY_COLUMN_KEY: String = "keyColumnKey"
}


