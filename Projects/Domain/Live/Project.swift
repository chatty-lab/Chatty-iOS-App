import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Domain.name+ModulePath.Domain.Live.rawValue,
  targets: [
    .domain(
      interface: .Live,
      factory: .init(
        dependencies: [
          .shared,
          .domain(implements: .Common)
        ]
      )
    ),
    .domain(
      implements: .Live,
      factory: .init(
        dependencies: [
          .domain(interface: .Live)
        ]
      )
    ),
    .domain(
      testing: .Live,
      factory: .init(
        dependencies: [
          .domain(interface: .Live)
        ]
      )
    ),
    .domain(
      tests: .Live,
      factory: .init(
        dependencies: [
          .domain(testing: .Live)
        ]
      )
    ),
  ]
)
