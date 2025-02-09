//
//  ViewController.swift
//  SearchApp
//
//  Created by Max Gabriel on 2024-07-02.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchResults = [SearchResult]()
    var hasSearched = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.contentInset = UIEdgeInsets(top: 51, left: 0, bottom: 0, right: 0)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//                view.addGestureRecognizer(tapGesture)

    }
    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }

}


// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      if !hasSearched {
        return 0
      } else if searchResults.count == 0 {
        return 1
      } else {
        return searchResults.count
      }
    }

    func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cellIdentifier = "SearchResultCell"
      
      var cell = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier)
      if cell == nil {
        cell = UITableViewCell(
          style: .subtitle, reuseIdentifier: cellIdentifier)
      }
        if searchResults.count == 0 {
          cell?.textLabel!.text = "(Nothing found)"
          cell?.detailTextLabel!.text = ""
        } else {
          let searchResult = searchResults[indexPath.row]
          cell?.textLabel!.text = searchResult.name
          cell?.detailTextLabel!.text = searchResult.artistName
        }
          return cell!
    }
    
    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
      
//    func tableView(
//      _ tableView: UITableView,
//      willSelectRowAt indexPath: IndexPath
//    ) -> IndexPath? {
//      if searchResults.count == 0 {
//        return nil
//      } else {
//        return indexPath
//      }
//    }


}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchResults = []
        for i in 0...2 {
            let searchResult = SearchResult()
             searchResult.name = String(format: "Fake Result %d for", i)
             searchResult.artistName = searchBar.text!
             searchResults.append(searchResult)
        }
      hasSearched = true
      tableView.reloadData()
    }

}

// MARK: - UIBarPositioningDelegate
extension SearchViewController: UIBarPositioningDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
