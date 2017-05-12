//
//  ViewController.swift
//  QuickTable
//
//  Created by kgellci on 05/11/2017.
//  Copyright (c) 2017 kgellci. All rights reserved.
//

import UIKit
import QuickTable

class ViewController: UIViewController {
    @IBOutlet weak var tableView: QuickTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        // Extra Section
        
        let extraSection = QuickSection(options: nil)
        
        extraSection.cellModels = [QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
            cell.textLabel?.text = "This is a blank section with a single cell"
        })]
        
        // Section 1
        let firstSection = QuickSection(options: [.headerTitle("Section 1")])
        
        firstSection.cellModels.append(QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
            cell.textLabel?.text = "This is a cell 1"
        }))
        
        firstSection.cellModels.append(QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
            cell.textLabel?.text = "You can select this"
        }, selectionBlock: { (cell) -> Bool in
            return false
        }))
        
        firstSection.cellModels.append(QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
            cell.textLabel?.text = "You can select this and it will auto deselect"
        }, selectionBlock: { (cell) -> Bool in
            return true
        }))
        
        // Section 2
        let secondSection = QuickSection(options: [.headerTitle("Section 2"), .footerTitle("This one has a footer")])
        
        secondSection.cellModels.append(QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
            cell.textLabel?.text = "This is a cell 1"
        }))
        
        let cell = QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
            cell.textLabel?.text = "This is a cell 2"
        })
        cell.computeRowHeightBlock = { (cell) -> CGFloat in
            return 150
        }
        secondSection.cellModels.append(cell)
        
        
        // dynamic section
        let options = [QuickSectionOption.headerTitle("Dynamic Section"), QuickSectionOption.rowCount(10), QuickSectionOption.rowHeight(100)]
        let dynamicSection = QuickSectionDynamic(options: options) { (row) -> QuickRow in
            let model = QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
                cell.textLabel?.text = "cell \(row)"
            })
            return model
        }
        
        tableView.sections = [extraSection, firstSection, secondSection, dynamicSection]
    }

}

