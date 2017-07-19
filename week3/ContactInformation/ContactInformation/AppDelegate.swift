//
//  AppDelegate.swift
//  ContactInformation
//
//  Created by 오민호 on 2017. 7. 19..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let contactTableViewController = ContactTableViewController()
        self.window?.rootViewController = contactTableViewController
        
        let initContacts = [Contact("김동민"),Contact("김민준"),Contact("김상민"),Contact("문진희"),Contact("박진주"),Contact("박현호"),Contact("서형숙"),Contact("엄중한"),Contact("오지예"),Contact("이민영"),Contact("이혜진"),Contact("이승준"),Contact("임경호"),Contact("장규범"),Contact("전수민"),Contact("최희석"),Contact("홍순찬"),Contact("황진섭")]
        
        contactTableViewController.contactList = initContacts
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

