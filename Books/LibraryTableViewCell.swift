//
//  LibraryTableViewCell.swift
//  Books
//
//  Created by Shady Gabal on 9/30/16.
//  Copyright © 2016 Shady Gabal. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var authorLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(withBook: Book?){
        self.titleLabel?.text = withBook?.title
        self.authorLabel?.text = withBook?.author
    }
    
}
