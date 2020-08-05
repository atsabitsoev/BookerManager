//
//  BMButton.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 31.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BMButton: UIButton {
    
    enum State {
        case standard
        case destructive
        case quit
    }
    
    init(
        buttonState: State,
        title: String) {
        super.init(frame: .zero)
        layer.cornerRadius = 16
        setTitle(title, for: .normal)
        switch buttonState {
        case .standard:
            backgroundColor = UIColor.Button.standard
            setTitleColor(UIColor.Button.title, for: .normal)
        case .destructive:
            backgroundColor = UIColor.Button.destructive
            setTitleColor(UIColor.Button.title, for: .normal)
        case .quit:
            backgroundColor = UIColor.Background.secondary
            setTitleColor(UIColor.Button.destructive, for: .normal)
        }
        titleLabel?.font = UIFont.Button.main
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = (self.isHighlighted || !self.isEnabled) ? 0.5 : 1
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
    
}
