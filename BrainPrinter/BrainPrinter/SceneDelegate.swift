//
//  SceneDelegate.swift
//  BrainPrinter
//
//  Created by Kirill on 29.08.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootViewController = makeRootViewController()
            window.rootViewController = rootViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    /// Instantiates MainViewController from Main Storyboard,
    /// and connects with Router, MainScreenPresenter and ResourceService
    func makeRootViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        let router = Router(navigationController: navigationController)
        let resourceService = ResourceService()
        let presenter = MainScreenPresenter(sourceTypes: resourceService.sourceTypes, router: router)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "MainScreenViewController") as! MainScreenViewController
        rootViewController.configure(presenter: presenter)
        
        navigationController.viewControllers = [rootViewController]
        return navigationController
    }

}

