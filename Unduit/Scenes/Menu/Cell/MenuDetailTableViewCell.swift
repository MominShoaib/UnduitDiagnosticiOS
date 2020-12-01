//
//  MenuDetailTableViewCell.swift
//  Unduit
//
//  Created by Vivek Patel on 20/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class MenuDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var imgLeftIcon: UIImageView!
    @IBOutlet weak var imgRightIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
     @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblQuestions: UILabel!
    
       override func awakeFromNib() {
           super.awakeFromNib()
//           viewShadow.layer.masksToBounds = false
//           viewShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
//           viewShadow.layer.shadowColor = UIColor.lightGray.cgColor
//           viewShadow.layer.shadowRadius = 2
//           viewShadow.layer.shadowOpacity = 0.5
          // viewShadow.clipsToBounds = true
//        viewShadow.layer.addBorder(edge: .left, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), thickness: 1)
//        viewShadow.layer.addBorder(edge: .right, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), thickness: 1)
//        viewShadow.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1), thickness: 1)
            
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setLeftImage(_ leftImage:String)  {
              
              guard let imageURL = URL(string: leftImage) else {
                  return
              }
        let filterAspect = AspectScaledToFitSizeFilter(size: imgLeftIcon.frame.size)
              let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                  size: imgLeftIcon.frame.size,
                  radius: 0.0
              )
              
              imgLeftIcon.af_setImage(
                  withURL: imageURL,
                  placeholderImage: nil,
                  filter: filterAspect
              )
      }
}

