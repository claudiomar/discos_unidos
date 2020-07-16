//
//  UserFirestore.swift
//  discos-unidos
//
//  Created by mvilla on 7/7/20.
//  Copyright © 2020 Martin Villa . All rights reserved.
//

import Foundation

struct UserFirestore {

    let names: String
    let email: String?
    let role: String?


    init?(dictionary: [String: Any]) {
        
        guard let names = dictionary["names"] as? String else { return nil }
        self.names  = names
        self.email = dictionary["email"] as? String
        self.role = dictionary["role"] as? String

    }
}

