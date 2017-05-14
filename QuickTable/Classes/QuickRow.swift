//
//  QuickRow.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import UIKit

/// Called passing in the UITableViewCell for setup of the cell.
public typealias QuickRowStyleBlock = (UITableViewCell) -> Void

/// Called when a UITableViewCell is tapped by the user.  Returns if the cell should auto deselect
public typealias QuickRowSelectionBlock = (UITableViewCell) -> Bool

/// Called to allow for custom height compution before a UITableViewCell is displayed. Returns the computed height.
public typealias QuickRowComputeHeightBlock = (QuickRow) -> CGFloat

/// The data used by any subclass of QuickSectionBase to define the UITableViewCells which will be displayed
public class QuickRow {
    /// Used in dequeueReusableCellWithIdentifier on UITableView
    private var reuseIdentifier: String
    
    /// executed when the UITableViewCell needs to be setup for display
    public var styleBlock: QuickRowStyleBlock?
    
    /// executed when the user taps a UITableViewCell
    public var selectionBlock: QuickRowSelectionBlock?
    
    /// The selection style for UITableViewCell
    public var selectionStyle: UITableViewCellSelectionStyle = .default
    
    /// The preComputed row height
    public var computeRowHeightBlock: QuickRowComputeHeightBlock?
    
    /// A convenient way to initialize a QuickRow with common params
    /// - Parameter reuseIdentifier: The reuse identifier for the UITableViewCell, will later be used in dequeueReusableCellWithIdentifier on UITableView.
    /// - Parameter styleBlock: The block used to setup the UITableViewCell before it is displayed
    public init(reuseIdentifier: String, styleBlock: QuickRowStyleBlock?) {
        self.reuseIdentifier = reuseIdentifier
        self.styleBlock = styleBlock
    }
    
    /// A convenient way to initialize a QuickRow with common params
    /// - Parameter reuseIdentifier: The reuse identifier for the UITableViewCell, will later be used in dequeueReusableCellWithIdentifier on UITableView.
    /// - Parameter styleBlock: The block used to setup the UITableViewCell before it is displayed
    /// - Parameter selectionBlock: The block which is executed when the user taps on a UITableViewCell
    public init(reuseIdentifier: String, styleBlock: QuickRowStyleBlock?, selectionBlock: QuickRowSelectionBlock?) {
        self.reuseIdentifier = reuseIdentifier
        self.styleBlock = styleBlock
        self.selectionBlock = selectionBlock
    }
    
    /// Used by the UITableView to retrieve the cell
    /// - Parameter tableView: The UITableView which will display the cell
    /// - Returns: The UITableViewCell for display
    func cellForTableView(_ tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
    }
    
    /// The height of the UITableViewCell to be displayed
    /// - Returns: the height of the UItableViewCell, default is UITableViewAutomaticDimension
    func height() -> CGFloat {
        if let computeRowHeightBlock = computeRowHeightBlock {
            return computeRowHeightBlock(self)
        }
        return UITableViewAutomaticDimension
    }
}
