//
//  AuthResponseDTO.swift
//  CoreNetwork
//
//  Created by walkerhilla on 1/15/24.
//

import Foundation

public protocol CommonResponseDTO: Decodable {
  associatedtype Data: Decodable
  
  var code: Int { get }
  var status: String { get }
  var message: String { get }
  var data: Data { get }
}

