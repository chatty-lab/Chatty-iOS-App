//
//  LiveEditConditionModalReactor.swift
//  FeatureLive
//
//  Created by 윤지호 on 2/29/24.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

import DomainCommon
import DataNetworkInterface
import DomainLiveInterface

public final class LiveEditConditionModalReactor: Reactor {
  private let connectMatchUserCase: ConnectMatchUseCase
  private var socketResultSubject: PublishSubject<MatchSocketResult> = .init()
  private var isSocketOpenedSubject: PublishSubject<Void> = .init()
  
  private let disposeBag = DisposeBag()
  
  public enum Action {
    // LiveEditGenderConditionModal
    case selectGender(MatchGender)
    
    // LiveEditAgeConditionModal
    case selectAge(Int)
    
    // LiveMatchingController
    case matchingStart
    case matchSocketOpened
    case matchingSuccess
    case getError(Error)
  }
  
  public enum Mutation {
    case setGenderCondition(MatchGender)
    case setAgeCondition(Int)
    
    case setMathcingState(MatchingState)
    case setError(ErrorType?)
  }
  
  public struct State {
    var matchConditionState: MatchConditionState
    var matchingState: MatchingState = .ready
    var errorState: ErrorType? = nil
  }
  
  public var initialState: State
  
  init(matchState: MatchConditionState, connectMatchUserCase: ConnectMatchUseCase) {
    self.connectMatchUserCase = connectMatchUserCase
    self.initialState = State(matchConditionState: matchState)
  }
}

extension LiveEditConditionModalReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .selectGender(let matchGender):
      return .just(.setGenderCondition(matchGender))
    case .selectAge(let int):
      return .just(.setAgeCondition(int))
      
      /// 1. 소켓 연결 확인 Subject
    case .matchingStart:
      self.isSocketOpenedSubject = connectMatchUserCase.getSocketState()
      bindSocketOpened()
      return .just(.setMathcingState(.ready))
      /// 2. 소켓 연결이 확인되면 bind()
    case .matchSocketOpened:
      self.socketResultSubject = connectMatchUserCase.getSocket()
      bindSocket()
      /// 3. 연결된 소켓으로 sendData
      return connectMatchUserCase.sendData(
        minAge: currentState.matchConditionState.ageRange.startAge,
        maxAge: currentState.matchConditionState.ageRange.endAge,
        gender: currentState.matchConditionState.gender.requestString,
        scope: nil,
        category: "category",
        blueCheck: false
      )
      .asObservable()
      .map { _ -> Mutation in
        return .setMathcingState(.matching)
      }
      .catch { error -> Observable<Mutation> in
        return error.toMutation()
      }
    case .matchingSuccess:
      return .just(.setMathcingState(.successMatching))
    case .getError(let error):
      return error.toMutation()
    }
  }
  
  private func bindSocketOpened() {
    isSocketOpenedSubject.subscribe(
      with: self,
      onNext: { reactor, _ in
        reactor.action.onNext(.matchSocketOpened)
      },
      onError: { reactor, error in
        print("error - \(error)")
        reactor.action.onNext(.getError(error))
      })
  .disposed(by: disposeBag)
  }
  
  private func bindSocket() {
    socketResultSubject.subscribe(
        with: self,
        onNext: { reactor, matchRes in
          print("reactor - matchSocket matchRes - \(matchRes)")
          reactor.action.onNext(.matchingSuccess)
        },
        onError: { reactor, error in
          reactor.action.onNext(.getError(error))
        })
    .disposed(by: disposeBag)
  }
  
  
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setGenderCondition(let matchGender):
      newState.matchConditionState.gender = matchGender
    case .setAgeCondition(let int):
      newState.matchConditionState.ageRange.startAge = int
    case .setMathcingState(let matchingState):
      newState.matchingState = matchingState
    case .setError(let error):
      newState.errorState = error
    }
    return newState
  }
  
  public enum ErrorType: Error {
    case socketDisconnected
    case socketTokenExpiration
    case socketSetupError
    case unknownError
  }
}

extension Error {
  func toMutation() -> Observable<LiveEditConditionModalReactor.Mutation> {
    let errorMutation: Observable<LiveEditConditionModalReactor.Mutation> = {
      if let error = self as? LiveSocketError {
        switch error {
        case .disconnected:
          return .just(.setError(.socketDisconnected))
        case .accessTokenExpiration:
          return .just(.setError(.socketTokenExpiration))
        case .setupError:
          return .just(.setError(.socketSetupError))
        default:
          return .just(.setError(.unknownError))
        }
      }
      
      if let error = self as? NetworkError {
        switch error.errorCase {
        default:
          return .just(.setError(.unknownError))
        }
      }
      
      return .just(.setError(.unknownError))
    }()
    
    return Observable.concat([
      errorMutation,
      .just(.setError(nil))
    ])
  }
}
