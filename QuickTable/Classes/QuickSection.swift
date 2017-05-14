//
//  QuickSection.swift
//  Pods
//
//  Created by Kris Gellci on 5/11/17.
//
//

import UIKit

// MARK: Protocols

/// Protocol for the UITableViewDelegate and UITableViewDataSource to communicate with QuickSections
public protocol QuickSectionProtocol {
    /// The section header title
    var headerTitle: String? { get set }
    
    // The section footer title
    var footerTitle: String? { get set }
    
    // the Table View row height
    var rowHeight: CGFloat? { get set }
    
    /// A way to retrieve a row from the sections rows
    /// - Parameter index: the index for the row to be retrieved
    /// - Returns: The QuickRow at the given index
    func quickRowForIndex(_ index: Int) -> QuickRow
    
    /// A way to retrieve the number of rows in the section
    /// - Returns: the number of rows in the section
    func numberOfRows() -> Int
    
    /// A way to retrieve the height for a given row
    /// - Parameter index: the index for the row for which the height is needed
    /// - Returns: The height of the row at the given index. Defaults to UITableViewAutomaticDimension
    func heightForRowAtIndex(_ index: Int) -> CGFloat
}

// MARK: Enums

/// Options used to configure any subclass of QuickSectionBase
public enum QuickSectionOption {
    /// Pass in a String to set the section header title
    case headerTitle(String)
    
    /// Pass in a String to set the section footer title
    case footerTitle(String)
    
    /// Pass in an Int to set the number of rows in a section.  Used for QuickSectionDynamic only
    case rowCount(Int)
    
    /// Pass in a CGFloat to defince the default height for all rows in the section
    case rowHeight(CGFloat)
}

// MARK: Typealiases

/// Similar to UITableViewDataSource cellForRowAtIndexPath
public typealias QuickSectionDynamicRowBlock = (Int) -> QuickRow

// MARK: Classes

/// QuickSectionBase is a base class, not to be instantiated on its own, use one of the subclasses
public class QuickSectionBase: QuickSectionProtocol {
    public var headerTitle: String?
    public var footerTitle: String?
    public var rowHeight: CGFloat?
    
    /// parses the options and populates the Section
    fileprivate func populateFromOptions(_ options: [QuickSectionOption]) {
        for option in options {
            populateFromOption(option)
        }
    }
    
    /// populates the appropriate value on the section based on the passed in option
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
        return 0
    }
    
    public func quickRowForIndex(_ index: Int) -> QuickRow {
        assert(false, "cellModelAtRow not implemented in subclass")
        return QuickRow(reuseIdentifier: "", styleBlock: nil)
    }
    
    public func heightForRowAtIndex(_ index: Int) -> CGFloat {
        assert(false, "heightForRow not implemented in subclass")
        return 0
    }
}

/// A dynamic way to define a UITableView section
public class QuickSectionDynamic: QuickSectionBase {
    /// block will fire when the QuickRow is needed for display or calculating height
    private let quickRowFetchBlock: QuickSectionDynamicRowBlock
    
    /// number of rows in this section
    var rowCount: Int = 0
    
    public init(options: [QuickSectionOption], quickRowFetchBlock: @escaping QuickSectionDynamicRowBlock) {
        self.quickRowFetchBlock = quickRowFetchBlock
        super.init()
        self.populateFromOptions(options)
    }
    
    override func populateFromOption(_ option: QuickSectionOption) {
        switch option {
        case .rowCount(let count):
            rowCount = count
        default:
            super.populateFromOption(option)
        }
    }
    
    override public func numberOfRows() -> Int {
        return rowCount
    }
    
    public override func quickRowForIndex(_ index: Int) -> QuickRow {
        return quickRowFetchBlock(index)
    }
    
    public override func heightForRowAtIndex(_ index: Int) -> CGFloat {
        if let rowHeight = rowHeight {
            return rowHeight
        }
        return quickRowFetchBlock(index).height()
    }
}

// A way to define a section of rows in a UITableView
public class QuickSection: QuickSectionBase {
    /// QuickRow models to display in the section
    public var quickRowModels = [QuickRow]()
    
    /// instantiate an empty QuickSection
    public override init() {
        super.init()
    }
    
    /// Instantiate a QuickSection from the given QuickRows
    /// - Parameter quickRowModels: QuickRow Array which the section will display
    public init(quickRowModels: [QuickRow]) {
        super.init()
        self.quickRowModels = quickRowModels
    }
    
    /// instantiate a QuickSection populated by the given options
    /// - Parameter options: something
    public init(options: [QuickSectionOption]) {
        super.init()
        self.populateFromOptions(options)
    }
    
    /// instantiate a QuickSection populated by the given options and QuickRows
    /// - Parameter quickRowModels: QuickRow Array which the section will display
    /// - Parameter options: something
    public init(quickRowModels: [QuickRow], options: [QuickSectionOption]) {
        super.init()
        self.quickRowModels = quickRowModels
        self.populateFromOptions(options)
    }
    
    /// A convenient way to add a single QuickRow to a QuickSections rows. The QuickRow will be added to the end.
    /// - Parameter left: The QuickSection to add the QuickRow to
    /// - Parameter right: The QuickRow to be added to the QuickSections list of rows
    public static func +=(left: QuickSection, right: QuickRow) { // 1
        left.quickRowModels.append(right)
    }
    
    public override func quickRowForIndex(_ index: Int) -> QuickRow {
        return quickRowModels[index]
    }
    
    override public func numberOfRows() -> Int {
        return quickRowModels.count
    }
    
    public override func heightForRowAtIndex(_ index: Int) -> CGFloat {
        if let rowHeight = rowHeight {
            return rowHeight
        }
        return quickRowModels[index].height()
    }
}
