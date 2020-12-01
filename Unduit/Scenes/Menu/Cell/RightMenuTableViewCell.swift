//
//  RightMenuTableViewCell.swift
//  Unduit
//
//  Created by Vivek Patel on 19/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RightMenuTableViewCell: UITableViewCell {
   
//MARK: - Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewRightIcon: UIImageView!
    @IBOutlet weak var imgViewLeftIcon: UIImageView!
    @IBOutlet weak var btnHeader: UIButton!
     @IBOutlet weak var viewShadow: UIView!
     @IBOutlet weak var lblQuestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        viewShadow.layer.masksToBounds = false
//        viewShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
//        viewShadow.layer.shadowColor = UIColor.lightGray.cgColor
//        viewShadow.layer.shadowRadius = 2
//        viewShadow.layer.shadowOpacity = 0.5
       // viewShadow.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(_ data:MenuData){
        lblTitle.text = data.title
//        imgViewRightIcon.image = data.rightImage
//        imgViewLeftIcon.image = data.leftImage
       
       
       }
    func setleftImage(_ leftImage:String)  {
            
            guard let imageURL = URL(string: leftImage) else {
                return
            }
        let filterAspect = AspectScaledToFitSizeFilter(size: imgViewLeftIcon.frame.size)

            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: imgViewLeftIcon.frame.size,
                radius: 0.0
            )
            
            imgViewLeftIcon.af_setImage(
                withURL: imageURL,
                placeholderImage: nil,
                filter: filterAspect
            )
    }
    
}
