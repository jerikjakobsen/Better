//
//  LeftAlignedFlowLayout.swift
//  Better
//
//  Created by John Jakobsen on 4/25/24.
//

import Foundation
import UIKit

// A collection view flow layout in which all items get left aligned
class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.minimumInteritemSpacing = 15
        self.minimumLineSpacing = 12
        self.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.itemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var leftMargin: CGFloat = 0.0
        var lastY: Int = 0
        return originalAttributes.map {
            let changedAttribute = $0
            // Check if start of a new row.
            // Center Y should be equal for all items on the same row
            if Int(changedAttribute.center.y.rounded()) != lastY {
                leftMargin = sectionInset.left
            }
            changedAttribute.frame.origin.x = leftMargin
            lastY = Int(changedAttribute.center.y.rounded())
            leftMargin += changedAttribute.frame.width + minimumInteritemSpacing
            return changedAttribute
        }
    }
}
