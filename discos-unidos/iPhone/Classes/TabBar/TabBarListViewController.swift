//
//  TabBarListViewController.swift
//  discos-unidos
//
//  Created by mvilla on 7/11/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit

class TabBarListViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
