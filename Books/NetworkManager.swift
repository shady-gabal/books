//
//  NetworkManager.swift
//  Books
//
//  Created by Shady Gabal on 9/28/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkManager: NSObject {
    
    var manager: AFURLSessionManager
    
    public enum NetworkMethod:String{
        case POST = "POST"
        case GET = "GET"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    static let sharedInstance = NetworkManager()
    
    override init(){
        let configuration = URLSessionConfiguration.default
        self.manager = AFURLSessionManager(sessionConfiguration: configuration)
    }
    
    
    public func networkRequest(urlString: String, method: NetworkMethod, parameters: NSDictionary!, successCallback : @escaping (Any?) -> Void, errorCallback: @escaping (Int) -> Void){
        
        var error:NSError?
        
        let request:NSURLRequest = AFHTTPRequestSerializer().request(withMethod: method.rawValue, urlString: urlString, parameters: parameters, error: &error)
        
        func callback(response:URLResponse, responseObject:Any?, error:Error?) -> Void {
            let statusCode = (response as! HTTPURLResponse).statusCode


            if error != nil || statusCode >= 400{
                errorCallback(statusCode)
                
            }
            else{
                successCallback(responseObject)
            }
            
        }
        
        let dataTask = self.manager.dataTask(with: request as URLRequest, completionHandler: callback)
        dataTask.resume()

    }
    
//
    
    public func networkRequestToLibrary(urlSuffix: String, method: NetworkMethod, parameters: NSDictionary, successCallback : @escaping (Any?) -> Void, errorCallback: @escaping (Int) -> Void) {
        
        let baseUrl = "https://prolific-interview.herokuapp.com/57e18ffd52f66d0009aa75eb"
        let url = baseUrl + urlSuffix

        self.networkRequest(urlString: url, method: method, parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
        
    }

}
