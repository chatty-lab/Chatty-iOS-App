import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Shared.name+ModulePath.Shared.DesignSystem.rawValue,
  targets: [
    .shared(
      implements: .DesignSystem,
      factory: .init(
        dependencies: [
          .external(name: "RxSwift"),
          .external(name: "RxGesture"),
          .external(name: "SnapKit"),
          .external(name: "Then")
        ]
      )
    )
  ],
  resourceSynthesizers: [
    .assets(),
    .fonts(),
    .strings()
  ]
)
