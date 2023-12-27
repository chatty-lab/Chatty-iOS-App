//
//  OnboardingRootController.swift
//  FeatureOnboarding
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import SharedDesignSystem

protocol OnboardingRootControllerDelegate: AnyObject {
  func signUp()
  func signIn()
}

final class OnboardingRootController: UIViewController {
  
  // MARK: - View
  private let mainView = OnboardingRootView()
  
  
  // MARK: - Life Method
  override func loadView() {
    super.loadView()
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView.delegate = self
    view.backgroundColor = UIColor(asset: Colors.basicWhite)
  }
  
  // MARK: - Delegate
  weak var delegate: OnboardingRootControllerDelegate?
}

extension OnboardingRootController: OnboardingRootViewDelegate {
  func didTapSignUp() {
    delegate?.signUp()
  }
  
  func didTapSignIn() {
    delegate?.signIn()
  }
}
