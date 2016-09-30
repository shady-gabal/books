//
//  BookStore.swift
//  Books
//
//  Created by Shady Gabal on 9/28/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class BookStore: NSObject {
    
    static let sharedInstance = BookStore()
    
    public var allBooks:NSArray{
        get {
            return NSArray(array: self.books)
        }
    }
    
    private var books:[Book] = []
    
    override init() {
    }
    
    public func fetchBooks(){
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: "/books", method: NetworkManager.NetworkMethod.GET, parameters: [:], successCallback: { (responseObject:AnyObject) -> Void in
            
            
            }, errorCallback: { (statusCode: Int) -> Void in
                
            })
    }
    
}
