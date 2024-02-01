import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Data.name+ModulePath.Data.Repository.rawValue,
  targets: [
    .data(
      interface: .Repository,
      factory: .init(
        dependencies: [
          .domain
        ]
      )
    ),
    .data(
      implements: .Repository,
      factory: .init(
        dependencies: [
          .data(interface: .Repository),
          .data(interface: .Network),
          .data(interface: .Storage)
        ]
      )
    ),
    .data(
      testing: .Repository,
      factory: .init(
        dependencies: [
          .data(interface: .Repository)
        ]
      )
    ),
    .data(
      tests: .Repository,
      factory: .init(
        dependencies: [
          .data(testing: .Repository)
        ]
      )
    )
  ]
)
