//
//  NetworkCommunication.swift
//  smartHome
//
//  Created by TmRocha89 on 31/03/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import Foundation

class NetworkCommunication {
    
    
    private func performGetAction(address:String, endPoint:String) -> Void {
        let address:String? = NSUserDefaults.standardUserDefaults().stringForKey("ServerAddress")!
        print("Estou a executar uma operacao no servidor \(address)")
        
        
        let url = NSURL(string: endPoint)
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            do {
                if let ipString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    print("RESPONSE: \(response!)")
                    print("DATA: \(data!)")
                }
            } catch {
                print("ERROR: \(error)")
            }
            
        }).resume()
    }
    
    func performAction() -> Void {
        let address:String? = NSUserDefaults.standardUserDefaults().stringForKey("ServerAddress")!
        print("Estou a executar uma operacao no servidor \(address)")
        
        let endPointString = "http://"+address!+"/on"
        
        print(endPointString)
        
        let url = NSURL(string: endPointString)
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            do {
                if let ipString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    print("RESPONSE: \(response!)")
                    print("DATA: \(data!)")
                }
            } catch {
                print("ERROR: \(error)")
            }
            
        }).resume()
        
    }
    
    func getDevices(callback:((json:NSMutableArray?, error:ErrorType?)->Void)!) -> Void {
    
        let address:String? = NSUserDefaults.standardUserDefaults().stringForKey("ServerAddress")!
        print("Estou a executar uma operacao no servidor \(address)")
        
        let endPointString = "http://"+address!+"/devices"
        
        print(endPointString)
        
        let url = NSURL(string: endPointString)
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if (error != nil) {
                print("ERROR: \(error)")
                callback(json:nil, error: error)
                return 
            }
            do {
                if let ipString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    
                    let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSMutableArray //NSDictionary
                    
                    callback(json:jsonArray, error: nil)
                }
            } catch {
                print("ERROR: \(error)")
            }
            
        }).resume()
        
    }
    
    func performOnOff(device:Device, callback:((deviceID:Int, isActive:Bool)->Void)) -> Void {
        
        let address:String? = NSUserDefaults.standardUserDefaults().stringForKey("ServerAddress")!
        print("Estou a executar uma operacao no servidor \(address)")
        
        var endOperation = device.status ? "/off/" : "/on/"
        endOperation += (String(device.port-1))
        
        print("porta do disp \(device.port)")
        
        let endPointString = "http://"+address! + endOperation
        
        print(endPointString)
        
        let url = NSURL(string: endPointString)
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url!, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            do {
                if let ipString = NSString(data: data!, encoding: NSUTF8StringEncoding) {
                    
                    let jsonDevice = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                    
                    callback(deviceID: device.port, isActive: jsonDevice["status"] as! Bool)
                }
            } catch {
                print("ERROR: \(error)")
            }
            
        }).resume()
        
    }
    
}