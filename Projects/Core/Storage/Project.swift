import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Core.name+ModulePath.Core.Storage.rawValue,
  targets: [
    .core(
      interface: .Storage,
      factory: .init(
        dependencies: [
          .shared
        ]
      )
    ),
    .core(
      implements: .Storage,
      factory: .init(
        dependencies: [
          .core(interface: .Storage)
        ]
      )
    ),
    .core(
      testing: .Storage,
      factory: .init(
        dependencies: [
          .core(interface: .Storage)
        ]
      )
    ),
    .core(
      tests: .Storage,
      factory: .init(
        dependencies: [
          .core(testing: .Storage)
        ]
      )
    ),
  ]
)
