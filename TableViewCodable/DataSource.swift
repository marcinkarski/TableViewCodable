import UIKit

class DataSource: NSObject {
    
    var friends = [Friends]()
    var filtered = [Friends]()
    var dataChanged: (() -> Void)?
    
    func fetch(_ urlString: String) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.decode([Friends].self, fromURL: urlString) { friends in
            self.friends = friends
            self.filtered = friends
            self.dataChanged?()
        }
    }
}

extension DataSource: UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let friend = filtered[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtered = friends.matching(searchController.searchBar.text)
        self.dataChanged?()
    }
    
}
