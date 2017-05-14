//
//  QuickTable.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import UIKit

/// A subclass of UITableView which allwos for quick and easy setup.
/// QuickTable automatically sets itself as the UITableViews DataSource and Delegate.
public class QuickTable: UITableView {
    
    /// The sections which the table view will display
    public var sections = [QuickSectionProtocol]()
    
    /// Will initialize with a frame of 0 and a UITableViewStyle of plain
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        setup()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        dataSource = self
        delegate = self
    }
}

extension QuickTable: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].quickRowForIndex(indexPath.row)
        let cell = cellModel.cellForTableView(tableView)
        
        cellModel.styleBlock?(cell)
        cell.selectionStyle = cellModel.selectionBlock == nil ? .none : cellModel.selectionStyle
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
    }
}

extension QuickTable: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].quickRowForIndex(indexPath.row)
        guard let selectionBlock = cellModel.selectionBlock else { return }
        if selectionBlock(cellModel.cellForTableView(tableView)) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].heightForRowAtIndex(indexPath.row)
    }
}
