//
//  MainTabBarController.swift
//  Documents
//
//  Created by Mihail on 20.05.2021.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

        override func viewDidLoad() {
            super.viewDidLoad()

            self.delegate = self

        }


   func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 0 {
            (viewController as! ViewController).tableView.reloadData()
        }
    }

}
