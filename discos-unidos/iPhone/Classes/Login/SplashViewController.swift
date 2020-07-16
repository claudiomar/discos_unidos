//
//  SplashViewController.swift
//  discos-unidos
//
//  Created by mvilla on 7/4/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = UserSessionBL.getUserSession() {
            print("llega hasta aqui...")
            print(UserSessionBL.getUserSession()?.session_user)
           self.perform(#selector(self.goToProfile), with: nil, afterDelay: 0.5)
       }else {
           self.perform(#selector(self.goToLogin), with: nil, afterDelay: 0.5)
       }
    }
    
    @objc func goToLogin(){
        self.performSegue(withIdentifier: "LoginViewController", sender: nil)
    }
    
    @objc func goToProfile() {
        self.performSegue(withIdentifier: "ProfileViewController", sender:  nil)
    }
    

}
