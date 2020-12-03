//
//  Constants.swift
//  TWClone
//
//  Created by RafaelAsencio on 02/12/2020.
//

import Foundation
import Firebase

//MARK: - DATABASE

let DB_REF = Database.database().reference()
let USER_REF = DB_REF.child("users")

//MARK: - STORAGE

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
