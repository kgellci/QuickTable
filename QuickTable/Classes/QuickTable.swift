//
//  QuickTable.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import UIKit

class QuickTable: UITableView {
    var sections = [QuickSectionProtocol]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        dataSource = self
        delegate = self
    }
}

extension QuickTable: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].cellModelAtRow(indexPath.row, forTableView: tableView)
        let cell = cellModel.cellForTableView(tableView)
        
        cellModel.styleBlock?(cell)
        cell.selectionStyle = cellModel.selectionBlock == nil ? .none : cellModel.selectionStyle
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
    }
}

extension QuickTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].cellModelAtRow(indexPath.row, forTableView: tableView)
        guard let selectionBlock = cellModel.selectionBlock else { return }
        if selectionBlock(cellModel.cellForTableView(tableView)) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].heightForRow(indexPath.row)
    }
}
