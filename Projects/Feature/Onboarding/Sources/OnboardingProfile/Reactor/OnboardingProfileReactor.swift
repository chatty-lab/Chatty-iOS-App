//
//  OnboardingProfileViewModel.swift
//  FeatureOnboardingInterface
//
//  Created by 윤지호 on 12/31/23.
//

import UIKit
import RxSwift
import ReactorKit
import DataNetworkInterface
import DomainUserInterface


public final class OnboardingProfileReactor: Reactor {
  private let saveProfileDataUseCase: SaveProfileDataUseCase
  private let getUserDataUseCase: GetUserDataUseCase
  
  /// 뷰에서 수행할 수 있는 사용자의 액션
  public enum Action {
    case toggleGender(Gender)
    case selectBirth(Date)
    case toggleMBTI(MBTISeletedState, Bool)
    case selectImage(UIImage)
    case tabImagePicker
    case tabTag(String)
    case tabContinueButton
    case didPushed
  }
  
  /// 화면의 상태가 변화하는 요인
  public enum Mutation {
    case inputedGender(Gender)
    case inputedBirth(Date)
    case toggleMBTI(MBTISeletedState, Bool)
    case inputedImage(UIImage)
    case tabImagePicker
    case tabTag(String)
    case isSaveSuccess
    case didPushed
    case isLoading(Bool)
    case setError(ErrorType?)
  }
  
  /// 화면의 상태를 나타내는 구조체
  public struct State {
    var viewState: ProfileType
    var profileData: ProfileState
    var isContinueEnabled: Bool = false
    var isPickingImage: Bool = false
    var isSuccessSave: Bool = false
    var interestTags: [String] = []
    var isLoading: Bool = false
    var errorState: ErrorType? = nil
  }
  public var initialState: State
  
  init(saveProfileDataUseCase: SaveProfileDataUseCase, getUserDataUseCase: GetUserDataUseCase, profileType: ProfileType) {
    self.saveProfileDataUseCase = saveProfileDataUseCase
    self.getUserDataUseCase = getUserDataUseCase
    let state: State = {
      var state = State(
        viewState: profileType,
        profileData: ProfileState(userData: getUserDataUseCase.execute())
      )
      switch state.viewState {
      case .gender:
        state.isContinueEnabled = state.profileData.gender != .none
      case .birth:
        state.isContinueEnabled = true
      case .profileImage:
        state.isContinueEnabled = state.profileData.porfileImage != nil
      case .interest:
        state.interestTags = ["여행", "드라마/영화", "운동/스포츠", "독서", "맛집/카페", "제테크", "게임", "뷰티", "패션", "웹툰/애니", "직무/커리어", "문화/공연", "음악", "요리", "반려동물", "자기개발" ,"연애/사랑"]
        state.isContinueEnabled = state.profileData.interest.count > 2
      case .mbti:
        state.isContinueEnabled = state.profileData.mbti.didSeletedAll
      case .none:
        print("none")
      }
      return state
    }()
    self.initialState = state
  }
}

extension OnboardingProfileReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .toggleGender(let gender):
      return .just(.inputedGender(gender))
    case .selectBirth(let date):
      return .just(.inputedBirth(date))
    case .selectImage(let image):
      return .just(.inputedImage(image))
    case .tabImagePicker:
      return .just(.tabImagePicker)
    case .tabTag(let tag):
      return .just(.tabTag(tag))
    case .didPushed:
      return .just(.didPushed)
    case .toggleMBTI(let mbti, let state):
      return .just(.toggleMBTI(mbti, state))
    case .tabContinueButton:
      switch currentState.viewState {
      case .gender, .birth, .profileImage, .interest, .none:
        return .just(.isSaveSuccess)
      case .mbti:
        let profileData = self.currentState.profileData
        return .concat([
          .just(.isLoading(true)),
          saveProfileDataUseCase.excute(
            gender: profileData.gender.requestString,
            birth: profileData.birth.toStringYearMonthDay(),
            imageData: profileData.porfileImage?.toProfileRequestData() ?? nil,
            mbti: profileData.mbti.requestString
          )
          .asObservable()
          .map { _ in .isSaveSuccess }
            .catch { error -> Observable<Mutation> in
              return error.toMutation()
            },
          .just(.isLoading(false))
        ])
      }
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .inputedGender(let gender):
      newState.profileData.gender = gender
      newState.isContinueEnabled = true
    case .inputedBirth(let date):
      newState.profileData.birth = date
      newState.isContinueEnabled = true
    case .inputedImage(let image):
      newState.profileData.porfileImage = image
      newState.isContinueEnabled = true
    case .tabImagePicker:
      newState.isPickingImage = true
    case .toggleMBTI(let mbti, let state):
      newState.profileData.mbti.setMBTI(mbti: mbti, state: state)
      newState.isContinueEnabled = newState.profileData.mbti.didSeletedAll
    case .tabTag(let tag):
      if let duplicatedIndex = newState.profileData.interest.firstIndex(where: { $0 == tag }) {
        newState.profileData.interest.remove(at: duplicatedIndex)
      } else {
        if newState.profileData.interest.count < 3 {
          newState.profileData.interest.append(tag)
        }
      }
      newState.isContinueEnabled = newState.profileData.interest.count > 2
    case .didPushed:
      newState.isSuccessSave = false
      newState.isPickingImage = false
    case .isLoading(let bool):
      newState.isLoading = bool
      
      /// 저장 api 통신 혹은 다음뷰로 가는 코드
    case .isSaveSuccess:
      newState.isSuccessSave = true
    case .setError(let error):
      newState.errorState = error
    }
    return newState
  }
  
  private func getInterestTags() -> [String] {
    return ["여행", "드라마/영화", "운동/스포츠", "독서", "맛집/카페", "제테크", "게임", "뷰티", "패션", "웹툰/애니", "직무/커리어", "문화/공연", "음악", "요리", "반려동물", "자기개발" ,"연애/사랑"]
  }
  
  public enum ErrorType: Error {
    case duplicatedNickname
    case unknownError
  }
}

extension Error {
  func toMutation() -> Observable<OnboardingProfileReactor.Mutation> {
    let errorMutation: Observable<OnboardingProfileReactor.Mutation> = {
      guard let error = self as? NetworkError else {
        return .just(.setError(.unknownError))
      }
      switch error.errorCase {
      case .E006AlreadyExistNickname:
        return .concat([
          .just(.setError(.duplicatedNickname))
        ])
      default:
        return .just(.setError(.unknownError))
      }
    }()
    
    return Observable.concat([
      errorMutation,
      .just(.setError(nil))
    ])
  }
}
