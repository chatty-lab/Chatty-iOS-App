//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by walkerhilla on 12/12/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
  .shared(
    factory: .init(
      dependencies: [
        .shared(implements: .DesignSystem),
        .shared(implements: .ThirdPartyLib),
        .shared(implements: .Firebase),
        .shared(implements: .Util)
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Shared",
  targets: targets
)
