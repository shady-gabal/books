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
    @IBOutlet var checkoutButton:UIButton?

    var book:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkoutButton?.layer.cornerRadius = 5

        self.tagsLabel?.text = self.book?.categories != nil ? "Tags: " + (self.book?.categories)! : "No tags"
        self.authorLabel?.text = self.book?.author
        self.titleLabel?.text = self.book?.title
        self.publisherLabel?.text = self.book?.publisher != nil ?  "Publisher: " + (self.book?.publisher)! : "No publisher"
        self.lastCheckedOutByLabel?.text = self.book?.lastCheckedOutDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
