//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by walkerhilla on 12/12/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let infoPlist: [String: Plist.Value] = [
  "App Uses Non-Exempt Encryption": "NO",
  "CFBundleShortVersionString": "1.0",
  "CFBundleVersion": "1",
  "CFBundleName": "Chatty",
  "CFBundleIconName": "AppIcon",
  "UIMainStoryboardFile": "",
  "UILaunchStoryboardName": "LaunchScreen",
  "UIApplicationSceneManifest": [
    "UIApplicationSupportsMultipleScenes": false,
    "UISceneConfigurations": [
      "UIWindowSceneSessionRoleApplication": [
        [
          "UISceneConfigurationName": "Default Configuration",
          "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
        ]
      ]
    ]
  ]
]

let targets: [Target] = [
  .app(
    implements: .IOS,
    configuration: .debug,
    factory: .init(
      infoPlist: .extendingDefault(with: infoPlist),
      dependencies: [
        .feature
      ]
    )
  ),
  .app(
    implements: .IOS,
    configuration: .release,
    factory: .init(
      infoPlist: .extendingDefault(with: infoPlist),
      dependencies: [
        .feature
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Chatty",
  targets: targets
)
