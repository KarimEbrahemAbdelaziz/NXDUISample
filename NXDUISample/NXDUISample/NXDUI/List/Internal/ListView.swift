//
//  ListView.swift
//  N26NXD
//
//  Created by Ivan Damjanovic on 19.07.19.
//

import Foundation
import HeckelDiff

internal final class ListView: UIView, UITableViewDelegate, UITableViewDataSource {
    enum Constants {
        static let reuseIdentifier = "ListViewTableViewCell"
    }
    private let tableView: UITableView
    private var allRows: [_Row]
    init(allRows: [_Row]) {
        self.allRows = allRows
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(frame: .zero)
        setupLayout()
        setupUI()
        setupTable()
    }

    private func setupLayout() {
        addSubview(tableView)
        tableView.addConstraints {[
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: $0.bottomAnchor),
            trailingAnchor.constraint(equalTo: $0.trailingAnchor)
        ]}
    }

    private func setupUI() {
        backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ListViewTableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
    }

    private func setupTable() {
        /// Add table as subview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 72
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeCategoryDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Updates the ListView to display a new set of rows
    func update(to newRows: [_Row], animated: Bool) {
        let oldRows = allRows
        allRows = newRows
        if animated {
            /// based on the applyDiff function inside HeckelDiff
            let update = ListUpdate(diff(oldRows.diffable, newRows.diffable), 0)

            tableView.beginUpdates()

            tableView.deleteRows(at: update.deletions, with: .fade)
            tableView.insertRows(at: update.insertions, with: .fade)
            update.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
            tableView.endUpdates()

            /// Update the updated and moved rows in a custom way - by diffing the `body` of each row
            applyUpdatesForVisibleRows()
        } else {
            tableView.reloadData()
        }
    }

    private func applyUpdatesForVisibleRows() {
        let visibleRows = Set(tableView.indexPathsForVisibleRows ?? [])
        visibleRows.forEach { self.updateBody(forRowAt: $0) }
    }

    private func updateBody(forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)! as! ListViewTableViewCell
        let row = allRows[indexPath.row]
        cell.adapt(to: row.body, animated: true)
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as! ListViewTableViewCell
        cell.selectionStyle = .none

        let row = allRows[indexPath.row]
        cell.adapt(to: row.body, animated: false)

        return cell
    }

    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let row = allRows[indexPath.row]
        row.action()
    }

    // MARK: Private
    @objc private func contentSizeCategoryDidChange() {
        /// The layout update doesn't work correctly immediately, this apparently fixes it.
        /// Given that this only happens when the size category changes, this shouldn't be an issue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

/// Diffing helper
private extension Array where Element == _Row {
    var diffable: [_DiffableRow] {
        return map { _DiffableRow(row: $0) }
    }
}

/// Diffing helper
private struct _DiffableRow: Hashable {
    let row: _Row
    func hash(into hasher: inout Hasher) {
        row.id.hash(into: &hasher)
    }
    static func == (lhs: _DiffableRow, rhs: _DiffableRow) -> Bool {
        return lhs.row.id.isEqual(to: rhs.row.id)
    }
}
