//
//  TitleCollectionViewCell.swift
//  cineby
//
//  Created by Rishav chandra on 16/04/25.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let idetenfier = "TitleCollectionViewCell"
    
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleImageView)
    }
    
    required init(coder : NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleImageView.frame = contentView.bounds
    }
    
    public func configure(imageUrl: String){
        titleImageView.loadImage(urlString: "https://image.tmdb.org/t/p/w500/\(imageUrl)")
    }
}
