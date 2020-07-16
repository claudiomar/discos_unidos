//
//  LoginBL.swift
//  discos-unidos
//
//  Created by mvilla on 7/5/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation
import Firebase

typealias ErrorMessage  = (_ errorMessage: String) -> Void
typealias Success       = () -> Void

let db  = Firestore.firestore()

class LoginBL {
            
    class func login(user: String?, password: String?, success: @escaping Success, errorMessage: @escaping ErrorMessage) {
        
        
        if let email = user , let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              // ...
                if let e = error{
                    errorMessage(e.localizedDescription)
                }else{
                    
                    let objSession = UserSessionBE()
                    objSession.session_user = user
                    objSession.session_password = password
                    
                    let docRef = db.collection("users").document(email)

                    docRef.getDocument { (document, error) in
                        if let userFirestore = document.flatMap({
                          $0.data().flatMap({ (data) in
                            return UserFirestore(dictionary: data)
                          })
                        }) {
                            print("UserFirestore: \(userFirestore)")
                            objSession.session_role = userFirestore.role
                        } else {
                            print("Document does not exist")
                        }
                    }
               
                    if UserSessionBL.saveSession(objSession) {
                        success()
                    }else {
                        errorMessage("Lo sentimos, ocurrio un error con la sesión")
                    }
                }
            }
        }
    }
}

class RegisterBL{
    
    class func registerUser(user: String?, password: String?, names: String?,success: @escaping Success, errorMessage: @escaping ErrorMessage) {
    
      if let email = user ,let password = password , let names = names{
               Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                 // ...
                   if let e = error {
                        print(e.localizedDescription)
                        errorMessage(e.localizedDescription)
                  
                   }else{
                    
                    db.collection("users").document(email).setData([
                       "email" : email,
                       "names" : names,
                       "role"  : 1
                       ]) { err in
                           if let err = err {
                               print("error al insertar usuario, \(err)")
                           }
                           else
                           {
                                print("Se guardo con exito el usuario")
                                success()
                           }
                       }
                   }
               }
           }
    }
}
