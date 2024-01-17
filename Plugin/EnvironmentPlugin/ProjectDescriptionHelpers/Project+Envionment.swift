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
    public static let deploymentTargets = DeploymentTargets.iOS("16.0")
    public static let bundleIdPrefix = "org.chattylab.chatty"
  }
}
