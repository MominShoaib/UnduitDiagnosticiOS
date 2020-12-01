//
//  DeviceDetailTableViewCell.swift
//  Unduit
//
//  Created by Vivek Patel on 18/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit

class DeviceDetailTableViewCell: UITableViewCell {
//MARK: - Outlet
    @IBOutlet weak var lblManufacturer: UILabel!

     @IBOutlet weak var lblModel: UILabel!
     @IBOutlet weak var lblVersion: UILabel!
     @IBOutlet weak var lblStorage: UILabel!
     @IBOutlet weak var lblModelNumber: UILabel!
     @IBOutlet weak var lblColor: UILabel!
     @IBOutlet weak var lblCellularType: UILabel!
     @IBOutlet weak var lblIMEI: UILabel!
     @IBOutlet weak var lblSerialNumber: UILabel!
    
    @IBOutlet weak var lblDeviceName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
