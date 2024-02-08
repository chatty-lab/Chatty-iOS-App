//
//  RouterProtocol.swift
//  DataNetworkInterface
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import Moya

public protocol RouterProtocol: TargetType {
  var basePath: String { get }
}
