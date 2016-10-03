//
//  SharedMethods.swift
//  Books
//
//  Created by Shady Gabal on 10/3/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class SharedMethods: NSObject {
    
    static func showAlert(withTitle:String!, message:String!, actions:UIAlertAction?..., onViewController:UIViewController!){
        let alert:UIAlertController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        if actions.count > 0 && actions[0] != nil{
            for action in actions{
                alert.addAction(action!)
            }
        }
        else{
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            }
            alert.addAction(okAction)
        }

        onViewController.present(alert, animated: true, completion: nil)
    }
    
}
