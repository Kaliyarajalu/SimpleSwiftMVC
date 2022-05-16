//
//  CustomCell.swift
//  SimpleSwiftMVC
//
//  Created by Apple on 16/05/22.
//

import UIKit

class CustomCell: UITableViewCell {

    //
    // MARK: - Constants
    //
    static let identifier = "CustomCell"
    
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    
    //
    // MARK: - Table View Cell
    //
    override func prepareForReuse() {
        super.prepareForReuse()
        
        firstLabel.text = nil
        secondLabel.text = nil
    }

}
