//
//  UITableViewCellSelection.swift
//  NSManchester
//
//  Created by Ross Butler on 30/01/2016.
//  Copyright © 2016 Ross Butler. All rights reserved.
//

import UIKit

extension UITableView {
    func cellSelectionColourForCellWithColour(_ colour: UIColor) -> UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        colour.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r + 0.2, green: g + 0.2, blue: b + 0.2, alpha: 1.0)
    }
}
