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
  name: ModulePath.Shared.name+ModulePath.Shared.DesignSystem.rawValue,
  targets: [
    .shared(
      implements: .DesignSystem,
      factory: .init(
        dependencies: [
          .external(name: "RxSwift"),
          .external(name: "RxGesture"),
          .external(name: "SnapKit"),
          .external(name: "Then"),
          .external(name: "DoubleSlider")
        ]
      )
    )
  ],
  resourceSynthesizers: [
    .assets(),
    .fonts(),
    .strings()
  ]
)
