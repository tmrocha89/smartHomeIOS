//
//  ServerRepository.swift
//  smartHome
//
//  Created by TmRocha89 on 01/04/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import Foundation

private let serverRepository = ServerRepository()

class ServerRepository : ServerRepositoryInterface {
    
    static let instance:ServerRepository = ServerRepository()
    
    private let IS_SETUP:String = "isSetup"
    private let SERVER_ADDRESS:String = "ServerAddress"
    private let USERNAME:String = "Username"
    private let PASSWORD:String = "Password"
    
    private func voidConfiguration() {
        NSUserDefaults.standardUserDefaults().setObject("", forKey: SERVER_ADDRESS)
        NSUserDefaults.standardUserDefaults().setObject(false, forKey: IS_SETUP)
        NSUserDefaults.standardUserDefaults().setObject("", forKey: USERNAME)
        NSUserDefaults.standardUserDefaults().setObject("", forKey: PASSWORD)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func configure(serverAddress: String, username: String, password: String) -> Bool {
        
        if serverAddress.isEmpty {
            return false
        }
        
        NSUserDefaults.standardUserDefaults().setObject(serverAddress, forKey: SERVER_ADDRESS)
        NSUserDefaults.standardUserDefaults().setObject(true, forKey: IS_SETUP)
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: USERNAME)
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: PASSWORD)
        NSUserDefaults.standardUserDefaults().synchronize()
        return true
    }
    
    func isConfigured() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(IS_SETUP)
    }
    
    func getServerAddress() -> String {
        return NSUserDefaults.standardUserDefaults().stringForKey(SERVER_ADDRESS)!
    }
    
    func getUsername() -> String {
        return NSUserDefaults.standardUserDefaults().stringForKey(USERNAME)!
    }
    
    func getPassword() -> String {
        return NSUserDefaults.standardUserDefaults().stringForKey(PASSWORD)!
    }
    
    
    func eraseConfiguration() {
        voidConfiguration()
    }
    
}