import ProjectDescription
import DependencyPlugin
import ConfigurationPlugin

public extension Project {
  static func makeModule(name: String, targets: [Target], settings: Settings? = nil, additionalFiles: [FileElement] = []) -> Self {
    let name: String = name
    let organizationName: String? = nil
    let options: Project.Options = .options()
    let packages: [Package] = []
    let settings: Settings? = .settings(
      configurations: [
        .debug(name: .debug),
        .release(name: .release)
      ]
    )
    let targets: [Target] = targets
    let schemes: [Scheme] = []
    let fileHeaderTemplate: FileHeaderTemplate? = nil
    let additionalFiles: [FileElement] = additionalFiles
    let resourceSynthesizers: [ResourceSynthesizer] = []
    
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
