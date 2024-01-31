//
//  ProjectDeployTarget.swift
//  DependencyPlugin
//
//  Created by walkerhilla on 12/16/23.
//

import Foundation
import ProjectDescription

public enum ProjectDeployTarget: String {
  case debug = "Debug"
  case qa = "QA"
  case release = "Release"
}

public extension ProjectDeployTarget {
  var bundleIdSuffix: String {
    switch self {
    case .debug: return ".debug"
    case .qa: return ".qa"
    case .release: return ""
    }
  }
  
  var configuration: Configuration {
    switch self {
    case .debug:
      return .debug(name: .debug, xcconfig: .relativeToXCConfig(type: .debug))
    case .qa, .release:
      return .release(name: .release, xcconfig: .relativeToXCConfig(type: self))
    }
  }
}
