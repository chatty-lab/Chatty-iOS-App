import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Domain.name+ModulePath.Domain.Chat.rawValue,
  targets: [
    .domain(
      interface: .Chat,
      factory: .init(
        dependencies: [
          .shared,
          .domain(implements: .Common)
        ]
      )
    ),
    .domain(
      implements: .Chat,
      factory: .init(
        dependencies: [
          .domain(interface: .Chat)
        ]
      )
    ),
    
      .domain(
        testing: .Chat,
        factory: .init(
          dependencies: [
            .domain(interface: .Chat)
          ]
        )
      ),
    .domain(
      tests: .Chat,
      factory: .init(
        dependencies: [
          .domain(testing: .Chat)
        ]
      )
    ),
    
  ]
)
