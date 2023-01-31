//
//  main.swift
//  LocalizationGen
//
//  Created by hanwe on 2021/04/26.
//

import Foundation

let commandRange: Range<Int> = 1..<Int(CommandLine.argc)

if let model = CommandParser.parse(commands: Array(CommandLine.arguments[commandRange])) {
    switch model.platform {
    case .apple:
        let manager = AppleLocalizationManager(model: model)
        manager.makeLocalizationFile()
    case .android:
        let manager = AndroidLocalizationManager(model: model)
        manager.makeLocalizationFile()
    }
}
else {
    print("Failed to create model")
}



