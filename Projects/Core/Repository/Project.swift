import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Core.name+ModulePath.Core.Repository.rawValue,
  targets: [
    .core(
      interface: .Repository,
      factory: .init(
        dependencies: [
          .domain,
          .core(implements: .Network),
          .core(implements: .Storage)
        ]
      )
    ),
    .core(
      implements: .Repository,
      factory: .init(
        dependencies: [
          .core(interface: .Repository)
        ]
      )
    ),
    .core(
      testing: .Repository,
      factory: .init(
        dependencies: [
          .core(interface: .Repository)
        ]
      )
    ),
    .core(
      tests: .Repository,
      factory: .init(
        dependencies: [
          .core(testing: .Repository)
        ]
      )
    )
  ]
)
