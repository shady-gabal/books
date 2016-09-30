//
//  Book.swift
//  Books
//
//  Created by Shady Gabal on 9/28/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var title: String?
    var author: String?
    var publisher: String?
    var categories: String?
    var lastCheckedOut : String?
    var lastCheckedOutBy : String?
    var url : String?
    
    
    init(_ data:NSDictionary){
        self.author = data["author"] as? String
        self.title = data["title"] as? String
        self.lastCheckedOut = data["lastCheckedOut"] as? String
        self.lastCheckedOutBy = data["lastCheckedOutBy"] as? String
        self.publisher = data["publisher"] as? String
        self.url = data["url"] as? String
        self.categories = data["categories"] as? String
        

    }
}
