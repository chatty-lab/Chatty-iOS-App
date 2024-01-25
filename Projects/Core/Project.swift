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
  .core(
    factory: .init(
      dependencies: [
        .core(implements: .Repository),
        .shared
      ]
    )
  )
]


let project: Project = .makeModule(
  name: "Core",
  targets: targets
)
