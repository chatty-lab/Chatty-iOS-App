//
//  FirebaseLogEventService.swift
//  SharedFirebase
//
//  Created by walkerhilla on 1/23/24.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseMessaging

protocol FirebaseConfigurable {
  func configure(with filePath: String)
}

final class FirebaseAppConfigurator: FirebaseConfigurable {
  func configure(with filePath: String) {
    guard let fileopts = FirebaseOptions(contentsOfFile: filePath)
    else { return }
    FirebaseApp.configure(options: fileopts)
  }
}

protocol FirebaseAnalyticsLoggable {
  func logEvent()
}

final class FirebaseAnalyticsLogger: FirebaseAnalyticsLoggable {
  func logEvent() {
    Analytics.logEvent(AnalyticsEventSelectContent, parameters: nil)
  }
}

protocol FirebaseMessagingServiceable {
  func setDelegate(_ delegate: MessagingDelegate)
}

final class FirebaseMessagingManager: FirebaseMessagingServiceable {
  func setDelegate(_ delegate: MessagingDelegate) {
    Messaging.messaging().delegate = delegate
  }
}

public extension AppLogService {
  enum Firebase {
    static var analyticsLogger: FirebaseAnalyticsLoggable = FirebaseAnalyticsLogger()
    
    public static func logEvent() {
      analyticsLogger.logEvent()
    }
  }
}

public extension AppFirebase {
  enum Firebase {
    static var appConfigurator: FirebaseConfigurable = FirebaseAppConfigurator()
    
    public static func configure(with filePath: String) {
      appConfigurator.configure(with: filePath)
    }
  }
}

public extension AppMessegingService {
  enum Firebase {
    public static func setDelegate(_ delegate: MessagingDelegate) {
      Messaging.messaging().delegate = delegate
    }
  }
}
