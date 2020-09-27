//
//  ViperArchitecture.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

struct ViperArchitecture: Architecture {

    var name: String
    
    private var xibFile: String = ""
    private var view: String = ""
    private var interactor: String = ""
    private var presenter: String = ""
    private var router: String = ""
    
    func produceModule() {
        
    }
    
}
