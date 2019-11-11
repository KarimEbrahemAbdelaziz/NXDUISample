//
//  Section.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 19.07.19.
//

import Foundation

/// Represents a single section of a table
struct Section: ConvertibleToASection {
    internal let rows: [_Row]

    /// Creates a Section with the specified `Rows`
    /// Updates to a Section created this way are performed in a fine-grained manner.
    ///
    /// - Parameter header: Header of the section - optional
    /// - Parameter footer: Footer of the section - optional
    /// - Parameter action: Optional closure to be called when a row is selected.
    /// Offset of the selected row is passed as a parameter
    /// - Parameter style: Style of the section, defaults to `.none`
    /// - Parameter rows: Closure providing the rows for the section
    init(
        header: Body? = nil,
        footer: Body? = nil,
        action: ((Int) -> Void)? = nil,
        rows: () -> [Row]) {
        let allRows = rows().enumerated().map { index, row -> _Row in
            return _Row(row: row, action: {
                action?(index)
            })
        }
        self.init(header: header, footer: footer, content: allRows)
    }

    internal init(header: Body? = nil,
                  footer: Body? = nil,
                  content: [_Row]) {
        var allRows: [_Row] = []
        /// Append header
        if let header = header {
            allRows.append(_Row(body: header))
        }
        /// Append rows
        allRows.append(contentsOf: content)
        /// Append footer
        if let footer = footer {
            allRows.append(_Row(body: footer))
        }
        self.init(allRows)
    }

    internal init(_ rows: [_Row]) {
        self.rows = rows
    }

    // MARK: ConvertibleToASection
    /// Section can be converted to a Section
    var asSection: Section {
        return self
    }
    
}


extension Section {
    public init<ViewModel>(
        header: Body? = nil,
        footer: Body? = nil,
        viewModels: [ViewModel],
        body: (ViewModel) -> Body) {
        let content = viewModels.map { viewModel -> _Row in
            let id: ID
            if let identifiable = viewModel as? Identifiable {
                id = identifiable.id
                print("ID: ", identifiable.id)
            } else {
                print("Unique! \(viewModel)")
                id = Unique()
            }
            return _Row(
                body: body(viewModel),
                id: id,
                action: {}
            )
        }

        self.init(header: header, footer: footer, content: content)
    }
}
