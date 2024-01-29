import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Core.name+ModulePath.Core.Repository.rawValue,
  targets: [
    .core(
      implements: .Repository,
      factory: .init(
        dependencies: [
          .core(implements: .Network),
          .core(implements: .Storage),
        ]
      )
    )
  ]
)
