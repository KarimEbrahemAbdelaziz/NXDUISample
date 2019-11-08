//
//  List.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 19.07.19.
//

import UIKit

struct List: TypeSafeBody {
    private let allRows: [_Row]

    init(header: Body? = nil, footer: Body? = nil, sections: () -> [ConvertibleToASection]) {
        var allRows: [_Row] = []

        /// Append header
        if let header = header {
            allRows.append(_Row(body: header))
        }

        /// Append sections
        allRows.append(contentsOf: sections().flatMap { $0.asSection.rows })

        /// Append footer
        if let footer = footer {
            allRows.append(_Row(body: footer))
        }

        self.allRows = allRows
    }

    func createBackingView() -> ListView {
        return ListView(allRows: allRows)
    }
    
    func adapt(view: ListView, from other: List, animated: Bool) {
        view.update(to: allRows,
                    animated: animated)
    }
}
