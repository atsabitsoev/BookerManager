//
//  DefaultOrdersView.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultOrdersView: UIView, OrdersView {
    
    enum State {
        case waitingOrders
        case readyOrders
    }
    
    // MARK: Vars
    private let controller: OrdersControlling
    
    fileprivate var state: State = .waitingOrders {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate var currentOrderItems: [OrderItem] {
        get {
            state == .waitingOrders ? waitingOrderItems : readyOrderItems
        }
    }
    private var allOrderItems: [OrderItem] = [] {
        didSet {
            waitingOrderItems = allOrderItems.filter({ (item) -> Bool in
                return item.state == .waiting
            })
            readyOrderItems = allOrderItems.filter({ (item) -> Bool in
                return item.state == .ready
            })
        }
    }
    private var waitingOrderItems: [OrderItem] = []
    private var readyOrderItems: [OrderItem] = []
    
    // MARK: UI Elements
    private let tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56))
        return view
    }()
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Ожидающие", "Подтвержденные"])
        segmented.frame = CGRect(x: 16, y: 12, width: UIScreen.main.bounds.width - 32, height: 32)
        segmented.selectedSegmentIndex = 0
        return segmented
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: Life Cycle
    init(controller: OrdersControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupTableViewConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        tableHeaderView.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = tableHeaderView
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.identifier)
        setNeedsUpdateConstraints()
        allOrderItems = [
            OrderItem(date: "18:00, сегодня", personsCount: 4, name: "Андрей Петров", state: .waiting),
            OrderItem(date: "19:20, сегодня", personsCount: 2, name: "Сизый", state: .ready),
            OrderItem(date: "20:30, сегодня", personsCount: 3, name: "Александр Якунин", state: .waiting)
        ]
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func segmentChanged() {
        state = segmentedControl.selectedSegmentIndex == 0 ? .waitingOrders : .readyOrders
    }
    
}

extension DefaultOrdersView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentOrderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier) as! OrderCell
        let currentItem = currentOrderItems[indexPath.row]
        cell.configureCell(date: currentItem.date, personsCount: currentItem.personsCount, name: currentItem.name)
        return cell
    }
}
