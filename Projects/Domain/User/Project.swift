import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Domain.name+ModulePath.Domain.User.rawValue,
  targets: [
    .domain(
      interface: .User,
      factory: .init(
        dependencies: [
          .shared,
          .domain(implements: .Common)
        ]
      )
    ),
    .domain(
      implements: .User,
      factory: .init(
        dependencies: [
          .domain(interface: .User),
          .domain(interface: .Auth)
        ]
      )
    ),
    .domain(
      testing: .User,
      factory: .init(
        dependencies: [
          .domain(interface: .User)
        ]
      )
    ),
    .domain(
      tests: .User,
      factory: .init(
        dependencies: [
          .domain(testing: .User)
        ]
      )
    ),
    
  ]
)
