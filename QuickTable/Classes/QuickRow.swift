//
//  QuickRow.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import Foundation


import UIKit

class QuickRow {
    private var reuseIdentifier: String
    var styleBlock: ((UITableViewCell) -> Void)?
    var selectionBlock: ((UITableViewCell) -> Bool)?
    var selectionStyle: UITableViewCellSelectionStyle = .default
    var computeRowHeightBlock: ((QuickRow) -> CGFloat)?
    
    init(reuseIdentifier: String, styleBlock: ((UITableViewCell) -> Void)?) {
        self.reuseIdentifier = reuseIdentifier
        self.styleBlock = styleBlock
    }
    
    init(reuseIdentifier: String, styleBlock: ((UITableViewCell) -> Void)?, selectionBlock: @escaping ((UITableViewCell) -> Bool)) {
        self.reuseIdentifier = reuseIdentifier
        self.styleBlock = styleBlock
        self.selectionBlock = selectionBlock
    }
    
    func cellForTableView(_ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        return cell
    }
    
    func height() -> CGFloat {
        if let computeRowHeightBlock = computeRowHeightBlock {
            return computeRowHeightBlock(self)
        }
        return UITableViewAutomaticDimension
    }
}
