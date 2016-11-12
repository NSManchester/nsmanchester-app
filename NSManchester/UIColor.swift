import UIKit

extension UIColor {
    static func burntSiennaColor() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 121.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    }
    
    static func hopbushColor() -> UIColor {
        return UIColor(red: 192.0/255.0, green: 105.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    }
    
    static func waxFlowerColor() -> UIColor {
        return UIColor(red: 239.0/255.0, green: 173.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    }
    
    static func cell(for indexPath: IndexPath, offset: Int = 0) -> UIColor {
        switch (indexPath.row + 1 + offset) % 3 {
        case 0: return UIColor.burntSiennaColor()
        case 1: return UIColor.hopbushColor()
        default: return UIColor.waxFlowerColor()
        }
    }
}
