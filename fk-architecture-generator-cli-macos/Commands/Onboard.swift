//
//  Repeat.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 26.09.2020.
//

import Foundation
import ArgumentParser

struct Onboard: ParsableCommand {
    
    @Flag(name: .shortAndLong, help: "You can hide the [\(AppUtility.name)] mark from file documentation")
    var unmarked: Bool = false
    
    @Argument(help: "Type of the architecture to produce module.")
    var architecture: String = "mvvm"
    
    @Argument(help: "Name of the module")
    var name: String = "Test"
            
    mutating func run() throws {
        // viper / mvvm for now.
        if architecture == MVVM {
            var mvvm = MvvmArchitecture(name: name)
            mvvm.produceModule(isMarkHidden: unmarked)
        } else if architecture == VIPER {
            var viper = ViperArchitecture(name: name)
            viper.produceModule(isMarkHidden: unmarked)
        } else {
            Logger.log(.error, message: UNSUPPORTED_MODULE_ERROR)
        }
    }
    
}
