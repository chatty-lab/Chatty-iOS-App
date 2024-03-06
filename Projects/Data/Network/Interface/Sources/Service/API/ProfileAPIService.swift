//
//  ProfileAPIService.swift
//  DataNetworkInterface
//
//  Created by HUNHIE LEE on 2/26/24.
//

import Foundation
import Moya
import RxSwift

public protocol ProfileAPIService: APIServiceProtocol {
  var provider: MoyaProvider<ProfileAPIRouter> { get }
  func request<Model: Decodable>(endPoint: ProfileAPIRouter, responseDTO: Model.Type) -> Single<Model>
}
