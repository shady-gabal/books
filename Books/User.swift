//
//  User.swift
//  Books
//
//  Created by Shady Gabal on 10/1/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class User: NSObject {
    static let sharedInstance = User()
    
    public var name:String?
    
    override init(){
        super.init()
        self.name = UserDefaults.standard.object(forKey: Constants.DefaultsKeyName) as? String
    }
    
    public func saveName(_ name:String!){
        UserDefaults.standard.set(name!, forKey: Constants.DefaultsKeyName)
        self.name = name
    }

}
