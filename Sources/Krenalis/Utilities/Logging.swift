//
//  Logging.swift
//  
//
//  Created by Brandon Sneed on 3/9/23.
//

import Foundation

extension Analytics {
    public enum LogKind: CustomStringConvertible, CustomDebugStringConvertible {
        case error
        case warning
        case debug
        case none
        
        public var description: String { return string }
        public var debugDescription: String { return string }

        var string: String {
            switch self {
            case .error:
                return "MRG_ERROR: "
            case .warning:
                return "MRG_WARNING: "
            case .debug:
                return "MRG_DEBUG: "
            case .none:
                return "MRG_INFO: "
            }
        }
    }
    
    public func log(message: String) {
        Self.krenalisLog(message: message, kind: .none)
    }
    
    static public func krenalisLog(message: String, kind: LogKind) {
        #if DEBUG
        if Self.debugLogsEnabled {
            print("\(kind)\(message)")
        }
        #endif
    }
}
