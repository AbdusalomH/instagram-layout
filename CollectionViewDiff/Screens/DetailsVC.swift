//
//  DetailsVC.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/25/23.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
    
    
    var imageName: String
    
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var detailimage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupImage(with: imageName)
    }
    
    
    func setupView() {
        
        view.addSubview(detailimage)
        
        NSLayoutConstraint.activate([
            detailimage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailimage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailimage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailimage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupImage(with name: String) {
        let url = URL(string: name)
        detailimage.kf.setImage(with: url)
    }
}
