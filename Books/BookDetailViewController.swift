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
            let nameController:CheckoutNameViewController = CheckoutNameViewController()
            let nav = UINavigationController(rootViewController: nameController)
            nav.navigationBar.isTranslucent = false

            self.present(nav, animated: true, completion: nil)
        }
        else{
            checkoutBook()
        }
    }
    
    func checkoutBook(){
        self.checkoutButton?.showActivityIndicatorView()
        
        BookStore.sharedInstance.checkoutBook(book, callback: {(succeeded: Bool) -> Void in
            self.checkoutButton?.hideActivityIndicatorView()
            
            if succeeded{
                self.checkoutButton?.setTitle("Checked Out", for: UIControlState.normal)
                self.checkoutButton?.isEnabled = false
                self.configure()
            }
            else{
                
            }
        })
    }
    

}
