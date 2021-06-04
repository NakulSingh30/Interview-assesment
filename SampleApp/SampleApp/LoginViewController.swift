//
//  ViewController.swift
//  SampleApp
//
//  Created by Nakul  on 04/06/21.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK:- actions
    @IBAction func signInButtonAction(_ sender: Any) {
        guard isValidEmail(email: emailTextField.text), isValidPassword(password: passwordTextField.text) else {
            showInvalidDataAlert()
            return
        }
        
       let appDelegate = UIApplication.shared.delegate as? AppDelegate
       appDelegate?.setRootViewController(rootType: .home)
    }
    
    @IBAction func visibilityButtonAction(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    //MARK:- helper methods
    private func isValidEmail(email: String?) -> Bool{
        guard let emailString = email else{
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
    
    private func isValidPassword(password: String?) -> Bool{
        return password?.isEmpty == false
    }
    
    private func showInvalidDataAlert() {
        let alert = UIAlertController(title: "Alert", message: "Please Enter a valid email/password", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

