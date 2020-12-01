//
//  TestQuestionTableViewCell.swift
//  Unduit
//
//  Created by Vivek Patel on 23/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit

class TestQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
