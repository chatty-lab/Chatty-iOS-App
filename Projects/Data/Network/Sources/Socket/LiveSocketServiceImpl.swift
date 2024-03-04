//
//  LiveSocketService.swift
//  DataNetworkInterface
//
//  Created by 윤지호 on 3/4/24.
//

import Foundation
import DataNetworkInterface
import DataStorageInterface
import DomainLiveInterface

import Starscream
import RxSwift

public enum LiveSocketError: Error {
  case connected
  case disconnected
  case jsonEncodeError
  case jsonDecodeError
  case error(Error?)
}

public final class LiveSocketServiceImpl: LiveSocketService {
  
  private let keychainService: KeychainServiceProtocol
  
  public init(keychainService: KeychainServiceProtocol) {
    self.keychainService = keychainService
  }
  
  
  private var socket: WebSocket?
  private var webSocketEventSubject: PublishSubject<MatchSocketResult>?
  
  
  
  public func connectSocket() -> PublishSubject<MatchSocketResult> {
    let webSocketEventSubject = PublishSubject<MatchSocketResult>()
    self.webSocketEventSubject = webSocketEventSubject

    if setupWebSocket() == false {
      webSocketEventSubject.onError(LiveSocketError.error(nil))
    }
    return webSocketEventSubject
  }
  
  public func disconnectSocket() {
    socket?.disconnect()
    socket?.delegate = nil
    webSocketEventSubject = nil
  }
  
  public func sendRequest(reqeust: MatchSocketRequestDTO) {
    do {
      let encodedData = try JSONEncoder().encode(reqeust)
      socket?.write(data: encodedData)
    } catch {
      webSocketEventSubject?.onError(LiveSocketError.jsonEncodeError)
    }
  }

  
  private func setupWebSocket() -> Bool {
    guard let url = URL(string: "") else { return false }
    var request = URLRequest(url: url)

    guard let accessToken: String = keychainService.read(type: .accessToken()) else { return false }
    let authValue = "Bearer" + " " + accessToken
    request.addValue(authValue, forHTTPHeaderField: "Authorization")
    
    socket = WebSocket(request: request)
    socket?.delegate = self
    socket?.connect()
    
    return true
  }
  
  
  
  deinit {
    socket?.disconnect()
    socket?.delegate = nil
    print("해제됨: LiveSocketService")
  }
}

extension LiveSocketServiceImpl: WebSocketDelegate {
  public func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
    switch event {
    case .connected(let dictionary):
      print("socket receive / connected - \(dictionary)")
      webSocketEventSubject?.onError(LiveSocketError.connected)
    case .disconnected(let string, let uInt16):
      print("socket receive / disconnected - \(string)")
      webSocketEventSubject?.onError(LiveSocketError.disconnected)
    case .text(let string):
      print("socket receive / string - \(string)")
    case .binary(let data):
      let decodedData = try! JSONDecoder().decode(MatchSocketResponseDTO.self, from: data)
      webSocketEventSubject?.onNext(decodedData.toDomain())
    case .pong(let data):
      break
    case .ping(let data):
      break
    case .error(let error):
      webSocketEventSubject?.onError(LiveSocketError.error(error ?? nil))
    case .viabilityChanged(let bool):
      break
    case .reconnectSuggested(let bool):
      break
    case .cancelled:
      print("websocket is canclled")
    case .peerClosed:
      break
    }
  }
}


