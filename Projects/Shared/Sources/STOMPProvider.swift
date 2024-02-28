//
//  STOMPProvider.swift
//  FeatureChatInterface
//
//  Created by HUNHIE LEE on 2/14/24.
//

import Foundation
import RxSwift
import Starscream

public class STOMPProvider {
  public static let shared = STOMPProvider()
  private var socket: WebSocket
  private let disposeBag = DisposeBag()
  
  public let messageReceived = PublishSubject<String>()
  public let connectionStatusChanged = PublishSubject<Bool>()
  public let errorOccurred = PublishSubject<Error>()
  
  init() {
    var request = URLRequest(url: URL(string: "wss://dev.api.chattylab.org/ws")!)
    request.timeoutInterval = 5
    self.socket = WebSocket(request: request)
    setupSocketResponseHandling()
    self.socket.connect()
  }
  
  private func setupSocketResponseHandling() {
    socket.rx.response
      .subscribe(onNext: { [weak self] event in
        guard let self else { return }
        switch event {
        case .text(let text):
          print("메시지 수신: \(text)")
          self.messageReceived.onNext(text)
        case .connected:
          print("연결됨ㅁㄴㅇㅁㄴㅇ")
          self.connectionStatusChanged.onNext(true)
        case .disconnected(_, _):
          print("연결해제됨")
          self.connectionStatusChanged.onNext(false)
        case .error(let error):
          guard let error else { return }
          self.errorOccurred.onNext(error)
        default:
          break
        }
      })
      .disposed(by: disposeBag)
  }
  
  deinit {
    self.socket.disconnect()
  }
  
  public func send<Router: STOMPRouter>(_ router: Router) -> Observable<Void> {
    return connectionStatusChanged
      .filter { $0 }
      .take(1)
      .flatMap { [weak self] _ -> Observable<Void> in
        guard let self = self else { return .empty() }
        let frame = self.constructFrame(from: router)
        return self.socket.rx.write(string: frame)
      }
  }
  
  private func constructFrame(from router: STOMPRouter) -> String {
    var frame = "\(router.command.rawValue)\n"
    
    if !router.destination.isEmpty {
      frame += "destination:\(router.destination)\n"
    }
    
    for (key, value) in router.headers {
      frame += "\(key):\(value)\n"
    }
    
    frame += "\n"
    
    if let body = router.body {
      frame += body
    }
    
    frame += "\0"
    return frame
  }
}
