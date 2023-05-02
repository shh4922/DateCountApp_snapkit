import UIKit
import Foundation

enum SettingSection {
    case setting([SettingModel])
    case review([ReviewModel])
    case support([SupportModel])
}
struct SettingModel {
    let iconImage: UIImage?
    let titleText: String?
}

struct ReviewModel {
    let iconImage: UIImage?
    let title: String?
}

struct SupportModel {
    let title: String?
}
