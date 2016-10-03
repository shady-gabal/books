//
//  LibraryTableViewController.swift
//  Books
//
//  Created by Shady Gabal on 9/28/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit


class LibraryTableViewController: UITableViewController {
    static let LibraryCellReuseIdentifier = "LibraryTableViewCell"
    static let CellHeight:CGFloat = 80.0
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib:UINib = UINib.init(nibName: "LibraryTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: LibraryTableViewController.LibraryCellReuseIdentifier)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = LibraryTableViewController.CellHeight
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.fetchBooks), for: UIControlEvents.valueChanged)
        
        fetchBooks()
    }
    
    func fetchBooks(){
        self.showActivityIndicator()
        BookStore.sharedInstance.fetchBooks(callback: {() -> Void in
            self.hideActivityIndicator()
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    private func showActivityIndicator(){
        activityIndicator.center = CGPoint(x: self.view.frame.size.width/2.0, y: self.view.frame.size.height/2.0 - (self.navigationController?.navigationBar.frame.size.height)!)
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookStore.sharedInstance.allBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LibraryTableViewCell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewController.LibraryCellReuseIdentifier, for: indexPath) as! LibraryTableViewCell
        let book:Book? = findBook(atIndexPath: indexPath)
        if book != nil{
            cell.configure(withBook: book!)
        }

        return cell
    }
 
    func findBook(atIndexPath: IndexPath) -> Book?{
        let sec = atIndexPath.section
        let row = atIndexPath.row
        if sec == 0 && row < BookStore.sharedInstance.allBooks.count{
            return BookStore.sharedInstance.allBooks[row] as? Book
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book:Book? = findBook(atIndexPath: indexPath)
        if book == nil{
            return
        }
        let detail:BookDetailViewController = BookDetailViewController(withBook: book)
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Books"
        let addButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(LibraryTableViewController.addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped(){
        let add:AddBookViewController = AddBookViewController()
        let nav = UINavigationController(rootViewController: add)
        nav.navigationBar.isTranslucent = false
        
        self.present(nav, animated: true, completion: nil)
    }



}
