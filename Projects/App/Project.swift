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
    "CFBundleShortVersionString": "0.1.0",
    "CFBundleVersion": "1",
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
    factory: .init(
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: "Chatty.entitlements",
      dependencies: [
        .feature
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Chatty",
  targets: targets,
  settings: .settings(
    configurations: [
      .debug(name: .debug),
      .debug(name: "QA"),
      .release(name: .release)
    ]
  )
)
