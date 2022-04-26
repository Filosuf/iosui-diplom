//
//  ViewController.swift
//  Navigation
//
//  Created by 1234 on 24.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        tabBar.tintColor = UIColor(named: "\(CustomColors.purple)")
    }

    func setupTabBar() {

        let habitsViewController = createNavController(vc: HabitsViewController(), itemName: "Привычки", itemImage: "rectangle.grid.1x2.fill")
        let infoViewController = createNavController(vc: InfoViewController(), itemName: "Информация", itemImage: "person.crop.circle")
        habitsViewController.navigationBar.prefersLargeTitles = true
//        profileViewController.navigationBar.isHidden = false
        viewControllers = [habitsViewController, infoViewController]
    }

    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {

        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item

        return navController
    }
}

