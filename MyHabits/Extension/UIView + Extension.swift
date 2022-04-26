//
//  UIView + Extension.swift
//  Habits
//
//  Created by 1234 on 14.04.2022.
//
import UIKit

extension UIView {
    
    func makeLabel(text: String) -> UILabel {
    
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }

    static var identifier: String {
        String(describing: self)
    }
}
