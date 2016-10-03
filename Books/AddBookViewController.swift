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
        
        
        if (title?.isEmpty)! || (author?.isEmpty)! || (publisher?.isEmpty)! || (tags?.isEmpty)!{
            return SharedMethods.showAlert(withTitle: "Error", message: "You must fill out all the fields before submitting", actions: nil, onViewController: self)
        }
        let pars:NSDictionary = NSDictionary(objects: [title!, publisher!, author!, tags!], forKeys: ["title" as NSCopying, "publisher" as NSCopying, "author" as NSCopying, "categories" as NSCopying])
        
        self.submitButton?.showActivityIndicatorView()

        BookStore.sharedInstance.createBook(withData: pars, callback: {(success) -> Void in
            self.submitButton?.hideActivityIndicatorView()
            
            if success{
                LibraryTableViewController.sharedInstance.tableView.reloadData()
                
                let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in
                    self.dismiss(animated: true, completion: nil)
                })
                
                SharedMethods.showAlert(withTitle: "Successfully created", message: String(format:"'%@' was successfully created.", title!), actions: ok, onViewController: self)

            }
            else{
                SharedMethods.showAlert(withTitle: "Error", message: "There was an error creating this book. Please try again.", actions: nil, onViewController: self)

            }
        })

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc private func doneButtonTapped(){
        if (self.titleField?.text?.isEmpty)! && (self.authorField?.text?.isEmpty)! && (self.publisherField?.text?.isEmpty)! && (self.tagsField?.text?.isEmpty)!{
            return self.dismiss(animated: true, completion: nil)
        }
        
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        let no = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in })
        
        SharedMethods.showAlert(withTitle: "Confirmation", message: "You have unfilled fields. Are you sure you want to leave?", actions: yes, no, onViewController: self)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing()
        return true
    }


}
