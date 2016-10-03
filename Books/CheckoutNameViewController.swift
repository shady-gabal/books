//
//  CheckoutNameViewController.swift
//  Books
//
//  Created by Shady Gabal on 10/1/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class CheckoutNameViewController: UIViewController, UITextFieldDelegate{
    
    var book:Book?
    var callback:(() -> Void)?
    
    @IBOutlet var saveButton:SREButton?
    @IBOutlet var nameField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton?.roundCorners()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    init(withCallback: @escaping () -> Void){
        super.init(nibName: "CheckoutNameViewController", bundle: nil)
        callback = withCallback
    }
    
    @objc private func endEditing(){
        self.view.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        self.endEditing()
        let name:String? = self.nameField?.text?.trimmingCharacters(in:
            NSCharacterSet.whitespacesAndNewlines)
        
        if name != nil && (name?.characters.count)! > 0{
            if validateName(name){
                saveName(name)
                
                self.dismiss(animated: true, completion: {(finished) -> Void in
                    if self.callback != nil{
                        self.callback!()
                    }
                })
                
            }
            else{
                SharedMethods.showAlert(withTitle: "Error", message: "Your name can only contain letters and spaces", actions: nil, onViewController: self)
            }

        }
        else{
             SharedMethods.showAlert(withTitle: "Error", message: "You must enter a valid name before submitting", actions: nil, onViewController: self)
        }
    }
    
    private func validateName(_ name:String!) -> Bool{
        do
        {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z ]*$", options: .caseInsensitive)
            if regex.matches(in:name, options: [], range: NSMakeRange(0, name.characters.count)).count > 0 {return true}
        }
        catch {}
        return false
    }
    
    
    private func saveName(_ name:String!){
        UserDefaults.standard.set(name!, forKey: Constants.DefaultsKeyName)
        User.sharedInstance.name = name
//        NotificationCenter.default.post(name: Constants.NotificationNameSaved, object: nil)
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing()
        return true
    }
    

    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return true
//    }
//
//    - (void)keyboardDidShow: (NSNotification *) notif{
//    NSDictionary *userInfo = [notif valueForKey:@"userInfo"];
//    CGRect kbFrame = [[userInfo objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kbFrame.size.height, 0);
//    
//    }
//    
//    - (void)keyboardDidHide: (NSNotification *) notif{
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }

//    @objc private func keyboardDidShow(_ notif:NSNotification){
////        let userInfo:NSDictionary = notif.value(forKey: "userInfo") as! NSDictionary
////        let keyboardFrame:CGRect = userInfo.object(forKey: "UIKeyboardBeginUserInfoKey").
////        
//        if let keyboardSize = (notif.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//            
//            UIView.animate(withDuration: 0.3, animations: {() -> Void in
//                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: keyboardSize.height * -0.25)
//            })
//        }
//        
//
//    }
//    
//    @objc private func keyboardDidHide(_ notif:NSNotification){
//        UIView.animate(withDuration: 0.3, animations: {() -> Void in
//            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        })
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Name"
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonTapped))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func doneButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
}
