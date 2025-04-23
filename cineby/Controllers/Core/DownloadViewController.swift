//
//  DownloadViewController.swift
//  cineby
//
//  Created by Rishav chandra on 18/03/25.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var titles: [Titleitem] = [Titleitem]()
    
    private let downloadTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(downloadTableView)
        downloadTableView.delegate = self
        downloadTableView.dataSource = self
        downloadTableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(forName: Notification.Name("download"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTableView.frame = view.bounds
    }
    
    func fetchLocalStorageForDownload(){
        DataPersistenceManager.shared.fetchDatabase { [weak self] result in
            switch result {
            case .success(let item):
                self?.titles = item
                DispatchQueue.main.async {
                    self?.downloadTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DownloadViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        
        guard let posterTitle = titles[indexPath.row].original_title , let posterUrlString = titles[indexPath.row].poster_path else {return UITableViewCell()}
        
        cell.configure(with: TitleViewModel(titleName: posterTitle, posterUrlL: posterUrlString))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteItemfromDatabase(model: titles[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("delete Succesfully")
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}
