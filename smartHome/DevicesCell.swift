//
//  DevicesCell.swift
//  smartHome
//
//  Created by TmRocha89 on 31/03/16.
//  Copyright © 2016 TmRocha89. All rights reserved.
//

import UIKit

class DevicesCell: UITableViewCell {
    
    
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var deviceStatus: UISwitch!
    var portID: Int!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setCell(name:String,port:Int,status:Bool, switchActive:Bool) {
        self.deviceLabel.text = name
        self.portID = port
        self.deviceStatus.tag = port
        self.deviceStatus.setOn(status, animated: true)
        self.deviceStatus.enabled = switchActive
    }
}
