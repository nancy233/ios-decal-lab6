//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    let loginLabel = UILabel(frame:CGRect(x: 0, y: 0,
                                    width: UIScreen.main.bounds.width,
                                    height: 100) )
    
    let loginView = UIView(frame:CGRect(x: 0, y: 0,
                                        width: UIScreen.main.bounds.width*0.9,
                                        height: UIScreen.main.bounds.height/3) )
    let account = UITextField()
    let password = UITextField()
    let loginButt = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        view.addSubview(loginLabel)
        view.addSubview(loginView)
        loginView.addSubview(account)
        loginView.addSubview(password)
        loginView.addSubview(loginButt)
        // TODO: layout your views using frames or AutoLayout
        // Label
        loginLabel.text = "Login View Controller"
        loginLabel.textColor = UIColor.white
        loginLabel.font = UIFont(name: loginLabel.font.fontName, size: 30)
        loginLabel.textAlignment = NSTextAlignment.center
        loginLabel.center = CGPoint(x:UIScreen.main.bounds.width/2, y:UIScreen.main.bounds.height/5)
        
        // loginView
        loginView.center = view.center
        loginView.backgroundColor = UIColor.white
        
        // account and password
        account.placeholder = "berkeley.edu account"
        password.placeholder = "Password"
        
        account.frame = CGRect(x: 0, y: 0,
                               width: loginView.bounds.width,
                               height: loginView.bounds.height/4)
        password.frame = CGRect(x: 0, y: loginView.bounds.height/4*1.5,
                               width: loginView.bounds.width,
                               height: loginView.bounds.height/4)
        
        // loginButton
        loginButt.frame = CGRect(x: 0, y: loginView.bounds.height/4*3,
                                width: loginView.bounds.width/2,
                                height: loginView.bounds.height/4)
        loginButt.backgroundColor = view.backgroundColor
        loginButt.center = CGPoint(x:loginView.bounds.width/2, y:loginView.bounds.height/4*3)
        loginButt.setTitle("Login", for: .normal)
        loginButt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)


        
        
        
    }
    
    // TODO: create an IBAction for your login button
    func buttonAction(sender: AnyObject){
        authenticateUser(username:account.text, password:password.text)
    }
    
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
