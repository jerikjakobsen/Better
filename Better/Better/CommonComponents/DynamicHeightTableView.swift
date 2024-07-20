//
//  DynamicHeightTableView.swift
//  Better
//
//  Created by John Jakobsen on 7/9/24.
//

import Foundation
import UIKit

class DynamicHeightTableView: UITableView {
    override public func layoutSubviews() {
            super.layoutSubviews()
            if bounds.size != intrinsicContentSize {
                invalidateIntrinsicContentSize()
            }
        }
        
    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
}
