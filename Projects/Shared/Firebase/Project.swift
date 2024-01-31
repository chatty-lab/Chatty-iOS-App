import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Shared.name+ModulePath.Shared.Firebase.rawValue,
  targets: [
    .shared(
      implements: .Firebase,
      factory: .init(
        dependencies: [
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/FBLPromises.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/FirebaseAnalytics.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/FirebaseCore.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/FirebaseCoreInternal.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/FirebaseInstallations.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/FirebaseMessaging.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/GoogleAppMeasurement.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/GoogleAppMeasurementIdentitySupport.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/GoogleDataTransport.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/GoogleUtilities.xcframework")),
          .xcframework(path: .relativeToRoot("Frameworks/Firebase/nanopb.xcframework"))
        ]
      )
    )
  ],
  settings: .settings(
    base: [
      "OTHER_LDFLAGS": "-ObjC"
    ]
  )
)
