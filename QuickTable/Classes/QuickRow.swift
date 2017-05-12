//
//  QuickRow.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import Foundation


import UIKit

public class QuickRow {
    private var reuseIdentifier: String
    public var styleBlock: ((UITableViewCell) -> Void)?
    public var selectionBlock: ((UITableViewCell) -> Bool)?
    public var selectionStyle: UITableViewCellSelectionStyle = .default
    public var computeRowHeightBlock: ((QuickRow) -> CGFloat)?
    
    public init(reuseIdentifier: String, styleBlock: ((UITableViewCell) -> Void)?) {
        self.reuseIdentifier = reuseIdentifier
        self.styleBlock = styleBlock
    }
    
    public init(reuseIdentifier: String, styleBlock: ((UITableViewCell) -> Void)?, selectionBlock: @escaping ((UITableViewCell) -> Bool)) {
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
