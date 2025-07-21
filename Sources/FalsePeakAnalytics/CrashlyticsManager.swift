//
//  CrashlyticsManager.swift
//  impostor
//
//  Created by Assistant on 07.06.2025.
//

import Foundation
@preconcurrency import FirebaseCrashlytics

public final class CrashlyticsManager: Sendable {
    
    public static let shared = CrashlyticsManager()
    
    private let crashlytics: Crashlytics
    
    private init() {
        self.crashlytics = Crashlytics.crashlytics()
    }
    
    // MARK: - Non-Fatal Error Logging
    
    public func logNonFatalError(
        _ error: Error,
        userInfo: [String: Any]? = nil
    ) {
        // Add user info if provided
        if let userInfo = userInfo {
            for (key, value) in userInfo {
                crashlytics.setCustomValue(value, forKey: key)
            }
        }
        
        crashlytics.record(error: error)
    }
    
    public func logNonFatalError(
        message: String,
        code: Int = -1,
        userInfo: [String: Any]? = nil
    ) {
        let error = NSError(
            domain: "com.impostor.app.custom",
            code: code,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
        
        logNonFatalError(error, userInfo: userInfo)
    }
    
    // MARK: - User Context
    
    public func setUserID(_ userID: String) {
        crashlytics.setUserID(userID)
    }
    
    public func setCustomValue(_ value: Any, forKey key: String) {
        crashlytics.setCustomValue(value, forKey: key)
    }
    
    public func setCustomValues(_ customKeys: [String: Any]) {
        for (key, value) in customKeys {
            crashlytics.setCustomValue(value, forKey: key)
        }
    }
    
    // MARK: - Logs
    
    public func log(_ message: String) {
        crashlytics.log(message)
    }
    
    public func log(format: String, _ args: CVarArg...) {
        let message = String(format: format, arguments: args)
        crashlytics.log(message)
    }
    
    // MARK: - Fatal Errors (Force Crash)
    
    /// Forces a fatal crash for testing purposes
    /// ⚠️ WARNING: This will terminate the app immediately
    /// Should only be used in debug builds or for testing
    public func forceCrash() {
        crashlytics.log("Force crash triggered by CrashlyticsManager")
        fatalError("Force crash triggered by CrashlyticsManager.forceCrash()")
    }
    
    /// Forces a fatal crash with a custom message
    /// ⚠️ WARNING: This will terminate the app immediately
    /// Should only be used in debug builds or for testing
    /// - Parameter message: Custom crash message
    public func forceCrash(withMessage message: String) {
        crashlytics.log("Force crash triggered: \(message)")
        fatalError(message)
    }
} 
