//
//  Configuration+Extension.swift
//  ConfigurationPlugin
//
//  Created by walkerhilla on 12/18/23.
//

import ProjectDescription

public extension ConfigurationName {
  static var qa: ConfigurationName { configuration(ProjectDeployTarget.qa.rawValue) }
}
