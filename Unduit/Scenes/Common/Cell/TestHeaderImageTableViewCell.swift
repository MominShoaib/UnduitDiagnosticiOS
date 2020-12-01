//
//  TestHeaderImageTableViewCell.swift
//  Unduit
//
//  Created by Vivek Patel on 23/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class TestHeaderImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imgTest: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ Image:String)  {
               
               guard let imageURL = URL(string: Image) else {
                   return
               }
        let filterAspect = AspectScaledToFitSizeFilter(size: imgTest.frame.size)
               let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                   size: imgTest.frame.size,
                   radius: 0.0
               )
               
               imgTest.af_setImage(
                   withURL: imageURL,
                   placeholderImage: #imageLiteral(resourceName: "information-button"),
                   filter: filterAspect
               )
       }
}
