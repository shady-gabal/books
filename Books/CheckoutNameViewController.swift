//
//  CheckoutNameViewController.swift
//  Books
//
//  Created by Shady Gabal on 10/1/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class CheckoutNameViewController: UIViewController {

    var book:Book?
    @IBOutlet var checkoutButton:UIButton?
    @IBOutlet var nameField:UITextField?
    @IBOutlet var bookTitleLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkoutButton?.layer.cornerRadius = 5
        self.bookTitleLabel?.text = self.book?.title
    }
    
    init(withBook:Book?){
        super.init(nibName: "CheckoutNameViewController", bundle: nil)
        book = withBook
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func checkoutButtonTapped(_ sender: AnyObject) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.title = "Detail"
//        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CheckoutNameViewController.doneButtonTapped))
//        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @IBAction private func doneButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
}
