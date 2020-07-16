//
//  UserSessionBE.swift
//  discos-unidos
//
//  Created by mvilla on 7/5/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation

class UserSessionBE: NSObject, NSSecureCoding {
    
    static var supportsSecureCoding: Bool = true
    
    var session_user: String?
    var session_password: String?
    var session_role: String?
    
    static var shared: UserSessionBE?
    
    override init() {
        super.init()
    }
    
    //Decode
    required init?(coder: NSCoder) {
        
        self.session_user = coder.decodeObject(forKey: "session_user") as? String ?? ""
        self.session_password = coder.decodeObject(forKey: "session_password") as? String ?? ""
        self.session_role = coder.decodeObject(forKey: "session_role") as? String ?? ""

    }
    
    //Encode -> Sólo se puede a String, Double, Int, Bool, Dicctionary(de nativos), Array(de nativos)
    func encode(with coder: NSCoder) {
        
        coder.encode(self.session_user, forKey: "session_user")
        coder.encode(self.session_password, forKey: "session_password")
        coder.encode(self.session_role, forKey: "session_role")

    }
}
