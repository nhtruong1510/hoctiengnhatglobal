//
//  AppDelegate.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let pathForFile = Bundle.main.path(forResource: "TuVungJLPTN1_10", ofType: "sqlite"){
            VocabularyN1Service.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "TuVungJLPTN2_20", ofType: "sqlite"){
            VocabularyN2Service.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "TuVungJLPTN3_18", ofType: "sqlite"){
            VocabularyN3Service.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "TuVungJLPTN4_15", ofType: "sqlite"){
            VocabularyN4Service.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "TuVungJLPTN5_19", ofType: "sqlite"){
            VocabularyN5Service.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "Kaiwa13", ofType: "sqlite"){
            CommunicationService.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "KANJI2020_30", ofType: "sqlite"){
            KanjiService.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "NguPhapTiengNhat_7", ofType: "sqlite"){
            GrammarService.shared.loadInit(linkPath: pathForFile)
        }
        if let pathForFile = Bundle.main.path(forResource: "QuizJLPT", ofType: "sqlite"){
            QuizService.shared.loadInit(linkPath: pathForFile)
        }
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

