//
//  UserRegisterViewController.swift
//  discos-unidos
//
//  Created by mvilla on 7/5/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import UIKit
import Firebase

class CellClass: UITableViewCell{
    
}

class UserRegisterViewController: UIViewController {
    
    @IBOutlet weak var scrollViewContent:UIScrollView!
    @IBOutlet weak var txtNames: CSMTextField!
    @IBOutlet weak var txtUser: CSMTextField!
    @IBOutlet weak var txtPassword: CSMTextField!
    @IBOutlet weak var actvSave: UIActivityIndicatorView!
    @IBOutlet weak var viewContentField: CSMShadowView!
    @IBOutlet weak var cnsViewContent_y: NSLayoutConstraint!
    var initialCsnViewContent_y_constant : CGFloat = 0.0
    
    @IBOutlet weak var btnSelectRole: UIButton!
    
    
    @IBOutlet weak var btnSaveUser: CSMButton!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton  = UIButton()
    var dataSource = [String]()
    
    @IBAction func clickBtnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func clickBtnSaveUser(_ sender: Any?) {
       self.tapToCloseKeyboard(nil)
       self.actvSave.startAnimating()
       self.btnSaveUser.isEnabled = false
       self.btnSaveUser.alpha = 0.5
       
       self.perform(#selector(self.saveUser), with: nil, afterDelay: 2)
    }
    
    @objc func saveUser() {
        
        /*
        if let email = txtUser.text,let password = txtPassword.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              // ...
                if let e = error {
                    print(e.localizedDescription)
                    self.actvSave.stopAnimating()
                    self.btnSaveUser.isEnabled = true
                    self.btnSaveUser.alpha = 1
                    self.showAlert(withTitle: "Error", withMessage: e.localizedDescription, withAcceptButton: "Aceptar", withCompletion: nil)
               
                }else{
                  
                    self.actvSave.stopAnimating()
                    self.btnSaveUser.isEnabled = true
                    self.btnSaveUser.alpha = 1
                    self.dismiss(animated: true, completion: nil)

                    //...self.performSegue(withIdentifier: "ProfileViewController", sender: nil)
                }
            }
        }
        */
        
        RegisterBL.registerUser(user: self.txtUser.text, password: self.txtPassword.text, names: self.txtNames.text ,success: {
            
            self.actvSave.stopAnimating()
            self.btnSaveUser.isEnabled = true
            self.btnSaveUser.alpha = 1
            self.dismiss(animated: true, completion: nil)

        }) { (errorMessage) in
            
            self.actvSave.stopAnimating()
            self.btnSaveUser.isEnabled = true
            self.btnSaveUser.alpha = 1
            self.showAlert(withTitle: "Error", withMessage: errorMessage, withAcceptButton: "Aceptar", withCompletion: nil)
        }
         
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardSize = keyboardFrame?.size ?? .zero
        let keyboardheight = keyboardSize.height
        
        let availableSpace = self.view.frame.height - keyboardheight - 20
        let finalPos_y_viewContent = self.viewContentField.frame.origin.y + self.viewContentField.frame.height
        
        if finalPos_y_viewContent > availableSpace {
            let delta = finalPos_y_viewContent - availableSpace
            
            UIView.animate(withDuration: 0.35) {
                self.cnsViewContent_y.constant = self.initialCsnViewContent_y_constant - delta
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        UIView.animate(withDuration: 0.35) {
            self.cnsViewContent_y.constant = self.initialCsnViewContent_y_constant
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //... para el select de ROL
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        let centerYHeight = self.scrollViewContent.frame.height / 2
        let centerYContent = self.scrollViewContent.contentSize.height / 2
        
        let centerXWidth = self.scrollViewContent.frame.width / 2
        let centerXContent = self.scrollViewContent.contentSize.width / 2
        
        let finalPoint = CGPoint(x: centerXContent - centerXWidth, y: centerYContent - centerYHeight)
        self.scrollViewContent.setContentOffset(finalPoint, animated: true)

    }
    
    @IBAction func onClickSelectRole(_ sender: Any) {
        dataSource = ["Usuario","Administrador"]
        selectedButton = btnSelectRole
        addTransparentView(frames: btnSelectRole.frame)
    }
    
    func addTransparentView(frames: CGRect){
        let window  = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x:frames.origin.x , y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x:frames.origin.x, y:frames.origin.y + frames.height + 5,width: frames.width,height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x:frames.origin.x, y:frames.origin.y + frames.height,width: frames.width,height: 0)
        }, completion: nil)
    }
    
}

extension UserRegisterViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}


extension UserRegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.txtNames{
            self.txtNames.becomeFirstResponder()
        }
        else if textField == self.txtUser {
            self.txtPassword.becomeFirstResponder()
            
        }
        else if textField == self.txtPassword {
            self.clickBtnSaveUser(self.btnSaveUser)
        }
        
        return true
    }
}
