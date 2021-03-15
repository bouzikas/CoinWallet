//
//  TransactionCell.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var actionStr: UILabel!
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var item: TransactionViewModel! {
        didSet {
            actionLabel.text = item.action
            balanceLabel.text = item.amount
            actionStr.text = item.actionStr
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
