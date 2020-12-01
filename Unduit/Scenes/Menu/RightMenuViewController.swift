
///
//  RightMenuViewController.swift
//  Unduit
//
//  Created by Vivek Patel on 19/12/19.
//  Copyright © 2019 VSPLE. All rights reserved.
//

import UIKit
class RightMenuViewController: UIViewController {
    //MARK: - Variable
    private lazy var presenter = {
        return TestingPresenter(self)
    }()
    var menuList:[Category] = []
    var categories:[Category] = []
    private let refreshControl = UIRefreshControl()
    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewVertical: UIView!
    @IBOutlet weak var viewBottom: UIView!
   
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.view.backgroundColor = .clear
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
       // tableView.backgroundColor = .clear
        
       // UIApplication.shared.keyWindow?.windowLevel = UIWindow.Level.statusBar
        tableView.dataSource =  self
        tableView.delegate = self
//        self.viewVertical?.layer.cornerRadius = 20
//        self.viewVertical?.clipsToBounds = true
//        self.viewVertical?.layer.maskedCorners = [.layerMinXMinYCorner]
//        
//        self.viewBottom?.layer.cornerRadius = 20
//        self.viewBottom?.clipsToBounds = true
      //  self.viewBottom?.layer.maskedCorners = [.layerMinXMaxYCorner]
//        viewBottom.layer.addBorder(edge: .top, color: #colorLiteral(red: 0.2936274409, green: 0.6764646173, blue: 0.596259594, alpha: 1), thickness: 1)
//        viewBottom.layer.addBorder(edge: .bottom, color: #colorLiteral(red: 0.2936274409, green: 0.6764646173, blue: 0.596259594, alpha: 1), thickness: 1)
          self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
               self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        presenter.apiCallForGetMenuData()
    }
    func apiCall(){
        presenter.apiCallForGetMenuData()
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
            return false
        }
    override func viewWillAppear(_ animated: Bool) {
        //  presenter.apiCallForGetMenuData()
    }
    //MARK:-  Action
    @objc private func refreshWeatherData(_ sender: Any) {
        presenter.apiCallForGetMenuData()
    }
    
    @IBAction func actionFinish(_ sender: Any) {
        let destination =  ThankYouViewController.instantiate(fromStoryboard: .Main)
                   self.navigationController?.pushViewController(destination, animated: true)
    }
    /*
    @IBAction func actionDeviceDetail(_ sender: Any) {
        panel?.closeRight()
    }
    @objc func actionSection(sender: UIButton) {
        var menu = menuList[sender.tag]
        if menu.subCategory.count > 0{
            menu.isSelected = !menu.isSelected
            menuList[sender.tag] = menu
            // let range = NSMakeRange(0, self.tableView.numberOfSections)
            //let sections = NSIndexSet(indexesIn: range)
            // self.tableView.reloadSections(sections as IndexSet, with: .fade)
            tableView.reloadData()
        }else{
            pushToDetail(menu)
        }
    }
 */
}
//MARK: - TableViewDataSource
extension RightMenuViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  menuList[section].subCategory.count > 0 {
            menuList[section].isSelected = true
            if menuList[section].isSelected {
                return menuList[section].subCategory.count
            }else{
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuDetailTableViewCell.self)) as! MenuDetailTableViewCell
        cell.selectionStyle = .none
        let categories = menuList[indexPath.section].subCategory
        let category = categories[indexPath.row]
        cell.lblTitle.text = category.testCase
        let image = category.icon
        if let image = image{
            cell.setLeftImage(image)
        }
        if  category.testStatus == .pass{
            cell.imgRightIcon.image =  #imageLiteral(resourceName: "passed")
        }else{
            cell.imgRightIcon.image = #imageLiteral(resourceName: "issue")
        }
      
        if  category.question?.count ?? 0 > 0{
                    cell.lblQuestions.text = category.question
               }else{
                   cell.lblQuestions.isHidden = true
               }
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
      
        if indexPath.row == totalRows - 1 {
               cell.viewShadow?.layer.cornerRadius = 10
               cell.viewShadow?.clipsToBounds = true
              //cell.viewShadow?.layer.maskedCorners = [.layerMinXMinYCorner]//1
             // cell.viewShadow?.layer.maskedCorners = [.layerMaxXMinYCorner]//2
            cell.viewShadow?.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]//3,4
            //cell.viewShadow?.layer.maskedCorners = [.layerMaxXMaxYCorner]//4
        }else{
            cell.viewShadow?.layer.cornerRadius = 0
        }

        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RightMenuTableViewCell.self)) as! RightMenuTableViewCell
        cell.selectionStyle = .none
        let sectionData = menuList[section]
        let title = sectionData.testCase
        let image = sectionData.icon
        if let image = image{
            cell.setleftImage(image)
        }
        if sectionData.testStatus == .pass{
            cell.imgViewRightIcon.image = #imageLiteral(resourceName: "passed")
        }else if sectionData.testStatus == .fail || sectionData.testStatus == .pending{
            cell.imgViewRightIcon.image = #imageLiteral(resourceName: "issue")
        }else{
            cell.imgViewRightIcon.image = nil
        }
        cell.lblTitle?.text = title
        if  sectionData.question?.count ?? 0 > 0{
             cell.lblQuestion.text = sectionData.question
        }else{
            cell.lblQuestion.isHidden = true
        }
       
//        cell.btnHeader.tag = section
//        cell.btnHeader.addTarget(self, action: #selector(actionSection), for: .touchUpInside)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        TipInCellAnimator.animate(cell: cell)
    }
}
//MARK: - TableViewDelegate
extension RightMenuViewController:UITableViewDelegate{
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let categories = menuList[indexPath.section].subCategory
//
//        let menu = categories[indexPath.row]
//
//        pushToDetail(menu)
    }
    func pushToDetail(_ menu:Category){
        guard let navigationController =  self.panel?.center as? UINavigationController else{
            return
        }
        let currentIndex = categories.firstIndex { (category) -> Bool in
            return category.id == menu.id
        }
        //        let centerVC = TestQuestionViewController.instantiate(fromStoryboard:
        //            .TestCommon)
        //        centerVC.currentIndex = currentIndex ?? 0
        //        centerVC.categories = categories
        //        navigationController.pushViewController(centerVC, animated: true)
        //        panel?.closeRight()
        //
        // let nav = self.navigationController //grab an instance of the current navigationController
        
        navigationController.view.layer.add(CATransition().popFromLeft(), forKey: nil)
        let centerVC = TestQuestionViewController.instantiate(fromStoryboard:
            .TestCommon)
        centerVC.currentIndex = currentIndex ?? 0
        centerVC.categories = categories
        navigationController.pushViewController(centerVC, animated: false)
        panel?.closeRight()
    }
 */
}

extension RightMenuViewController:TestingView{
    func successEmail() {}
    
    func successfullyUpdateInfo() {}
    
    func testSuccess() {}
    
    func getMenuData(_ menuList: [Category]) {
        refreshControl.endRefreshing()
        self.menuList = menuList
        categories.removeAll()
        for menu in self.menuList{
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
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        addSublayer(border)
    }
}
class TipInCellAnimator {
    // placeholder for things to come -- only fades in for now
    class func animate(cell:UITableViewCell) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 1.4) {
            view.layer.opacity = 1
        }
    }
}
extension CATransition {
    
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}
