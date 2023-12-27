//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by walkerhilla on 12/12/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import ConfigurationPlugin

let infoPlist: [String: Plist.Value] = [
  "ITSAppUsesNonExemptEncryption": false,
  "CFBundleShortVersionString": "0.1.0",
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
  ],
  "UIAppFonts": [
    "Pretendard-Black.ttf",
    "Pretendard-Bold.ttf",
    "Pretendard-ExtraBold.ttf",
    "Pretendard-ExtraLight.ttf",
    "Pretendard-Light.ttf",
    "Pretendard-Medium.ttf",
    "Pretendard-Regular.ttf",
    "Pretendard-SemiBold.ttf",
    "Pretendard-Thin.ttf"
  ],
  "UISupportedInterfaceOrientations": [
    "UIInterfaceOrientationPortrait"
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
    configuration: .qa,
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
  targets: targets,
  additionalFiles: ["\(Path.sharedXcconfig.pathString)"]
)
