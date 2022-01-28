import UIKit

struct Stuffs: Codable {
    let activity: String
    let accessibility: Double
    let type: ActivityType
    let participants: Int
    let price: Double
    let link: String
    let key: String
     
    enum ActivityType: String, Codable {
        case education
        case recreational
        case social
        case diy
        case charity
        case cooking
        case relaxation
        case music
        case busywork
    }
}
