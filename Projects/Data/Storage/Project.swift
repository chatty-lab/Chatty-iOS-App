import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Data.name+ModulePath.Data.Storage.rawValue,
  targets: [
    .data(
      interface: .Storage,
      factory: .init(
        dependencies: [
          .domain
        ]
      )
    ),
    .data(
      implements: .Storage,
      factory: .init(
        dependencies: [
          .data(interface: .Storage)
        ]
      )
    ),
    .data(
      testing: .Storage,
      factory: .init(
        dependencies: [
          .data(interface: .Storage)
        ]
      )
    ),
    .data(
      tests: .Storage,
      factory: .init(
        dependencies: [
          .data(testing: .Storage)
        ]
      )
    )
  ]
)
