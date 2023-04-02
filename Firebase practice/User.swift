//
//  User.swift
//  Firebase practice
//
//  Created by Adlet Zhantassov on 02.04.2023.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
}
