//
//  User.swift
//  SwiftDataProject
//
//  Created by user276992 on 8/13/25.
//

import Foundation
import SwiftData
import SwiftUI


@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
