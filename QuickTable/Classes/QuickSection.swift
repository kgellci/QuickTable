//
//  QuickSection.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import UIKit

public protocol QuickSectionProtocol {
    var headerTitle: String? { get set }
    var footerTitle: String? { get set }
    var rowHeight: CGFloat? { get set }
    
    func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow
    func numberOfRows() -> Int
    func heightForRow(_ row: Int) -> CGFloat
}

public enum QuickSectionOption {
    case headerTitle(String)
    case footerTitle(String)
    case rowCount(Int)
    case rowHeight(CGFloat)
}

public class QuickSectionBase: QuickSectionProtocol {
    public var headerTitle: String?
    public var footerTitle: String?
    public var rowHeight: CGFloat?
    
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
    
    public func numberOfRows() -> Int {
        assert(false, "numberOfRows not implemented in subclass")
    }
    
    public func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow {
        assert(false, "cellModelAtRow not implemented in subclass")
    }
    
    public func heightForRow(_ row: Int) -> CGFloat {
        assert(false, "heightForRow not implemented in subclass")
    }
}

public class QuickSectionDynamic: QuickSectionBase {
    private let cellFetchBlock: (Int) -> QuickRow
    private var rowsCount: Int = 0
    
    public init(options: [QuickSectionOption], cellFetchBlock: @escaping (Int) -> QuickRow) {
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
    
    override public func numberOfRows() -> Int {
        return rowsCount
    }
    
    override public func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow {
        return cellFetchBlock(row)
    }
    
    override public func heightForRow(_ row: Int) -> CGFloat {
        if let rowHeight = rowHeight {
            return rowHeight
        }
        return cellFetchBlock(row).height()
    }
}

public class QuickSection: QuickSectionBase {
    public var cellModels = [QuickRow]()
    
    public init(options: [QuickSectionOption]?) {
        super.init()
        guard let options = options else { return }
        self.populateFromOptions(options)
    }
    
    func cellModelForRow(_ row: Int) -> QuickRow {
        return cellModels[row]
    }
    
    override public func numberOfRows() -> Int {
        return cellModels.count
    }
    
    override public func cellModelAtRow(_ row: Int, forTableView tableView: UITableView) -> QuickRow {
        return cellModelForRow(row)
    }
    
    override public func heightForRow(_ row: Int) -> CGFloat {
        if let rowHeight = rowHeight {
            return rowHeight
        }
        return cellModels[row].height()
    }
}
