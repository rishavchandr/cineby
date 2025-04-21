//
//  SearchResultViewController.swift
//  cineby
//
//  Created by Rishav chandra on 21/04/25.
//

import UIKit

class SearchResultViewController: UIViewController {

    public var titles: [Title] = [Title]()
    
    public let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 10, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.idetenfier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchCollectionView)
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchCollectionView.frame = view.bounds
    }

}

extension SearchResultViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.idetenfier, for: indexPath) as?  TitleCollectionViewCell else {return UICollectionViewCell()}
        let searchPosterUrl = titles[indexPath.row].poster_path
        cell.configure(imageUrl: searchPosterUrl ?? "")
        return cell
    }
    
}
