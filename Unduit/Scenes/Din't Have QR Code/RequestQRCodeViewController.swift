//
//  RequestQRCodeViewController.swift
//  Unduit
//
//  Created by Vivek Patel on 17/02/20.
//  Copyright © 2020 VSPLE. All rights reserved.
//

import UIKit
import BottomPopup
class RequestQRCodeViewController: UIViewController {
//MARK: - Variable
    
       
    private lazy var presenter = {
        return TestingPresenter(self)
    }()
    //MARK: - Outlet
    @IBOutlet weak var txtEmail: UITextField!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
       hideKeyboardWhenTappedAround()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
               self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
       
    }
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
           self.navigationController?.navigationBar.backItem?.hidesBackButton = true
       }
   
    //MARK: - Action
        @IBAction func actionSubmit(_ sender: Any) {
        guard !txtEmail.text!.isEmpty else {
        self.showAlert(message: "Please enter email", completion: nil)
        return
        }
        guard txtEmail.text!.isValidEmail() else {
        self.showAlert(message: "Please enter a valid email", completion: nil)
        return
        }
        presenter.apiCallForRequestQRCode(txtEmail.text!)
    }
}

//MARK: - TestingView
extension RequestQRCodeViewController:TestingView{
    func successEmail() {
        showAlert("Message", message: "Email sent successfully", buttonTitle: "Ok") {
              self.dismiss(animated: true, completion: nil)
        }
    }
    
    func successfullyUpdateInfo() {}
    func testSuccess() {}
    func getMenuData(_ menuList: [Category]) {}
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
//MARK: - Hide Keyboard
extension RequestQRCodeViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(RequestQRCodeViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//MARK: - UITextField Delegate
extension RequestQRCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
