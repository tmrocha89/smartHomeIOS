//
//  ServerRepositoryInterface.swift
//  smartHome
//
//  Created by TmRocha89 on 01/04/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import Foundation

protocol ServerRepositoryInterface {
    
    func configure(serverAddress:String, username:String, password:String) -> Bool
    
    func isConfigured()->Bool
    
    func getServerAddress() -> String
    
    func getUsername() -> String
    
    func getPassword() -> String
    
    func eraseConfiguration() -> Void
    
}