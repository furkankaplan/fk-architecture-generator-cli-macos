//
//  Repeat.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 26.09.2020.
//

import Foundation
import ArgumentParser

struct Onboard: ParsableCommand {
    
    @Argument(help: "Type of the architecture to produce module.")
    var architecture: String
    
    @Argument(help: "Name of the module")
    var name: String
            
    mutating func run() throws {
        // viper / mvvm for now.
        if architecture == MVVM {
            let mvvm = MvvmArchitecture(name: name)
            mvvm.produceModule()
        } else if architecture == VIPER {
            let viper = ViperArchitecture(name: name)
            viper.produceModule()
        } else {
            Logger.log(.error, message: UNSUPPORTED_MODULE_ERROR)
        }
    }
    
}
