//
//  QuickSection.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import UIKit

protocol QuickSectionProtocol {
    var headerTitle: String? { get set }
    var footerTitle: String? { get set }
    var rowHeight: CGFloat? { get set }
    
    func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow
    func numberOfRows() -> Int
    func heightForRow(_ row: Int) -> CGFloat
}

enum QuickSectionOption {
    case headerTitle(String)
    case footerTitle(String)
    case rowCount(Int)
    case rowHeight(CGFloat)
}

class QuickSectionBase: QuickSectionProtocol {
    var headerTitle: String?
    var footerTitle: String?
    var rowHeight: CGFloat?
    
    fileprivate func populateFromOptions(_ options: [QuickSectionOption]) {
        for option in options {
            populateFromOption(option)
        }
    }
    
    fileprivate func populateFromOption(_ option: QuickSectionOption) {
        switch option {
        case .headerTitle(let text):
            headerTitle = text
        case .footerTitle(let text):
            footerTitle = text
        case .rowHeight(let rowHeight):
            self.rowHeight = rowHeight
        default:
            print("\(option) not handled by super")
        }
    }
    
    func numberOfRows() -> Int {
        assert(false, "numberOfRows not implemented in subclass")
    }
    
    func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow {
        assert(false, "cellModelAtRow not implemented in subclass")
    }
    
    func heightForRow(_ row: Int) -> CGFloat {
        assert(false, "heightForRow not implemented in subclass")
    }
}

class QuickSectionDynamic: QuickSectionBase {
    private let cellFetchBlock: (Int) -> QuickRow
    private var rowsCount: Int = 0
    
    init(options: [QuickSectionOption], cellFetchBlock: @escaping (Int) -> QuickRow) {
        self.cellFetchBlock = cellFetchBlock
        super.init()
        self.populateFromOptions(options)
    }
    
    override func populateFromOption(_ option: QuickSectionOption) {
        switch option {
        case .rowCount(let count):
            rowsCount = count
        default:
            super.populateFromOption(option)
        }
    }
    
    override func numberOfRows() -> Int {
        return rowsCount
    }
    
    override func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow {
        return cellFetchBlock(row)
    }
    
    override func heightForRow(_ row: Int) -> CGFloat {
        if let rowHeight = rowHeight {
            return rowHeight
        }
        return cellFetchBlock(row).height()
    }
}

class TKSectionModel: QuickSectionBase {
    var cellModels = [QuickRow]()
    
    init(options: [QuickSectionOption]?) {
        super.init()
        guard let options = options else { return }
        self.populateFromOptions(options)
    }
    
    func cellModelForRow(_ row: Int) -> QuickRow {
        return cellModels[row]
    }
    
    override func numberOfRows() -> Int {
        return cellModels.count
    }
    
    override func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow {
        return cellModelForRow(row)
    }
    
    override func heightForRow(_ row: Int) -> CGFloat {
        if let rowHeight = rowHeight {
            return rowHeight
        }
        return cellModels[row].height()
    }
}
