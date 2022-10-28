//
//  SceneDelegate.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var timer: Timer?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        setIntitialScreen()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(checkValidHours(timer:)),
                                             userInfo: [:],
                                             repeats: true)

        
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
    }

    func setIntitialScreen() {
        let mainVC = PetListViewController(nibName:"PetListViewController", bundle:nil)
        let navController = UINavigationController(rootViewController: mainVC)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }

    func currentTime(startTime: String, endTime: String) -> Bool {
        guard let start = Formatter.isToday.date(from: startTime),
              let end = Formatter.isToday.date(from: endTime) else {
            return false
        }
        return DateInterval(start: start, end: end).contains(Date())
    }
    
    
    @objc func checkValidHours(timer: Timer!) {
        
        let response = AppUtility.shared.getWorkingHours()
        let matchPattern = hourRegex
        let regexPattern = try! NSRegularExpression(pattern: matchPattern)
        
        if let match = regexPattern.matches(in: response, range: .init(response.startIndex..., in: response)).first,
                match.numberOfRanges == 3 {
                let start = match.range(at: 1)
                let end = match.range(at: 2)
    
                if !currentTime(startTime: "\(response[Range(start, in: response)!])", endTime: "\(response[Range(end, in: response)!])") {
                    timer.invalidate()
                    window!.rootViewController?.showAlert(title: alertErrorTitle, message: alertMessage, actionTitles: ["Sure"], actions:[{firstAction in
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    },{secondAction in
                    }, nil])
                }
                
            }


    }
    
}

