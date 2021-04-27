//
//  main.swift
//  LocalizationGen
//
//  Created by hanwe on 2021/04/26.
//

import Foundation


print("arguments:\(CommandLine.arguments)")
print("argc:\(CommandLine.argc)")

let commandRange: Range<Int> = 1..<Int(CommandLine.argc)

print("comands: \(Array(CommandLine.arguments[commandRange]))")

if let model = CommandParser.parse(commands: Array(CommandLine.arguments[commandRange])) {
    print("모델 생성 성공 : \(model)")
    switch model.platform {
    case .apple:
        let manager = AppleLocalizationManager(model: model)
        manager.makeLocalizationFile()
    }
}
else {
    print("모델 생성 실패")
}



