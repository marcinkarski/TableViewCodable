import Foundation

typealias Friends = Friend

struct Friend: Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Connection]
    
    var friendList: String {
        return friends.map { $0.name }.joined(separator: ", ")
    }
}

struct Connection: Codable {
    let id: UUID
    let name: String
}

extension Array where Element == Friends {
    func matching(_ text: String?) -> [Friends] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.name.contains(text) || $0.company.contains(text) || $0.address.contains(text)
            }
        } else {
            return self
        }
    }
}
