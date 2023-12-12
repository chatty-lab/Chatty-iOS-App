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
        ]
      )
    )
  ]
)
