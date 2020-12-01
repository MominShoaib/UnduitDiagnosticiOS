//
//  TestQuestionViewController.swift
//  Unduit
//
//  Created by Vivek Patel on 23/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit

class TestQuestionViewController: UIViewController {
    
    //MARK:- Variable
    var currentIndex = 0
    var categories:[Category] = []
    var subCategory:Category?
    private let refreshControl = UIRefreshControl()
    private lazy var presenter = {
        return TestingPresenter(self)
    }()
    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()       
       // self.title = categories[currentIndex].testCase
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backItem?.hidesBackButton = false
        self.navigationController?.navigationBar.barStyle = .default
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
       // self.navigationController?.navigationBar.tintColor = UIColor.red
        registerNibHeader()
        registerNib()
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
         self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        guard categories.isEmpty else {
            return
        }
        presenter.apiCallForGetMenuData()
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
        return false
    }
    func registerNibHeader(){
        let nibName = String(describing: TestHeaderImageTableViewCell.self)
        tableView?.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    func registerNib(){
        let nibName = String(describing: TestQuestionTableViewCell.self)
        tableView?.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    func puchToNextTest(_ testResult:String){
        let subCategory = categories[currentIndex]
        let id = subCategory.id
        presenter.apiCallForDeviceTest(id!, testResult: testResult)
    }
    //MARK:- Action
    @IBAction func actionClose(_ sender: Any) {
        puchToNextTest("Failed")
    }
    
    @IBAction func actionNext(_ sender: Any) {
        puchToNextTest("Passed")
    }
}
//MARK: - Table view data source
extension TestQuestionViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        guard !categories.isEmpty else {
            return 0
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
              return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TestHeaderImageTableViewCell.self)) as! TestHeaderImageTableViewCell
            cell.selectionStyle = .none
            let category = categories[currentIndex]
            self.title = category.testCase
            self.subCategory = category
            let image = category.image
            if let image = image{
                cell.setData(image)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TestQuestionTableViewCell.self) , for: indexPath) as! TestQuestionTableViewCell
             cell.selectionStyle = .none
            let category = categories[currentIndex]
             self.title = category.testCase
            self.subCategory = category
            let question = category.question
            cell.lblQuestion.text = question
            return cell
        }
    }
    
}
//MARK: - TableView Delegate
extension TestQuestionViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
//MARK: - TestingView
extension TestQuestionViewController:TestingView{
    func successEmail() {}
    
    func successfullyUpdateInfo() {}
    
    func testSuccess() {
        let updatedIndex = currentIndex + 1
        if categories.count == updatedIndex {
            let destination =  RightMenuViewController.instantiate(fromStoryboard: .Main)
             self.navigationController?.pushViewController(destination, animated: true)
           // self.performSegue(withIdentifier: "DeviceDetail", sender: self)
        }else{
            let destination =  TestQuestionViewController.instantiate(fromStoryboard: .TestCommon)
            destination.currentIndex = updatedIndex
            destination.categories = categories
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func getMenuData(_ menuList: [Category]) {
        currentIndex = 0
        refreshControl.endRefreshing()
        categories.removeAll()
        for menu in menuList{
            if menu.subCategory.isEmpty {
                categories.append(menu)
            }else{
                for category in menu.subCategory{
                    categories.append(category)
                }
            }
        }
        self.tableView?.reloadData()
    }
     func showLoader() {
           showHUD()
       }
       
       func hideLoader() {
           hideHUD()
       }
       
       func showAlert(_ title: String?, message: String?) {
           showAlert(title, message: message, completion: nil)
       }
       
    
    
}
