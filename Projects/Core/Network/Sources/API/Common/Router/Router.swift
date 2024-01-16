//
//  Router.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/16/24.
//

import Foundation
import Moya

public protocol Router: TargetType {
  var basePath: String { get }
}
