//
//  CollectionViewTableViewCell.swift
//  cineby
//
//  Created by Rishav chandra on 14/04/25.
//

import UIKit

protocol CollectionViewTableViewCelldelegate: AnyObject {
    func  collectionViewTableViewCellDidSelect(_ cell: CollectionViewTableViewCell , viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let  identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCelldelegate?
    
    private var titles: [Title] = [Title]()
    
    private let homeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.idetenfier)
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
    
    public func configure(with titles: [Title]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.homeCollectionView.reloadData()
        }
    }
    
    private func downloadTitle(at indexpath: IndexPath){
        DataPersistenceManager.shared.downloadTitleWith(with: titles[indexpath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: Notification.Name("download"), object: nil)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}


extension CollectionViewTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.idetenfier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let imageOfTitle = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(imageUrl: imageOfTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        
        APICaller.shared.searchMovie(query: titleName + "trailer") { [weak self] results in
            switch results {
            case .success(let videoElement):
                guard let strongSelf = self else {return}
                guard let titleOverview = self?.titles[indexPath.row].overview else {return}
                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                self?.delegate?.collectionViewTableViewCellDidSelect(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView , contextMenuConfigurationForItemAt indexPath: IndexPath , point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil
            ,previewProvider: nil) { [weak self] _ in
                let downloadAction = UIAction(title: "Download" , subtitle: nil , image: nil , identifier: nil , discoverabilityTitle: nil , state: .off) { _ in
                    self?.downloadTitle(at: indexPath)
                }
                return UIMenu(title: "" , image: nil , identifier: nil ,options: .displayInline , children: [downloadAction])
            }
        return config
    }
}
