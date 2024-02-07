//
//  OnboardingPhoneAuthenticationReactor.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 1/5/24.
//

import UIKit
import RxSwift
import ReactorKit
import DomainAuthInterface
import DomainUserInterface
import DataNetworkInterface
import Shared

public final class OnboardingPhoneAuthenticationReactor: Reactor {
  private let type: OnboardingAuthType
  
  private let sendVerificationCodeUseCase: SendVerificationCodeUseCase
  private let getDeviceIdUseCase: GetDeviceIdUseCase
  private let signUseCase: SignUseCase
  
  public enum Action {
    case phoneNumberEntered(String)
    case sendSMS
    case sendVerificationCode(String)
  }
  
  public enum Mutation {
    case setSendSMSState(AsyncState<Void>)
    case setSendSMSButton(PhoneNumberValidationResult)
    case setPhoneNumber(String)
    case setSendVerificationCodeState(AsyncState<Void>)
    case setError(ErrorType)
  }
  
  public struct State {
    var phoneNumber: String = ""
    var isSendSMSButtonEnabled: Bool = false
    var sendSMSState: AsyncState<Void> = .idle
    var sendVerificationCodeState: AsyncState<Void> = .idle
    var errorState: ErrorType? = nil
  }
  
  public let initialState: State = State()
  
  public init(type: OnboardingAuthType, sendVerificationCodeUseCase: SendVerificationCodeUseCase, getDeviceIdUseCase: GetDeviceIdUseCase, signUseCase: SignUseCase) {
    self.type = type
    self.sendVerificationCodeUseCase = sendVerificationCodeUseCase
    self.getDeviceIdUseCase = getDeviceIdUseCase
    self.signUseCase = signUseCase
  }
}

extension OnboardingPhoneAuthenticationReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .phoneNumberEntered(let phoneNumber):
      let isPhoneNumberValid = isPhoneNumberValid(phoneNumber)
      return .from([.setSendSMSButton(isPhoneNumberValid), .setPhoneNumber(phoneNumber)])
    case .sendSMS:
      return Observable.concat([
        .just(.setSendSMSState(.loading)),
        self.sendVerificationCodeUseCase.execute(mobileNumber: self.currentState.phoneNumber)
          .asObservable()
          .map { .setSendSMSState(.success) },
        .just(.setSendSMSState(.idle))
      ])
    case .sendVerificationCode(let code):
      switch type {
      case .signIn:
        return Observable.concat([
          signUseCase.requestLogin(mobileNumber: self.currentState.phoneNumber, authenticationNumber: code)
            .asObservable()
            .map { _ in .setSendVerificationCodeState(.success) },
          .just(.setSendVerificationCodeState(.idle))
        ])
      case .signUp:
        return Observable.concat([
          signUseCase.requestJoin(mobileNumber: self.currentState.phoneNumber, authenticationNumber: code)
            .asObservable()
            .map { _ in .setSendVerificationCodeState(.success) },
          .just(.setSendVerificationCodeState(.idle))
        ])
      }
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setSendSMSState(let state):
      newState.sendSMSState = state
    case .setSendSMSButton(let result):
      newState.isSendSMSButtonEnabled = result == .valid ? true : false
    case .setPhoneNumber(let phoneNumber):
      newState.phoneNumber = phoneNumber
    case .setSendVerificationCodeState(let state):
      newState.sendVerificationCodeState = state
    case .setError(let state):
      newState.errorState = state
    }
    return newState
  }
  
  private func isPhoneNumberValid(_ phoneNumberStr: String) -> PhoneNumberValidationResult {
    guard let _ = Int(phoneNumberStr) else { return .notANumber }
    guard phoneNumberStr.count == 11 else { return .lengthNotValid }
    return .valid
  }
  
  public enum PhoneNumberValidationResult {
    case valid
    case notANumber
    case lengthNotValid
  }
  
  public enum AsyncState<T> {
    case idle
    case loading
    case success
  }
  
  public enum ErrorType: Error {
    case invalidPhoneNumber
    case invalidVerificationCode
    case smsFailed
    case unknownError
  }
}

extension NetworkError {
  func toMutation() -> OnboardingPhoneAuthenticationReactor.Mutation {
    switch self.errorCase {
    case .E005NaverSMSFailed:
      return .setError(.smsFailed)
    case .E007SNSAuthenticationFailed:
      return .setError(.invalidVerificationCode)
    default:
      return .setError(.unknownError)
    }
  }
}
