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
  .data(
    factory: .init(
      dependencies: [
        .data(implements: .Repository),
        .data(implements: .Network),
        .data(implements: .Storage)
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Data",
  targets: targets
)
