//
//  CustomCell.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/10/23.
//

import UIKit
import Kingfisher


class CustomCell: UICollectionViewCell {
    
    static let reuseID = "cell"
    
    lazy var myImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        contentView.addSubview(myImage)
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    func setupText(text: String) {
        let url = URL(string: text)
        myImage.kf.setImage(with: url)
    }
}
