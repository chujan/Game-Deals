//
//  Extension.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 13/10/2023.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
//
//  Extension.swift
//  Sports
//
//  Created by Jennifer Chukwuemeka on 18/10/2022.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
}

import UIKit

extension UILabel {
    func setCharacterSpacing(_ spacing: CGFloat) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

extension UIDevice {
    static let isiphone = UIDevice.current.userInterfaceIdiom == .phone
}

// Usage example



