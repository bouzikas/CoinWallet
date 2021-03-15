//
//  WalletCell.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import UIKit

class WalletCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencyImageView: UIImageView!
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var item: WalletViewModel! {
        didSet {
            currencyNameLabel.text = item.name
            balanceLabel.text = item.balance
            currencyImageView.image = UIImage(named: item.currencyIcon)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
