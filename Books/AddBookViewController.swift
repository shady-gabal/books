//
//  AddBookViewController.swift
//  Books
//
//  Created by Shady Gabal on 10/2/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet var titleField:UITextField?
    @IBOutlet var authorField:UITextField?
    @IBOutlet var publisherField:UITextField?
    @IBOutlet var tagsField:UITextField?
    @IBOutlet var submitButton:SREButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButton?.roundCorners()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    init(){
        super.init(nibName: "AddBookViewController", bundle: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func submitButtonTapped(_ sender: AnyObject) {
        let title = self.titleField?.text
        let publisher = self.publisherField?.text
        let author = self.authorField?.text
        let tags = self.tagsField?.text
        
        if (title?.isEmpty)!{
            
        }
        else if (author?.isEmpty)!{
            
        }
        else if (publisher?.isEmpty)!{
            
        }
        else if (tags?.isEmpty)!{
            
        }
        
        
        
    }
    
    
    @objc private func endEditing(){
        self.view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Add Book"
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonTapped))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing()
        return true
    }
    
    @objc private func keyboardDidShow(_ notif:NSNotification){
//        let userInfo:NSDictionary = notif.value(forKey: "userInfo") as! NSDictionary
//        let keyboardFrame:CGRect = userInfo.object(forKey: "UIKeyboardBeginUserInfoKey").
//
        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)

            UIView.animate(withDuration: 0.3, animations: {() -> Void in
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: keyboardSize.height * -0.25)
            })
        }
    }

    @objc private func keyboardDidHide(_ notif:NSNotification){
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
    }

}
