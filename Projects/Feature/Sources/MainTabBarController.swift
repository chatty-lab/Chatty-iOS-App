//
//  MainTabBarController.swift
//  Feature
//
//  Created by walkerhilla on 12/26/23.
//

import UIKit

public final class MainTabBarController: UITabBarController {
  private var tabNavigationControllers: [MainTabBarItemType: UINavigationController]
  
  init(tabNavigationControllers: [MainTabBarItemType : UINavigationController]) {
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
  
  private func configureTabBarController(controllers: [MainTabBarItemType: UINavigationController]) {
    let items = MainTabBarItemType.allCases.map { item -> UINavigationController in
      guard let tab = tabNavigationControllers[item] else { return UINavigationController() }
      return tab
    }
    
    viewControllers = items
  }
}
