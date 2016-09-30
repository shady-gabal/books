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

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib:UINib = UINib.init(nibName: "LibraryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: LibraryTableViewController.LibraryCellReuseIdentifier)
        
        BookStore.sharedInstance.fetchBooks(callback: {() -> Void in
            self.tableView.reloadData()
        })
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LibraryTableViewController.CellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LibraryTableViewCell = tableView.dequeueReusableCell(withIdentifier: LibraryTableViewController.LibraryCellReuseIdentifier, for: indexPath) as! LibraryTableViewCell
        let book:Book? = findBook(atIndexPath: indexPath)
        if book != nil{
            cell.configure(withBook: book!)
//            cell.detailTextLabel?.text = book?.author
//            cell.textLabel?.text = book?.title
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
