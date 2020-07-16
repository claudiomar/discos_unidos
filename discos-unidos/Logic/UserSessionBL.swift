//
//  UserSessionBL.swift
//  discos-unidos
//
//  Created by mvilla on 7/5/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation

class UserSessionBL {
    
    static let accountSession = "UserSessionBE"
    static let serviceSession = "session"
    
    class func saveSession(_ session: UserSessionBE) -> Bool {
        
        self.closeSession()
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: session, requiringSecureCoding: true)
            UserSessionBE.shared = session
            CSMKeyChain.sharedInstance.saveDataInKeychain(data, withAccount: accountSession, withService: serviceSession)
            return true
        }catch {
            print("No se pudo guardar la sesión")
            return false
        }
    }
    
    class func getUserSession() -> UserSessionBE? {
        
        guard let session = UserSessionBE.shared else {
            
            if let dataUser = CSMKeyChain.sharedInstance.dataFromKeychainWithAccount(accountSession, withService: serviceSession) {
                
                do {
                    let objSession = (try NSKeyedUnarchiver.unarchivedObject(ofClass: UserSessionBE.self, from: dataUser)) as UserSessionBE?
                    return objSession
                    
                }catch {
                    return nil
                }
            
            }else{
                return nil
            }
        }
        
        return session
    }
    
    class func closeSession() {
        print("borrar sesion desde el UserSessionBL")
        CSMKeyChain.sharedInstance.deleteKeychain()
    }
}

