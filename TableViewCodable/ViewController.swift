import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    var friends = [Friends]()
    var filtered = [Friends]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "TableView Codable"
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a friend"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let url = "https://www.hackingwithswift.com/samples/friendface.json"
        decoder.decode([Friends].self, fromURL: url) { friends in
            self.friends = friends
            self.filtered = friends
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let friend = filtered[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtered = friends.matching(searchController.searchBar.text)
        tableView.reloadData()
    }
}
