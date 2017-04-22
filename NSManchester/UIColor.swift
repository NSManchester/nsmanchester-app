import UIKit

extension UIColor {
    static func cell(for indexPath: IndexPath, offset: Int = 0) -> Color {
        switch (indexPath.row + offset) % 3 {
        case 0:
            return .burntSienna
        case 1:
            return .hopbush
        case 2:
            return .waxFlower
        default:
            return .burntSienna
        }
    }
}
