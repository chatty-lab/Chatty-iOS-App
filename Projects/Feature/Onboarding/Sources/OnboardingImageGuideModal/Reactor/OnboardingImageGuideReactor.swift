//
//  Reactor.swift
//  FeatureOnboarding
//
//  Created by 윤지호 on 1/7/24.
//
import UIKit
import RxSwift
import ReactorKit

public final class OnboardingImageGuideReactor: Reactor {
  
  public enum Action {
    case toggleSegment(Bool)
    case tabPresentAlbumButton
    case seletedImage(UIImage?)
    case didPushed
  }
  
  public enum Mutation {
    case toggleSegment(Bool)
    case tabPresentAlbumButton
    case seletedImage(UIImage?)
    case didPushed
  }
  
  public struct State {
    var seletedImage: UIImage? = nil
    var isFirstSegment: Bool = true
    var isSeleted = false
  }
  
  public var initialState: State = State()
}

extension OnboardingImageGuideReactor {
  public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .toggleSegment(let bool):
      return .just(.toggleSegment(bool))
    case .tabPresentAlbumButton:
      return .just(.tabPresentAlbumButton)
    case .didPushed:
      return .just(.didPushed)
    case .seletedImage(let image):
      return .just(.seletedImage(image))
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .toggleSegment(let bool):
      newState.isFirstSegment = bool
    case .tabPresentAlbumButton:
      newState.isSeleted = true
    case .didPushed:
      newState.isSeleted = false
    case .seletedImage(let image):
      newState.seletedImage = image
    }
    return newState
  }
}
