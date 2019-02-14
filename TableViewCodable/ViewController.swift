import UIKit

class ViewController: UITableViewController {
    
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "TableView Codable"
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        dataSource.fetch("https://www.hackingwithswift.com/samples/friendface.json")
        tableView.dataSource = dataSource
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a friend"
        search.searchResultsUpdater = dataSource
        navigationItem.searchController = search
        
    }
}
