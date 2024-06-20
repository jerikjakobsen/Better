//
//  Fonts.swift
//  Better
//
//  Created by John Jakobsen on 4/11/24.
//

import Foundation
import UIKit

struct Fonts {
    static let Montserrat_Small: UIFont = UIFont(name: "Montserrat", size: 14) ?? .systemFont(ofSize: 14)
    static let Montserrat_Small_Medium: UIFont = UIFont(name: "Montserrat", size: 18)  ?? .systemFont(ofSize: 18)
    
    static let Montserrat_Medium: UIFont = UIFont(name: "Montserrat", size: 24) ?? .systemFont(ofSize: 24)
    static let Montserrat_Medium_Large: UIFont = UIFont(name: "Montserrat", size: 32) ?? .systemFont(ofSize: 32)
    static let Montserrat_Large: UIFont = UIFont(name: "Montserrat", size: 42) ?? .systemFont(ofSize: 42)
    static let Montserrat_Larger: UIFont = UIFont(name: "Montserrat", size: 52) ?? .systemFont(ofSize: 52)
}

extension UIFont {
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
            var attributes = fontDescriptor.fontAttributes
            var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

            traits[.weight] = weight

            attributes[.name] = nil
            attributes[.traits] = traits
            attributes[.family] = familyName

            let descriptor = UIFontDescriptor(fontAttributes: attributes)

            return UIFont(descriptor: descriptor, size: pointSize)
        }
    
    func semibold() -> UIFont {
        return self.withWeight(.regular)
    }
    
    func bold() -> UIFont {
        return self.withWeight(.medium)
    }
    
    func bolder() -> UIFont {
        return self.withWeight(.semibold)
    }
    
    func boldest() -> UIFont {
        return self.withWeight(.bold)
    }
}
