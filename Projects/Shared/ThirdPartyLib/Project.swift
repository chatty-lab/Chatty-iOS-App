import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Shared.name+ModulePath.Shared.ThirdPartyLib.rawValue,
  targets: [
    .shared(
      implements: .ThirdPartyLib,
      factory: .init(
        dependencies: [
          .external(name: "RxSwift"),
          .external(name: "ReactorKit"),
          .external(name: "SnapKit"),
          .external(name: "Then")
        ]
      )
    ),
    
  ]
)
