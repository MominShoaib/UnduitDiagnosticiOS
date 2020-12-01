//
//  UIViewController+Utility.swift
//
//  Created by Vivek Patel on 08/01/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD



extension UIViewController {
  
    func RGB(_ red:CGFloat,_ green:CGFloat,_ blue:CGFloat, alpha:CGFloat = 1.0) -> UIColor{
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    func showHUD()  {
        MBProgressHUD.hide(for: self.view, animated: true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    func hideHUD(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    /*
     func setStatusBarBackgroundColor(color: UIColor) {
     guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
     statusBar.backgroundColor = color
     }*/
    func showAlert(_ title: String? = "Message", message: String?, buttonTitle:String = "OK" ,completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) { alert in
            completion?()
        })
        self.present(alert, animated: true)
    }
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: true)
                    break
                }
            }
        }
    }
    func showAlert(_ title: String? = "Message", message: String?, completion: @escaping (_ isYes: Bool) -> Void) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { alert in
            completion(true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { alert in
            completion(false)
        })
        self.present(alert, animated: true)
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    @available(iOS 13.0, *)
    func getAppDelegate() -> AppDelegate {
            return UIApplication.shared.delegate as! AppDelegate
      }
      @available(iOS 13.0, *)
      func getSceneDelegate() -> SceneDelegate {
              return self.view.window?.windowScene?.delegate as! SceneDelegate
      }
}
