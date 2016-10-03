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
        super.init()
        update(withData: data)
    }
    
    func update(withData: NSDictionary){
        self.author = withData["author"] as? String
        self.title = withData["title"] as? String
        self.lastCheckedOutBy = withData["lastCheckedOutBy"] as? String
        self.publisher = withData["publisher"] as? String
        self.url = withData["url"] as? String
        self.categories = withData["categories"] as? String
        
        
        if let lastCheckedOutDateString = withData["lastCheckedOut"] as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.lastCheckedOut = formatter.date(from: lastCheckedOutDateString)
            
            formatter.dateFormat = "MMMM dd, YYYY hh:mm a"
            let dateString:String = self.lastCheckedOut != nil ? formatter.string(from: self.lastCheckedOut!) : "Date not specified"
                        
            self.lastCheckedOutDescription = String.init(format: "%@ @ %@", self.lastCheckedOutBy ?? "Someone", dateString)
        }
        else{
            self.lastCheckedOutDescription = "Never checked out"
        }
    }
    
    func bookDescription() -> String!{
        var ans:String = self.title ?? ""
        if self.author != nil{
            ans += String(format: ", by %@", self.author!)
        }
        if self.publisher != nil{
            ans += String(format: ". Published by %@", self.publisher!)
        }
        
        return ans
    }
}
