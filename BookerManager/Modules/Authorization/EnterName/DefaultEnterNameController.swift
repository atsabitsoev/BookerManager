//
//  DefaultEnterNameController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultEnterNameController: UIViewController, EnterNameControlling {
    
    private var enterNameView: EnterNameViewing!
    
    override func loadView() {
        super.loadView()
        enterNameView = DefaultEnterNameView(controller: self)
        enterNameView.configureView()
        view = enterNameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
    }
    
    func nextButtonTapped(name: String, lastname: String?) {
        print("Сохранить пользователя с именем \"\(name)\" и фамилией \"\(lastname ?? "[Нет фамилии]")\"")
    }
}
