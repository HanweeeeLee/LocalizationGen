//
//  LocalizationFileMakerProtocol.swift
//  LocalizationGen
//
//  Created by hanwe lee on 2021/04/27.
//

import Cocoa

protocol LocalizationFileMakerProtocol: AnyObject {
    var model: CommandModel { get set }
    
    func makeLocalizationFile()
}
