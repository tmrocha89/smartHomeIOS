//
//  Device.swift
//  smartHome
//
//  Created by TmRocha89 on 31/03/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import Foundation

class Device {
    var description:String
    var port:Int
    var active:Bool
    var status:Bool
    
    init(desc:String, port:Int, active:Bool, status:Bool) {
        self.description = desc
        self.port = port
        self.active = active
        self.status = status
    }
    
}