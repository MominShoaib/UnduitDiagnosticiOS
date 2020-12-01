//
//  TutorialScreensViewController.swift
//  MInikroft
//
//  Created by Apple on 09/09/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit

class TutorialScreensViewController: UIViewController {

    //MARK: - Outlet
     @IBOutlet weak var containerView: UIView!
     @IBOutlet weak var btnSkip: UIButton!
     @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Variable
     var pageIndex = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TutorialPageViewController {
            destination.tutorialDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
                      self.navigationController?.navigationBar.barStyle = .black
          }
    //MARK:- UIACTION METHOD
    @IBAction func actionSkipButton(_ sender: UIButton) {
  let destination = HomeViewController.instantiate(fromStoryboard: .Main)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension TutorialScreensViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController, didUpdatePageCount count: Int) {
         pageControl.numberOfPages = count
         
    }
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        if pageControl.numberOfPages == index+1 {
            btnSkip.isHidden = true
        }else{
            btnSkip.isHidden = false
        }
    }
}
