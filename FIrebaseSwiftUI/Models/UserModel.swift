import SwiftUI

struct User: Identifiable, Codable{
    var id: String = UUID().uuidString
    var username: String
    var profilePictureURL: String?
}
