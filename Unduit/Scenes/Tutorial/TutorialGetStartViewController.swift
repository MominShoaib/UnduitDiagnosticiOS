//
//  TutorialGetStartViewController.swift
//  MInikroft
//
//  Created by Apple on 10/11/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit

class TutorialGetStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.barStyle = .black
       }
    @IBAction func actionGetStart(_ sender: UIButton) {
        let destination = HomeViewController.instantiate(fromStoryboard: .Main)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
