//
//  LocalizationFileMakerProtocol.swift
//  LocalizationGen
//
//  Created by hanwe lee on 2021/04/27.
//

import Cocoa

protocol LocalizationFileMakerProtocol: class {
    var model: CommandModel { get set }
    
    func makeLocalizationFile()
}
