//
//  InstTabBarController.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/28/23.
//

import UIKit

class InstTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor         = .black
        UINavigationBar.appearance().tintColor  = .black
        viewControllers                         = [searchVC(), tapVC1(), tapVC2(), tapVC3(), tapVC4()]
        
    }
    
    func searchVC() -> UINavigationController {
    
        let searchVC = MainVC()
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        searchVC.navigationController?.navigationBar.prefersLargeTitles = false
        return UINavigationController(rootViewController: searchVC)
    }
    
    func tapVC1() -> UINavigationController {
        let tap1 = VC1()
        tap1.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        tap1.navigationController?.navigationBar.prefersLargeTitles = false
        return UINavigationController(rootViewController: tap1)
    }
    
    
    func tapVC2() -> UINavigationController {
        
        let tap2 = VC2()
        tap2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.square"), tag: 2)
        tap2.navigationController?.navigationBar.prefersLargeTitles = false
        return UINavigationController(rootViewController: tap2)
    }
    
    func tapVC3() -> UINavigationController {
        
        let tap3 = VC3()
        tap3.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "play.square"), tag: 3)
        tap3.navigationController?.navigationBar.prefersLargeTitles = false
        return UINavigationController(rootViewController: tap3)
    }
    
    func tapVC4() -> UINavigationController {
        
        let tap4 = VC4()
        tap4.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 4)
        tap4.navigationController?.navigationBar.prefersLargeTitles = false
        return UINavigationController(rootViewController: tap4)
    }
}
