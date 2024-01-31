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
  ],
  "UIBackgroundModes": [
    "remote-notification"
  ],
  "baseURL": "$(baseURL)"
]

func createGoogleServiceInfoScript(for target: ProjectDeployTarget) -> TargetScript {
  let plistSuffix: String
  switch target {
  case .debug:
    plistSuffix = "-Debug"
  case .qa:
    plistSuffix = "-QA"
  case .release:
    plistSuffix = "-Release"
  }
  
  let script = """
                 cp -r "${SRCROOT}/Resources/Firebase/GoogleService-Info\(plistSuffix).plist" "${SRCROOT}/Resources/GoogleService-Info.plist"
                """
  
  return TargetScript.pre(script: script, name: "Copy GoogleService-Info.plist")
}

let targets: [Target] = [
  .app(
    implements: .IOS,
    configuration: .debug,
    factory: .init(
      infoPlist: .extendingDefault(with: infoPlist),
      scripts: [
        createGoogleServiceInfoScript(for: .debug)
      ],
      dependencies: [
        .feature,
        .core
      ]
    )
  ),
  .app(
    implements: .IOS,
    configuration: .qa,
    factory: .init(
      infoPlist: .extendingDefault(with: infoPlist),
      scripts: [
        createGoogleServiceInfoScript(for: .qa)
      ],
      dependencies: [
        .feature,
        .core
      ]
    )
  ),
  .app(
    implements: .IOS,
    configuration: .release,
    factory: .init(
      infoPlist: .extendingDefault(with: infoPlist),
      scripts: [
        createGoogleServiceInfoScript(for: .release)
      ],
      dependencies: [
        .feature,
        .core
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
      .release(name: .release)
    ]
  ),
  additionalFiles: ["\(Path.sharedXcconfig.pathString)"]
)
