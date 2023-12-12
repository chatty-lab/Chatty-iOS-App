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
  .domain(
    factory: .init(
      dependencies: [
        .core,
        .domain(implements: .Auth)
      ]
    )
  )
]

let project: Project = .makeModule(
  name: "Domain",
  targets: targets
)
