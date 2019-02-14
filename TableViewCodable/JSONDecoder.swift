import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL")
        }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                let downloaded = try self.decode(type.self, from: data)
                DispatchQueue.main.async {
                    completion(downloaded)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
