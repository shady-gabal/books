//
//  BookDetailViewController.swift
//  Books
//
//  Created by Shady Gabal on 9/29/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet var scrollView:UIScrollView?
    @IBOutlet var tagsLabel:UILabel?
    @IBOutlet var authorLabel:UILabel?
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var lastCheckedOutByLabel:UILabel?
    @IBOutlet var publisherLabel:UILabel?
    @IBOutlet var checkoutButton:SREButton?

    var book:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkoutButton?.roundCorners()
        self.configure()
    }
    
    func configure(){
        self.tagsLabel?.text = self.book?.categories != nil ? "Tags: " + (self.book?.categories)! : "No tags"
        self.authorLabel?.text = self.book?.author
        self.titleLabel?.text = self.book?.title
        self.publisherLabel?.text = self.book?.publisher != nil ?  "Publisher: " + (self.book?.publisher)! : "No publisher"
        self.lastCheckedOutByLabel?.text = self.book?.lastCheckedOutDescription

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(withBook : Book!){
        super.init(nibName: "BookDetailViewController", bundle: nil)
        book = withBook
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var contentRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        for view:UIView in (self.scrollView?.subviews)! {
            contentRect = contentRect.union(view.frame);
        }
        self.scrollView?.contentSize = contentRect.size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Detail"
        let shareButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(BookDetailViewController.shareButtonTapped))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc private func shareButtonTapped(){
        let desc:String = (self.book?.bookDescription())!
        let activityViewController = UIActivityViewController(activityItems: [desc], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    @IBAction func checkoutButtonTapped(_ sender: AnyObject) {
        if User.sharedInstance.name == nil{
            let nameController:CheckoutNameViewController = CheckoutNameViewController(withCallback: {() -> Void in
                self.checkoutBook()
            })
            let nav = UINavigationController(rootViewController: nameController)
            nav.navigationBar.isTranslucent = false

            self.present(nav, animated: true, completion: nil)
        }
        else{
            checkoutBook()
        }
    }
    
    func checkoutBook(){
        if !(self.checkoutButton?.isAnimating)!{
            self.checkoutButton?.showActivityIndicatorView()
            
            BookStore.sharedInstance.checkoutBook(book, callback: {(succeeded: Bool) -> Void in
                self.checkoutButton?.hideActivityIndicatorView()
                
                if succeeded{
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        self.checkoutButton?.setTitle("Checked Out", for: UIControlState.normal)
                        self.checkoutButton?.isEnabled = false
                        self.configure()
                    }
                    
                    SharedMethods.showAlert(withTitle: "Success", message: String(format:"Successfully checked out '%@'", (self.book?.title)!), actions: okAction, onViewController: self)
                        

                }
                else{
                    SharedMethods.showAlert(withTitle: "Error", message: "There was an error checking out this book. Please try again", actions: nil, onViewController: self)
                }
            })
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: AnyObject) {
        
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in
            BookStore.sharedInstance.deleteBook(self.book, callback: {(success) -> Void in
                if success{
                    LibraryTableViewController.sharedInstance.tableView.reloadData()

                    let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in
                        _ = self.navigationController?.popToRootViewController(animated: true)
                    })
                    SharedMethods.showAlert(withTitle: "Success", message: "Successfully deleted book", actions: ok, onViewController: self)
                }
                else{
                   SharedMethods.showAlert(withTitle: "Error", message: "There was an error deleting this book. Please try again.", actions: nil, onViewController: self)
                }
            })
        })
        let no = UIAlertAction(title: "No", style: .cancel, handler: {(action) -> Void in })

        
        SharedMethods.showAlert(withTitle: "Confirmation", message: String(format:"Are you sure you want to delete %@?", (self.book?.title) ?? "this book"), actions: yes, no, onViewController: self)
        

    }
    
    @IBAction func editButtonTapped(_ sender: AnyObject) {
        let edit = AddBookViewController(toEditBook: self.book)
        edit.completionCallback = {() -> Void in
            self.configure()
        }
        let nav = UINavigationController(rootViewController: edit)
        nav.navigationBar.isTranslucent = false
        
        self.present(nav, animated: true, completion: nil)
    }


}
