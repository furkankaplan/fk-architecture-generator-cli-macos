//
//  Logger.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

enum LogType: String {
    case error
    case success
}

struct Logger {
    
    static func log(_ logType: LogType,message: String) {
        switch logType {
        case LogType.error:
            print("\n🧯\u{001B}[0;31m \(message)\n")
        case LogType.success:
            print("\n🔥\u{001B}[0;32m \(message)\n")
        }
    }
    
}
