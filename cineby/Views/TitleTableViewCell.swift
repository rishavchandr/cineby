//
//  TitleTableViewCell.swift
//  cineby
//
//  Created by Rishav chandra on 16/04/25.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
   
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        addContraints()
    }
    
    private func addContraints() {
        let titlePosterContraints = [
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelContraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playButtonContraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlePosterContraints)
        NSLayoutConstraint.activate(titleLabelContraints)
        NSLayoutConstraint.activate(playButtonContraints)
    }
    
    public func configure(with model: TitleViewModel){
        titlePosterImageView.loadImage(urlString: "https://image.tmdb.org/t/p/w500/\(model.posterUrlL)")
        titleLabel.text = model.titleName
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
