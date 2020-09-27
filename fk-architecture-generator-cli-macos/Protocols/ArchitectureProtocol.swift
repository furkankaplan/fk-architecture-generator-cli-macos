//
//  ArchitectureProtocol.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

protocol Architecture {
    
    /// Name of the architecture module that you want to create.
    /// if you assign Foo to name variable with MVVM architecture, cli produce 3 files that are
    /// FooViewModel.swift, FooViewController.swift and FooViewController.xib inside
    /// two directories called Views and ViewModels inside Foo module directory.
    /// Just drag & drop the module created in your desktop to your project structure.
    var name: String { get }
    
    func produceModule()
    
}
