//
//  ViewController.swift
//  smartHome
//
//  Created by TmRocha89 on 31/03/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    let network:NetworkCommunication = NetworkCommunication()
    var devices: [Device] = [Device]()
    var repo = ServerRepository.instance
    
    override func viewDidAppear(animated: Bool) {
        if(!repo.isConfigured()) {
            self.performSegueWithIdentifier("serverView", sender: self)
        } else {
            network.getDevices(printTest)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        devices.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let devCell : DevicesCell = tableView.dequeueReusableCellWithIdentifier("DeviceCell") as! DevicesCell
        let device = devices[indexPath.row]
        devCell.setCell(device.description, port: device.port, status: device.status, switchActive: device.active)

        return devCell
    }
    
    @IBAction func clearServerConfiguration(sender: AnyObject) {
        repo.eraseConfiguration()
        self.viewDidAppear(true)
    }
    
    @IBAction func switchOnOff(sender: UISwitch) {
        network.performOnOff(devices[sender.tag-1], callback: changeSwitchState)
    }

    @IBAction func onOffBtn(sender: AnyObject) {
        network.performAction()
    }
    
    func changeSwitchState(deviceID:Int, isActive:Bool) -> Void {
        print("alterou o switch da posicao \(deviceID)")
        devices[deviceID-1].status = isActive;
        refreshUI()
    }
    
    func printTest(json:NSMutableArray?, error:ErrorType?) -> Void {
        print("RECEBI :D")
            if json != nil {
                for deviceObj in json! {
                    let desc:String = deviceObj["description"] as! String
                    let active:Bool = deviceObj["active"] as! Bool
                    let port:Int = deviceObj["port"] as! Int
                    let status:Bool = deviceObj["status"] as! Bool
                    devices.append(Device(desc: desc,port: port,active: active,status: status))
                }
                print(json![0].description)
                refreshUI()
            } else {
                print("ERROR getting data")
                self.performSegueWithIdentifier("ErrorView", sender: self)
            }
    }
    
    func refreshUI() {
        dispatch_async(dispatch_get_main_queue(),{
            self.tblView.reloadData()
        });
    }
    
}

