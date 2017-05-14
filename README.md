# QuickTable

[![CI Status](http://img.shields.io/travis/kgellci/QuickTable.svg?style=flat)](https://travis-ci.org/kgellci/QuickTable)
[![Version](https://img.shields.io/cocoapods/v/QuickTable.svg?style=flat)](http://cocoapods.org/pods/QuickTable)
[![License](https://img.shields.io/cocoapods/l/QuickTable.svg?style=flat)](http://cocoapods.org/pods/QuickTable)
[![Platform](https://img.shields.io/cocoapods/p/QuickTable.svg?style=flat)](http://cocoapods.org/pods/QuickTable)
[![Swift 3.1](https://img.shields.io/badge/Swift-3.0-orange.svg)

## Warning

Currently developing to a stable version. Use as an experiment for now.

## Usage

QuickTable is a subclass of UITableView, you can set it up via interface builder or in code.  No need to worry about UItableViewDelegate and DataSource!

```swift
let tableView = QuickTable()
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
```

Create a row you want to display, add it to a section and set the section to the QuickTable

```swift
let row = QuickRow(reuseIdentifier: "MyTableViewCell", styleBlock: { (cell) in
    cell.textLabel?.text = "Hello World!"
})

let section = QuickSection(quickRowModels: [row])
```

You can style the section by passing options

```swift
let secondSection = QuickSection(options: [.headerTitle("The Header"), .footerTitle("The Footer")])
```

Tapping on a row is handled via a block

```swift
row.selectionBlock = { (cell) -> Bool in
    // The row was selected do something!

    // return if the cell should auto deselect
    return true
}
```

You can use automatic height computation or define the height on a section or row level

```swift
section.rowHeight = 60

// OR

row.computeRowHeightBlock { (row) -> CGFloat in
    return 100
}

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 3.1

## Installation

QuickTable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "QuickTable"
```

## Author

Kris Gellci, [![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://www.twitter.com/kgellci)

## License

QuickTable is available under the MIT license. See the LICENSE file for more info.
