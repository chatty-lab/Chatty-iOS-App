//
//  OnboardingPhoneAuthenticationReactor.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 1/5/24.
//

import UIKit
import RxSwift
import ReactorKit

public final class OnboardingPhoneAuthenticationReactor: Reactor {
  public enum Action {
    case phoneNumberEntered(String)
    case sendSMS
  }
  
  public enum Mutation {
    case sendSMS
    case setSendSMSButton(PhoneNumberValidationResult)
    case setPhoneNumber(String)
  }
  
  public struct State {
    var phoneNumber: String = ""
    var isSendSMSButtonEnabled: Bool = false
  }
  
  public let initialState: State = State()
  
  public init() { }
}

extension OnboardingPhoneAuthenticationReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .phoneNumberEntered(let phoneNumber):
      let isPhoneNumberValid = isPhoneNumberValid(phoneNumber)
      return .from([.setSendSMSButton(isPhoneNumberValid), .setPhoneNumber(phoneNumber)])
    case .sendSMS:
      return .just(.sendSMS)
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .sendSMS:
      break
    case .setSendSMSButton(let result):
      newState.isSendSMSButtonEnabled = result == .valid ? true : false
    case .setPhoneNumber(let phoneNumber):
      newState.phoneNumber = phoneNumber
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
}
