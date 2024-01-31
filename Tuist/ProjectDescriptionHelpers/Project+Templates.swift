import ProjectDescription
import DependencyPlugin
import ConfigurationPlugin

public extension Project {
  static func makeModule(
    name: String,
    targets: [Target],
    settings: Settings? = nil,
    additionalFiles: [FileElement] = [],
    resourceSynthesizers: [ResourceSynthesizer] = []) -> Self {
    let name: String = name
    let organizationName: String? = nil
    let options: Project.Options = .options()
    let packages: [Package] = []
    let settings: Settings? = settings
    let targets: [Target] = targets
    let schemes: [Scheme] = []
    let fileHeaderTemplate: FileHeaderTemplate? = nil
    let additionalFiles: [FileElement] = additionalFiles
    let resourceSynthesizers: [ResourceSynthesizer] = resourceSynthesizers
    
    return .init(
      name: name,
      organizationName: organizationName,
      options: options,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes,
      fileHeaderTemplate: fileHeaderTemplate,
      additionalFiles: additionalFiles,
      resourceSynthesizers: resourceSynthesizers
    )
  }
}
