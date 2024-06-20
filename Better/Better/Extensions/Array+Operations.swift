//
//  Array+Operations.swift
//  Better
//
//  Created by John Jakobsen on 5/12/24.
//

import Foundation

extension Array {
    func fold<R>(_ startVal: R, fn: (Element, R) -> R) -> R {
        var res: R = startVal
        self.forEach { el in
            res = fn(el, res)
        }
        return res
    }
}

protocol Floatable {
    func toFloat() -> Float
}

extension Int: Floatable {
    func toFloat() -> Float {
        return Float(self)
    }
}

extension Float: Floatable {
    func toFloat() -> Float {
        return self
    }
}

extension Double: Floatable {
    func toFloat() -> Float {
        return Float(self)
    }
}

extension Array where Element: Floatable {
    func average() -> Float {
        if self.count == 0 {
            return 0
        }
        return Float(self.fold(Float.zero) { $0.toFloat() + $1.toFloat()})/Float(count)
    }
}


