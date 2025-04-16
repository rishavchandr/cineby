//
//  CollectionViewTableViewCell.swift
//  cineby
//
//  Created by Rishav chandra on 14/04/25.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    static let  identifier = "CollectionViewTableViewCell"
    
    private let homeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(homeCollectionView)
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    required init(coder : NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeCollectionView.frame = contentView.bounds
    }
}


extension CollectionViewTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemMint
        return cell
    }
    
    
}
