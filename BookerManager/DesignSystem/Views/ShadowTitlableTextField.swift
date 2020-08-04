//
//  ShadowTitlableTextField.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 01.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

class ShadowTitlableTextField: TitlableTextField {
    
    override var textColor: UIColor { return UIColor.Background.title }
    override var textFieldBackgroundColor: UIColor { return UIColor.Background.primary }
    override var keyboardAppearance: UIKeyboardAppearance { return .light}
    
    override init(title: String, placeholder: String = "", textType: UITextContentType? = nil, keyboardType: UIKeyboardType? = nil) {
        super.init(title: title, placeholder: placeholder, textType: textType, keyboardType: keyboardType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func getBaseTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.shadowColor = UIColor.Shadow.main.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowRadius = 8
        return textField
    }
}
