//
//  Model.swift
//  RX_iOS
//
//  Created by Kerolos on 18/05/2025.
//

import Foundation
struct User{
    var fName:String
    var lName:String
    
   
    var fullName:String{
        return "\(fName) \(lName)"
    }
    init(fName: String, lName: String) {
        self.fName = fName
        self.lName = lName
    }
}
