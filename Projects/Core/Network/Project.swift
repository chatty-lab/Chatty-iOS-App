//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by walkerhilla on 12/12/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let infoPlist: [String: Plist.Value] = [
  "baseURL": "$(baseURL)",
]

let project = Project.makeModule(
  name: ModulePath.Core.name+ModulePath.Core.Network.rawValue,
  targets: [
    .core(
      interface: .Network,
      factory: .init(
        dependencies: [
          .shared
        ]
      )
    ),
    .core(
      implements: .Network,
      factory: .init(
        infoPlist: .extendingDefault(with: infoPlist),
        dependencies: [
          .core(interface: .Network)
        ]
      )
    ),
    .core(
      testing: .Network,
      factory: .init(
        dependencies: [
          .core(interface: .Network)
        ]
      )
    ),
    .core(
      tests: .Network,
      factory: .init(
        dependencies: [
          .core(testing: .Network)
        ]
      )
    )
  ]
)
