//
//  Friend.swift
//  Birthdays
//
//  Created by Tony Gultom on 13/08/24.
//

import Foundation
import SwiftData


@Model
class Friend {
    let name: String
    let birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
}
