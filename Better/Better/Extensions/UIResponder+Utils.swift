//
//  UIResponder+Utils.swift
//  Better
//
//  Created by John Jakobsen on 7/13/24.
//

import Foundation
import UIKit

extension UIResponder {
    private struct Static {
            static weak var responder: UIResponder?
        }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}
