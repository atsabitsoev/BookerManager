//
//  DefaultPromotionsView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultPromotionsListView: UIView, PromotionsListViewing {
    
    private var controller: PromotionsListControlling
    
    fileprivate var promotionItems: [PromotionItem] = [
        PromotionItem(
            id: "1",
            imageUrl: "https://media-cdn.tripadvisor.com/media/photo-s/1a/0b/7f/8d/pizza-food-style.jpg",
            title: "Привет Андрей",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "2",
            imageUrl: "https://avatars.mds.yandex.net/get-altay/1938975/2a0000016ed2b34d5d3fa93c65512e1dc39f/XXXL",
            title: "Привет Иван",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "3",
            imageUrl: "https://www.abc.net.au/cm/rimage/10574686-3x2-xlarge.jpg?v=2",
            title: "Привет Зигота",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "4",
            imageUrl: "https://www.abc.net.au/cm/rimage/10574660-3x2-xlarge.jpg?v=2",
            title: "Привет Компьютер",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "5",
            imageUrl: "https://www.abc.net.au/cm/rimage/12492526-16x9-xlarge.jpg?v=2",
            title: "Привет Стена",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "6",
            imageUrl: "https://www.abc.net.au/cm/rimage/12492586-4x3-xlarge.jpg?v=2",
            title: "Привет Телевизор",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "7",
            imageUrl: "https://www.abc.net.au/cm/rimage/12492520-1x1-xlarge.jpg?v=2",
            title: "Привет СИЗЫЙ",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл аодылаы"),
        PromotionItem(
            id: "8",
            imageUrl: "https://www.abc.net.au/cm/rimage/12491782-3x2-xlarge.jpg?v=2",
            title: "Привет Леха",
            description: "Адаыо вадлоы адлвоадыва двлы аовыл ldfskj dslkjf lsdk fjldks jfslkd fаодылаы")
    ]
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = UIColor.Background.primary
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PromotionCell.self, forCellReuseIdentifier: PromotionCell.identifier)
        return table
    }()
    
    init(controller: PromotionsListControlling) {
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
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}

extension DefaultPromotionsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromotionCell.identifier) as? PromotionCell else { return UITableViewCell() }
        let currentItem = promotionItems[indexPath.row]
        cell.configureCell(imageUrl: currentItem.imageUrl ?? "", title: currentItem.title, description: currentItem.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentPromotionItem = promotionItems[indexPath.row]
        controller.showDeleteAlert(forPromotionId: currentPromotionItem.id)
    }
    
}
