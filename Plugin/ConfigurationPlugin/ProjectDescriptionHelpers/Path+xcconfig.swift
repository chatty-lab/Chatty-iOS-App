import ProjectDescription

public extension ProjectDescription.Path {
  static func relativeToXCConfig(type: ProjectDeployTarget) -> Self {
    return .relativeToRoot("Projects/App/config/chatty.\(type.rawValue).xcconfig")
  }
  static var sharedXcconfig: Self {
    return .relativeToRoot("config/chatty.shared.xcconfig")
  }
}
