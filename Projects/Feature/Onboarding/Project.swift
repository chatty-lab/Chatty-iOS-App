//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by walkerhilla on 12/12/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
  name: ModulePath.Feature.name+ModulePath.Feature.Onboarding.rawValue,
  targets: [    
        .feature(
            interface: .Onboarding,
            factory: .init(
              dependencies: [
                .domain
              ]
            )
        ),
        .feature(
            implements: .Onboarding,
            factory: .init(
                dependencies: [
                    .feature(interface: .Onboarding)
                ]
            )
        ),
    
        .feature(
            testing: .Onboarding,
            factory: .init(
                dependencies: [
                    .feature(interface: .Onboarding)
                ]
            )
        ),
        .feature(
            tests: .Onboarding,
            factory: .init(
                dependencies: [
                    .feature(testing: .Onboarding)
                ]
            )
        ),
    
        .feature(
            example: .Onboarding,
            factory: .init(
                dependencies: [
                    .feature(interface: .Onboarding)
                ]
            )
        )

    ]
)
