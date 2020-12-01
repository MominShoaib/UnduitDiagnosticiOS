//
//  ThankYouViewController.swift
//  Unduit
//
//  Created by Vivek Patel on 13/01/20.
//  Copyright © 2020 VSPLE. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        // Do any additional setup after loading the view.
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
    }
    
    @IBAction func actionGoToScan(_ sender: Any) {
        // self.navigationController?.popToRootViewController(animated: true)
        let destination = HomeViewController.instantiate(fromStoryboard: .Main)
        self.navigationController?.pushViewController(destination, animated: false)
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
