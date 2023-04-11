//
//  CustomTextField.swift
//  Navigation
//
//  Created by Кужельная Екатерина on 15.03.2023.
//

import UIKit


final class CustomTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
           let rect = super.editingRect(forBounds: bounds)
           return rect.inset(by: padding)
    }
}
