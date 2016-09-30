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
    var lastCheckedOut : Date?
    var lastCheckedOutBy : String?
    var lastCheckedOutDescription : String?
    var url : String?
    
    
    init(_ data:NSDictionary){
        self.author = data["author"] as? String
        self.title = data["title"] as? String
        self.lastCheckedOutBy = data["lastCheckedOutBy"] as? String
        self.publisher = data["publisher"] as? String
        self.url = data["url"] as? String
        self.categories = data["categories"] as? String
        
        
        if let lastCheckedOutDateString = data["lastCheckedOut"] as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            
            self.lastCheckedOut = formatter.date(from: lastCheckedOutDateString)
            
            formatter.dateFormat = "MMMM dd YYYY HH:mm a"
            let dateString:String = self.lastCheckedOut != nil ? formatter.string(from: self.lastCheckedOut!) : "Date not specified"
            self.lastCheckedOutDescription = String.init(format: "%@ @ %@", self.lastCheckedOutBy ?? "Someone", dateString)
        }
        else{
            self.lastCheckedOutDescription = "Never checked out"
        }

    }
}
