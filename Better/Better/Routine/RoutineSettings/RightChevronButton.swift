//
//  RightChevronButton.swift
//  Better
//
//  Created by John Jakobsen on 6/14/24.
//

import Foundation
import UIKit

class RightChevronButton: UIButton {
    
    init() {
        super.init(frame: CGRect())
        self.setImage(UIImage(systemName: "chevron.right")?.withTintColor(Colors.linkColor, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
