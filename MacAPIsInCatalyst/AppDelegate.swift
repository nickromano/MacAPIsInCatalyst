//
//  AppDelegate.swift
//  MacAPIsInCatalyst
//
//  Created by Nicholas Romano on 6/22/20.
//  Copyright © 2020 Ten Minute Wait. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    #if targetEnvironment(macCatalyst)
    let pluginPath = (Bundle.main.builtInPlugInsURL?.appendingPathComponent("MacBundle.bundle").path)!
    let bundle = Bundle(path: pluginPath)!
    bundle.load()

    // Load the principal class from the bundle
    // This is set in MacBundle/Info.plist
    let principalClass = bundle.principalClass as AnyObject as! NSObjectProtocol

    let workingDir = FileManager.default.temporaryDirectory

    // Add an example file for "ls" to return below
    try! "testing".write(to: workingDir.appendingPathComponent("test.txt"), atomically: true, encoding: .utf8)

    let selector = NSSelectorFromString("runShell:workingDirectory:")
    let result = principalClass.perform(selector, with: ["ls"], with: workingDir)!.takeUnretainedValue() as! [String: Any]
    let code = result["code"] as! Int
    let output = result["output"] as! String
    print(code, output)
    #endif

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

