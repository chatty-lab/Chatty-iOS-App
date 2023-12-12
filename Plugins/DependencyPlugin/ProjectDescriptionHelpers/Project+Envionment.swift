//
//  Project+Envionment.swift
//  MyPlugin
//
//  Created by walkerhilla on 12/12/23.
//

import Foundation
import ProjectDescription

public extension Project {
  enum Environment {
    public static let appName = "Chatty"
    public static let deploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
    public static let bundlePrefix = "com.chattylab.chatty"
  }
}
