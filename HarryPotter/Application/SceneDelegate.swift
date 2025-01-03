//
//  SceneDelegate.swift
//  HarryPotter
//
//  Created by Elif Parlak on 28.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBar()
        window?.makeKeyAndVisible()
        
        configureNavBar()
    }
    
    private func configureNavBar() {
        UINavigationBar.appearance().tintColor = .systemBrown
    }
    
    private func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBrown
        UITabBar.appearance().backgroundColor = .systemBackground
        tabBar.viewControllers = [createHomeNavigationControlller(), createCharactersNavigationController()]
        return tabBar
    }
    
    private func createHomeNavigationControlller() -> UINavigationController {
        let homeViewController = HomeViewController(viewModel: HomeViewModel(networkService: networkService))
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        return UINavigationController(rootViewController: homeViewController)
    }
    
    private func createCharactersNavigationController() -> UINavigationController {
        let charactersViewController = CharactersViewController(viewModel: CharactersViewModel(networkService: networkService))
        charactersViewController.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.3.fill"), tag: 1)
        return UINavigationController(rootViewController: charactersViewController)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

