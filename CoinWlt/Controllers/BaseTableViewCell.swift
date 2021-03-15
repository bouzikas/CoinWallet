//
//  BaseTableViewCell.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import UIKit

class BaseTableViewCell<ModelView>: UITableViewCell {
    var item: ModelView!
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
