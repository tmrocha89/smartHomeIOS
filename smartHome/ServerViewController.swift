//
//  ServerViewController.swift
//  smartHome
//
//  Created by TmRocha89 on 31/03/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import UIKit

class ServerViewController: UIViewController {
    
    @IBOutlet weak var serverAddressText: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var repo = ServerRepository.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        serverAddressText.text = repo.getServerAddress()
        usernameTxt.text = repo.getUsername()
        passwordText.text = repo.getPassword()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerBtn(sender: AnyObject) {
        let serverAddress = serverAddressText.text!
        let username = usernameTxt.text!
        let password = passwordText.text!
        
        if (repo.configure(serverAddress, username: username, password: password)) {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            displayAlertMessage("Server address cannot be empty")
        }
        
    }
    
    func displayAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Invalid data", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
}
