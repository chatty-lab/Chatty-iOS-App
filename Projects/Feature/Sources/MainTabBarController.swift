//
//  MainTabBarController.swift
//  Feature
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit
import SharedDesignSystem

public final class MainTabBarController: UITabBarController {
  private var tabNavigationControllers: [MainTabBarItemType: BaseNavigationController]
  
  init(tabNavigationControllers: [MainTabBarItemType : BaseNavigationController]) {
    self.tabNavigationControllers = tabNavigationControllers
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    configureTabBarController(controllers: tabNavigationControllers)
  }
  
  private func configureTabBarController(controllers: [MainTabBarItemType: BaseNavigationController]) {
    let items = MainTabBarItemType.allCases.map { item -> BaseNavigationController in
      guard let tab = tabNavigationControllers[item] else { return BaseNavigationController() }
      return tab
    }
    
    viewControllers = items
  }
}
