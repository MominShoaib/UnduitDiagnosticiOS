//
//  TutorialViewController.swift
//  MInikroft
//
//  Created by Apple on 07/09/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var arrImages = ["tutorialFirst", "tutorialSecond","tutorialThree","tutorialFour"]
    
    //MARK:- UILIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.barStyle = .black
          }
    // Screen width.
       public var screenWidth: CGFloat {
           return UIScreen.main.bounds.width
       }
       
       // Screen height.
       public var screenHeight: CGFloat {
           return UIScreen.main.bounds.height
       }
    //MARK:- UICOLLECTION VIEW DATASOURCE & DELEGATE METHODS
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCollectionViewCell", for: indexPath) as! TutorialCollectionViewCell
        cell.imgViewTutorial.image = UIImage(named: arrImages[indexPath.row])
        cell.imgViewTutorial.contentMode = .scaleToFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // if indexPath.row == 3{
//        let vc:UIViewController =  SignInViewController.instantiate(fromStoryboard: .Main)
//            self.navigationController?.pushViewController(vc, animated: true)
            
      //  }
    }
}

   //MARK:- UICOLLECTION VIEW UICollectionViewDelegateFlowLayout METHODS

extension TutorialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width:screenWidth , height:screenHeight)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
