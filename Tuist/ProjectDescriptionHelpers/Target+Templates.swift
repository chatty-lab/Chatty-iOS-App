//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by walkerhilla on 12/12/23.
//

import DependencyPlugin
import ConfigurationPlugin
import EnvironmentPlugin
import ProjectDescription

// MARK: Target + Template

public struct TargetFactory {
  var name: String
  var destinations: Destinations
  var product: Product
  var productName: String?
  var bundleId: String
  var deploymentTargets: DeploymentTargets?
  var infoPlist: InfoPlist?
  var sources: SourceFilesList?
  var resources: ResourceFileElements?
  var copyFiles: [CopyFilesAction]?
  var headers: Headers?
  var entitlements: Entitlements?
  var scripts: [TargetScript]
  var dependencies: [TargetDependency]
  var settings: Settings?
  var coreDataModels: [CoreDataModel]
  var environment: [String: EnvironmentVariable]
  var launchArguments: [LaunchArgument]
  var additionalFiles: [FileElement]
  
  public init(
    name: String = "",
    destinations: Destinations = [.iPhone],
    product: Product = .staticLibrary,
    productName: String? = nil,
    bundleId: String = Project.Environment.bundleIdPrefix,
    deploymentTargets: DeploymentTargets? = nil,
    infoPlist: InfoPlist? = .default,
    sources: SourceFilesList? = .sources,
    resources: ResourceFileElements? = nil,
    copyFiles: [CopyFilesAction]? = nil,
    headers: Headers? = nil,
    entitlements: Entitlements? = nil,
    scripts: [TargetScript] = [],
    dependencies: [TargetDependency] = [],
    settings: Settings? = nil,
    coreDataModels: [CoreDataModel] = [],
    environment: [String : EnvironmentVariable] = [:],
    launchArguments: [LaunchArgument] = [],
    additionalFiles: [FileElement] = []) {
      self.name = name
      self.destinations = destinations
      self.product = product
      self.productName = productName
      self.deploymentTargets = deploymentTargets
      self.bundleId = bundleId
      self.infoPlist = infoPlist
      self.sources = sources
      self.resources = resources
      self.copyFiles = copyFiles
      self.headers = headers
      self.entitlements = entitlements
      self.scripts = scripts
      self.dependencies = dependencies
      self.settings = settings
      self.coreDataModels = coreDataModels
      self.environment = environment
      self.launchArguments = launchArguments
      self.additionalFiles = additionalFiles
    }
}

public extension Target {
  private static func make(factory: TargetFactory) -> Self {
    return .init(
      name: factory.name,
      destinations: factory.destinations,
      product: factory.product,
      productName: factory.productName,
      bundleId: factory.bundleId,
      deploymentTargets: factory.deploymentTargets,
      infoPlist: factory.infoPlist,
      sources: factory.sources,
      resources: factory.resources,
      copyFiles: factory.copyFiles,
      headers: factory.headers,
      entitlements: factory.entitlements,
      scripts: factory.scripts,
      dependencies: factory.dependencies,
      settings: factory.settings,
      coreDataModels: factory.coreDataModels,
      environmentVariables: factory.environment,
      launchArguments: factory.launchArguments,
      additionalFiles: factory.additionalFiles
    )
  }
}

// MARK: Target + App

public extension Target {
  static func app(implements module: ModulePath.App, configuration: ProjectDeployTarget, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.name = ModulePath.App.name + module.rawValue
    
    switch module {
    case .IOS:
      newFactory.destinations = [.iPhone]
      newFactory.deploymentTargets = Project.Environment.deploymentTargets
      newFactory.product = .app
      newFactory.name = "\(Project.Environment.appName)-\(configuration.rawValue)"
      newFactory.productName = "\(Project.Environment.appName)_\(configuration.rawValue)"
      newFactory.bundleId = Project.Environment.bundleIdPrefix + configuration.bundleIdSuffix
      newFactory.sources = ["Sources/**"]
      newFactory.resources = ["Resources/**"]
      newFactory.entitlements = .file(path: "Chatty.entitlements")
      newFactory.settings = .settings(
        base: [
          "VERSIONING_SYSTEM": "apple-generic"
        ],
        configurations: [configuration.configuration]
      )
    }
    return make(factory: newFactory)
  }
}



