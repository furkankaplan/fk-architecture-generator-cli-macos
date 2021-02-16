//
//  MvvmArchitecture.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

struct MvvmArchitecture: Architecture {
    
    var name: String
    var isMarkHidden: Bool!
    
    init(name: String = "") {
        self.name = name
    }
        
    private var xibFile: String {
        get {
            """
            <?xml version="1.0" encoding="UTF-8" standalone="no"?>
            <document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
            <dependencies>
                <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
                <capability name="Safe area layout guides" minToolsVersion="9.0"/>
                <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
            </dependencies>
            <objects>
                <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="\(name)ViewController" customModuleProvider="target">
                    <connections>
                        <outlet property="view" destination="i5M-Pr-FkT" id="sfx-zR-JGt"/>
                    </connections>
                </placeholder>
                <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
                <view clearsContextBeforeDrawing="NO" contentMode="scaleToFill" id="i5M-Pr-FkT">
                    <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
                    <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                    <color key="backgroundColor" systemColor="systemBackgroundColor" cocoaTouchSystemColor="whiteColor"/>
                    <viewLayoutGuide key="safeArea" id="fnl-2z-Ty3"/>
                </view>
            </objects>
            </document>
            """
        }
    }
        
    private var viewController: String {
        get {
            """
            //
            //  \(name)ViewController.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import UIKit

            class \(name)ViewController: UIViewController {

                var viewModel: \(name)ViewModelProtocol
                
                init(viewModel: \(name)ViewModelProtocol = \(name)ViewModel()) {
                    self.viewModel = viewModel
                    super.init(nibName: nil, bundle: nil)
                }

                required init?(coder: NSCoder) {
                    self.viewModel = \(name)ViewModel()
                    super.init(coder: coder)
                }

                override func viewDidLoad() {
                    super.viewDidLoad()

                }

            }
            """
        }
    }
    
    private var viewModel: String {
        get {
            """
            //
            //  \(name)ViewModel.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import Foundation

            protocol \(name)ViewModelProtocol {

            }
            class \(name)ViewModel: \(name)ViewModelProtocol {

            }
            """
        }
    }
    
    mutating func produceModule(isMarkHidden: Bool) {
        self.isMarkHidden = isMarkHidden
        
        let manager = FileManager.default
        
        guard let url = manager.urls(for: .desktopDirectory, in: .userDomainMask).first else { return }
        
        let outputFolder = url.appendingPathComponent(name, isDirectory: true)
        
        do {
            try manager.createDirectory(at: outputFolder, withIntermediateDirectories: true, attributes: nil) // Create root module directory.
        } catch { 
            Logger.log(.error, message: MODULE_CREATION_ERROR)
        }
        
        let viewsOutputFolder = outputFolder.appendingPathComponent("Views", isDirectory: true) // Prepare for the Views layer of the module.
        let viewModelsOutputFolder = outputFolder.appendingPathComponent("ViewModels", isDirectory: true) // Prepare for the ViewModels layer of the module.
        
        do {
            try manager.createDirectory(at: viewsOutputFolder, withIntermediateDirectories: true, attributes: nil) // Create Views layer.
            try manager.createDirectory(at: viewModelsOutputFolder, withIntermediateDirectories: true, attributes: nil) // Create ViewModels layer.
        } catch {
            Logger.log(.error, message: LAYER_CREATION_ERROR)
        }

        do {
            let viewModelOutputFile = viewModelsOutputFolder.appendingPathComponent("\(name)ViewModel.swift")
            let viewcontrollerOutputFile = viewsOutputFolder.appendingPathComponent("\(name)ViewController.swift")
            let xibOutputFile = viewsOutputFolder.appendingPathComponent("\(name)ViewController.xib")
            
            try viewModel.write(to: viewModelOutputFile, atomically: false, encoding: .utf8)
            try viewController.write(to: viewcontrollerOutputFile, atomically: false, encoding: .utf8)
            try xibFile.write(to: xibOutputFile, atomically: false, encoding: .utf8)
        } catch {
            Logger.log(.error, message: FILE_CREATION_ERROR)
        }
        
        Logger.log(.success, message: MODULE_READY_TO_GO_SUCCESS)
    }
    
}
