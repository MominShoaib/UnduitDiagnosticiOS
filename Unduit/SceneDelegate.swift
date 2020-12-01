//
//  SceneDelegate.swift
//  Unduit
//
//  Created by Vivek Patel on 18/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit
import AVFoundation
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
        window?.overrideUserInterfaceStyle = .light
        // setDashboard()
//        let destination = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
//            self.window?.rootViewController = destination
        let destination = UIStoryboard.init(name: "Tutorial", bundle: nil).instantiateInitialViewController()
                        self.window?.rootViewController = destination
            guard let _ = (scene as? UIWindowScene) else { return }
    }
    /*
    private func setDashboard(){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rightMenuVC = mainStoryboard.instantiateViewController(withIdentifier: String(describing: RightMenuViewController.self))
        let centerVC = mainStoryboard.instantiateInitialViewController()
        
        let rootController: FAPanelController = mainStoryboard.instantiateViewController(withIdentifier: "FAPanelController") as! FAPanelController
        
        // rootController.configs.rightPanelWidth = 100
        rootController.configs.bounceOnRightPanelOpen = false
        
        _ = rootController.center(centerVC!).right(rightMenuVC)
        window?.rootViewController = rootController
         rootController.rightPanelPosition = .front
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                       let centerVC = mainStoryboard.instantiateInitialViewController()
//                       window?.rootViewController = centerVC
    }
*/
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

