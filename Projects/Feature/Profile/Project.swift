import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Feature.name+ModulePath.Feature.Profile.rawValue,
  targets: [
    .feature(
      interface: .Profile,
        factory: .init(
          dependencies: [
            .domain
          ]
        )
    ),
    .feature(
        implements: .Profile,
        factory: .init(
            dependencies: [
                .feature(interface: .Profile)
            ]
        )
    ),

    .feature(
        testing: .Profile,
        factory: .init(
            dependencies: [
                .feature(interface: .Profile)
            ]
        )
    ),
    .feature(
        tests: .Profile,
        factory: .init(
            dependencies: [
                .feature(testing: .Profile)
            ]
        )
    ),

    .feature(
        example: .Profile,
        factory: .init(
            dependencies: [
                .feature(interface: .Profile)
            ]
        )
    )

]
)
