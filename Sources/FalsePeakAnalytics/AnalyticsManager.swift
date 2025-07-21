//
//  AnalyticsManager.swift
//  impostor
//
//  Created by Assistant on 07.06.2025.
//

import Foundation
import FirebaseAnalytics

public final class AnalyticsManager: Sendable {
    
    public static let shared = AnalyticsManager()
    
    private init() {}
    
    // MARK: - Screen Tracking
    
    public func trackScreen(name screenName: String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: screenName])
    }
    
    // MARK: - Custom Events
    
    public func trackEvent(
        _ eventName: String,
        parameters: [String: Any]? = nil
    ) {
        Analytics.logEvent(eventName, parameters: parameters)
    }
    
    // MARK: - User Properties
    
    public func setUserProperty(_ value: String?, forName name: String) {
        Analytics.setUserProperty(value, forName: name)
    }
    
    public func setUserID(_ userID: String?) {
        Analytics.setUserID(userID)
    }
    
    // MARK: - App Events
    
    public func trackAppLaunch() {
        trackEvent("app_launch")
    }
    
    public func trackAppForeground() {
        trackEvent("app_foreground")
    }
    
    public func trackAppBackground() {
        trackEvent("app_background")
    }
}
