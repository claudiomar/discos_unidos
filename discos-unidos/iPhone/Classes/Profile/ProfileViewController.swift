//
//  ProfileViewController.swift
//  discos-unidos
//
//  Created by mvilla on 7/4/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBAction func closeSession(_ sender: Any) {
          //...UserSessionBL.closeSession()
          print("close session")
        UserSessionBL.closeSession()
        self.navigationController?.popToRootViewController(animated: true)
      }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      if let session = UserSessionBL.getUserSession() {
          print("User: \(session.session_user ?? "Sin usuario")")
          print("Role: \(session.session_role ?? "Role")")
      }
    }
    
}
