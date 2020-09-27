//
//  ViperArchitecture.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

struct ViperArchitecture: Architecture {

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
    
    private var view: String {
        get {
            """
            //
            //  \(name)View.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import UIKit

            class \(name)View: UIViewController {

                var presenter: \(name)PresenterProtocol?
            
                override func viewDidLoad() {
                    super.viewDidLoad()

                }

            }

            extension \(name)View: \(name)PresenterOutputProtocol {

            }
            """
        }
    }
    
    private var interactor: String {
        get {
            """
            //
            //  \(name)Interactor.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import Foundation

            class \(name)Interactor: \(name)InteractorProtocol {

                var presenter: \(name)InteractorOutputProtocol?
            
            }
            """
        }
    }
    
    private var presenter: String {
        get {
            """
            //
            //  \(name)View.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import Foundation

            class \(name)Presenter: \(name)PresenterProtocol {

                var view: \(name)PresenterOutputProtocol?
                var interactor: \(name)InteractorProtocol?
                var router: \(name)RouterProtocol?
            
            }

            extension \(name)Presenter: \(name)InteractorOutputProtocol {

            }
            """
        }
    }
    private var router: String {
        get {
            """
            //
            //  \(name)Router.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import Foundation

            class \(name)Router: \(name)RouterProtocol {

                public static func createModule(viewReferance: \(name)View) {
                    let presenter: \(name)PresenterProtocol & \(name)InteractorOutputProtocol = \(name)Presenter()
            
                    viewReferance.presenter = presenter
                    viewReferance.presenter?.view = viewReferance
                    viewReferance.presenter?.interactor = \(name)Interactor()
                    viewReferance.presenter?.router = \(name)Router()
                    viewReferance.presenter?.interactor?.presenter = presenter
                }
            
            }
            """
        }
    }
    
    private var protocols: String {
        get {
            """
            //
            //  \(name)Protocols.swift
            //
            //  \(ArchitectureUtility.header(isMarkHidden: isMarkHidden))
            //

            import Foundation

            protocol \(name)PresenterProtocol {
                var view: \(name)PresenterOutputProtocol? { get set }
                var interactor: \(name)InteractorProtocol? { get set }
                var router: \(name)RouterProtocol? { get set }
            }

            protocol \(name)PresenterOutputProtocol {

            }

            protocol \(name)RouterProtocol {
                
            }

            protocol \(name)InteractorProtocol {
                var presenter: \(name)InteractorOutputProtocol? { get set }
            }

            protocol \(name)InteractorOutputProtocol {
                
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
        
        let viewOutputFolder = outputFolder.appendingPathComponent("View", isDirectory: true) // Prepare for the View layer of the module.
        let interactorOutputFolder = outputFolder.appendingPathComponent("Interactor", isDirectory: true) // Prepare for the Interactor layer of the module.
        let presenterOutputFolder = outputFolder.appendingPathComponent("Presenter", isDirectory: true) // Prepare for the Presenter layer of the module.
        let routerOutputFolder = outputFolder.appendingPathComponent("Router", isDirectory: true) // Prepare for the Router layer of the module.

        do {
            try manager.createDirectory(at: viewOutputFolder, withIntermediateDirectories: true, attributes: nil) // Create View layer.
            try manager.createDirectory(at: interactorOutputFolder, withIntermediateDirectories: true, attributes: nil) // Create Interactor layer.
            try manager.createDirectory(at: presenterOutputFolder, withIntermediateDirectories: true, attributes: nil) // Create Presenter layer.
            try manager.createDirectory(at: routerOutputFolder, withIntermediateDirectories: true, attributes: nil) // Create Router layer.
        } catch {
            Logger.log(.error, message: LAYER_CREATION_ERROR)
        }
        
        let viewOutputFile = viewOutputFolder.appendingPathComponent("\(name)View.swift")
        let xibOutputFile = viewOutputFolder.appendingPathComponent("\(name)View.xib")
        let interactorOutputFile = interactorOutputFolder.appendingPathComponent("\(name)Interactor.swift")
        let presenterOutputFile = presenterOutputFolder.appendingPathComponent("\(name)Presenter.swift")
        let routerOutputFile = routerOutputFolder.appendingPathComponent("\(name)Router.swift")
        let protocolOutputFile = outputFolder.appendingPathComponent("\(name)Protocols.swift")
        
        do {
            try view.write(to: viewOutputFile, atomically: false, encoding: .utf8)
            try xibFile.write(to: xibOutputFile, atomically: false, encoding: .utf8)
            try interactor.write(to: interactorOutputFile, atomically: false, encoding: .utf8)
            try presenter.write(to: presenterOutputFile, atomically: false, encoding: .utf8)
            try router.write(to: routerOutputFile, atomically: false, encoding: .utf8)
            try protocols.write(to: protocolOutputFile, atomically: false, encoding: .utf8)
        } catch {
            Logger.log(.error, message: FILE_CREATION_ERROR)
        }
        
        Logger.log(.success, message: MODULE_READY_TO_GO_SUCCESS)
    }
    
}
