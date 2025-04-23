//
//  SearchViewController.swift
//  cineby
//
//  Created by Rishav chandra on 18/03/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private let serchTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let contoller = UISearchController(searchResultsController: SearchResultViewController())
        contoller.searchBar.placeholder = "Search"
        contoller.searchBar.searchBarStyle = .minimal
        return contoller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        serchTableView.delegate = self
        serchTableView.dataSource = self
        fetchSearchTitle()
        view.addSubview(serchTableView)
        searchController.searchResultsUpdater = self
    }
    
    private func fetchSearchTitle() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.serchTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        serchTableView.frame = view.bounds
    }

}

extension SearchViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as?
                TitleTableViewCell else {return UITableViewCell()}
        guard let posterTitle = titles[indexPath.row].original_title , let posterUrl = titles[indexPath.row].poster_path
        else {return UITableViewCell()}
        cell.configure(with: TitleViewModel(titleName: posterTitle, posterUrlL: posterUrl))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        APICaller.shared.searchMovie(query: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}


extension SearchViewController: UISearchResultsUpdating , SearchResultViewControllerDelegate {
    func searchResultViewControllerDidTap(viewmodel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewmodel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {return}
        
        resultController.delegate = self
        APICaller.shared.search(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchTitle):
                    resultController.titles = searchTitle
                    resultController.searchCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
