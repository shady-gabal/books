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
    
    public func fetchBooks(callback: @escaping (Bool) -> Void = {(success:Bool) in }){
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: "/books", method: NetworkManager.NetworkMethod.GET, parameters: [:], successCallback: { (responseObject:Any?) -> Void in
            
            self.books = []

            if let booksArray = responseObject as? Array<Any> {
                for bookDict in booksArray {
                    if let bookData = bookDict as? NSDictionary{
                        let newBook:Book = Book(bookData)
                        self.books.insert(newBook, at: 0)
                    }
                }
            }
            
            callback(true)
            
            }, errorCallback: { (statusCode: Int) -> Void in
                print("Network fetched failed with status code %d", statusCode)
                callback(false)
            })
    }
    
    public func updateBook(_ book:Book?, withData:NSDictionary, callback:@escaping (Bool) -> Void = {(success:Bool) -> Void in}){
        if book == nil || book?.url == nil{
            return callback(false)
        }
        
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: (book?.url)!, method: NetworkManager.NetworkMethod.PUT, parameters: withData, successCallback: {(responseObject) -> Void in
            
            book?.update(withData: responseObject as! NSDictionary)
            callback(true)
            
            }, errorCallback: {(statusCode) -> Void in
                callback(false)
        })
    }
    
    public func createBook(withData:NSDictionary, callback:@escaping (Bool) -> Void = {(success:Bool) -> Void in}){
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: "/books", method: NetworkManager.NetworkMethod.POST, parameters: withData, successCallback: {(responseObject) -> Void in
            
            let newBook:Book = Book(responseObject as! NSDictionary)
            self.books.append(newBook)
            callback(true)
            
            }, errorCallback: {(statusCode) -> Void in
                callback(false)
        })
    }
    
    public func checkoutBook(_ book:Book?, callback:@escaping (Bool) -> Void = {(success:Bool) -> Void in}){
        if book == nil || User.sharedInstance.name == nil || book?.url == nil{
            return callback(false)
        }
        
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: (book?.url)!, method: NetworkManager.NetworkMethod.PUT, parameters: ["lastCheckedOutBy": User.sharedInstance.name!], successCallback: { (responseObject:Any?) -> Void in
            
            if let data = responseObject as? NSDictionary{
                book?.update(withData: data)
            }
            
            callback(true)
            
            
            }, errorCallback: { (statusCode: Int) -> Void in
                callback(false)
        })
        
    }
    
    public func deleteBook(_ book:Book?, callback:@escaping (Bool) -> Void = {(success:Bool) -> Void in}){
        if book == nil || book?.url == nil{
            return callback(false)
        }
        
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: (book?.url)!, method: NetworkManager.NetworkMethod.DELETE, parameters: [:], successCallback: { (responseObject:Any?) -> Void in
            
            for i in 0...self.books.count-1{
                let curr = self.books[i]
                if curr == book{
                    self.books.remove(at: i)
                    break
                }
            }
            
                callback(true)
            
            }, errorCallback: { (statusCode: Int) -> Void in
                print("Network fetched failed with status code %d", statusCode)
                callback(false)
        })
    }
    
    public func deleteAllBooks(callback:@escaping (Bool) -> Void = {(success:Bool) -> Void in}){
        NetworkManager.sharedInstance.networkRequestToLibrary(urlSuffix: "/clean", method: NetworkManager.NetworkMethod.DELETE, parameters: [:], successCallback: { (responseObject:Any?) -> Void in
            
            self.books = []
            callback(true)
            
            }, errorCallback: { (statusCode: Int) -> Void in
                print("Network fetched failed with status code %d", statusCode)
                callback(false)
        })
    }
}