// MARK: Target + Feature

public extension Target {
  static func feature(factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Feature.name
    newFactory.product = .staticFramework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Feature.name
    
    return make(factory: newFactory)
  }
  
  static func feature(implements module: ModulePath.Feature, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Feature.name + module.rawValue
    newFactory.product = .staticFramework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Feature.name + module.rawValue
    
    return make(factory: newFactory)
  }
  
  static func feature(tests module: ModulePath.Feature, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Feature.name + module.rawValue + "Tests"
    newFactory.sources = .tests
    newFactory.product = .unitTests
    
    return make(factory: newFactory)
  }
  
  static func feature(testing module: ModulePath.Feature, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Feature.name + module.rawValue + "Testing"
    newFactory.sources = .testing
    
    return make(factory: newFactory)
  }
  
  static func feature(interface module: ModulePath.Feature, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Feature.name + module.rawValue + "Interface"
    newFactory.sources = .interface
    newFactory.product = .staticFramework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Feature.name + module.rawValue + "Interface"
    
    return make(factory: newFactory)
  }
  
  static func feature(example module: ModulePath.Feature, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Feature.name + module.rawValue + "Example"
    newFactory.sources = .exampleSources
    newFactory.product = .app
    
    return make(factory: newFactory)
  }
}

// MARK: Target + Domain

public extension Target {
  static func domain(factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Domain.name
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Domain.name
    
    return make(factory: newFactory)
  }
  
  static func domain(implements module: ModulePath.Domain, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Domain.name + module.rawValue
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Domain.name + module.rawValue
    
    return make(factory: newFactory)
  }
  
  static func domain(tests module: ModulePath.Domain, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Domain.name + module.rawValue + "Tests"
    newFactory.product = .unitTests
    newFactory.sources = .tests
    
    return make(factory: newFactory)
  }
  
  static func domain(testing module: ModulePath.Domain, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Domain.name + module.rawValue + "Testing"
    newFactory.sources = .testing
    
    return make(factory: newFactory)
  }
  
  static func domain(interface module: ModulePath.Domain, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Domain.name + module.rawValue + "Interface"
    newFactory.sources = .interface
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Domain.name + module.rawValue + "Interface"
    
    return make(factory: newFactory)
  }
}

// MARK: Target + Data

public extension Target {
  static func data(factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Data.name
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Data.name
    
    return make(factory: newFactory)
  }
  
  static func data(implements module: ModulePath.Data, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Data.name + module.rawValue
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Data.name + module.rawValue
    
    return make(factory: newFactory)
  }
  
  static func data(tests module: ModulePath.Data, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Data.name + module.rawValue + "Tests"
    newFactory.product = .unitTests
    newFactory.sources = .tests
    
    return make(factory: newFactory)
  }
  
  static func data(testing module: ModulePath.Data, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Data.name + module.rawValue + "Testing"
    newFactory.sources = .testing
    
    return make(factory: newFactory)
  }
  
  static func data(interface module: ModulePath.Data, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Data.name + module.rawValue + "Interface"
    newFactory.sources = .interface
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Data.name + module.rawValue + "Interface"
    
    return make(factory: newFactory)
  }
}

// MARK: Target + Shared

public extension Target {
  static func shared(factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Shared.name
    newFactory.product = .framework
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Shared.name
    
    return make(factory: newFactory)
  }
  
  static func shared(implements module: ModulePath.Shared, factory: TargetFactory) -> Self {
    var newFactory = factory
    newFactory.deploymentTargets = Project.Environment.deploymentTargets
    newFactory.name = ModulePath.Shared.name + module.rawValue
    newFactory.bundleId = Project.Environment.bundleIdPrefix + ModulePath.Shared.name + module.rawValue
    newFactory.product = .framework
    
    if module == .DesignSystem {
      newFactory.sources = .sources
      newFactory.resources = ["Resources/**"]
    }
    
    return make(factory: newFactory)
  }
}
