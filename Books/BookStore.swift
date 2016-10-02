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
    
    public func fetchBooks(callback: @escaping () -> Void = {() in }){
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: "/books", method: NetworkManager.NetworkMethod.GET, parameters: [:], successCallback: { (responseObject:Any?) -> Void in
            
            if let booksArray = responseObject as? Array<Any> {
                for bookDict in booksArray {
                    if let bookData = bookDict as? NSDictionary{
                        let newBook:Book = Book(bookData)
                        self.books.append(newBook)
                    }
                }
            }
            
            callback()
            
            
            }, errorCallback: { (statusCode: Int) -> Void in
                print("Network fetched failed with status code %d", statusCode)
            })
    }
    
    public func checkoutBook(_ book:Book?, callback:@escaping (Bool) -> Void = {(success:Bool) -> Void in}){
        if book == nil || User.sharedInstance.name == nil{
            return callback(false)
        }
        
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: (book?.url)!, method: NetworkManager.NetworkMethod.PUT, parameters: ["lastCheckedOutBy": User.sharedInstance.name], successCallback: { (responseObject:Any?) -> Void in
            
            if let data = responseObject as? NSDictionary{
                book?.update(withData: data)
            }
            
            callback(true)
            
            
            }, errorCallback: { (statusCode: Int) -> Void in
                print("Network fetched failed with status code %d", statusCode)
                callback(false)
        })
        
    }
}
