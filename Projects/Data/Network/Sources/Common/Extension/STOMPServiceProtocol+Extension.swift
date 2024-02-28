//
//  STOMPService+Extension.swift
//  DataNetwork
//
//  Created by HUNHIE LEE on 2/15/24.
//

import Foundation
import RxSwift
import Starscream
import DataNetworkInterface

public extension Observable where Element == WebSocketEvent {
  func handleResponse() -> Observable<WebSocketEventResult> {
    return flatMap { event -> Observable<WebSocketEventResult> in
      switch event {
      case .text(let string):
        return self.decodeTextModel(string)
          .map { WebSocketEventResult.text($0) }
      case .connected:
        return .just(.connectionChanged(Connection: true))
      case .disconnected(let reason, let code):
        let errorInfo = (reason: reason, code: code)
        return .just(.connectionChanged(Connection: false, errorInfo: errorInfo))
      case .error(let error):
        return .just(.error(error))
      default:
        return .error(NSError(domain: "UnhandledWebSocketEvent", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unhandled WebSocket event."]))
      }
    }
  }
  
  private func decodeTextModel(_ text: String) -> Observable<ChatMessageResponse> {
    do {
      let data = Data(text.utf8)
      let decodedModel = try JSONDecoder().decode(ChatMessageResponse.self, from: data)
      return .just(decodedModel)
    } catch {
      return .error(NSError(domain: "DecodingError", code: -2))
    }
  }
}
