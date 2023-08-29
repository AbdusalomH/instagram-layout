//
//  ViewController.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/10/23.
//

import UIKit

class MainVC: UIViewController {
    
    
    var myArray: [Photo] = []
    
    var pageNumber = 1
    
    
    var index1 = 5
    var index2 = 6
    
    
    
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createFlowlayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseID)
        collection.delegate = self
        return collection
    }()
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        configureSearch()
        getPhoto(page: String(pageNumber))
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    
    func getPhoto(page: String) {
        
        showLoading()
        
        NetworkManager.shared.makePexelsRequest(page: page) { [weak self] result in
            guard let self = self else {return}
            
            self.stopAnimation()
            switch result {
            case .success(let data):
                
                for i in data.photos {
                    if !self.myArray.contains(i) {
                        self.myArray.append(i)
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateData(photos: self.myArray)
                    self.configureDataSource(with: self.myArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func configureSearch() {
        let searchBar = UISearchController()
        searchBar.searchBar.placeholder = "Search"
        navigationItem.searchController = searchBar
    }

    
    
    func setupView() {
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        
        if offsetY > contentHeight - height {

            pageNumber += 1
            getPhoto(page: String(pageNumber))
            
        }
    }

   
    
    func createFlowlayout() -> UICollectionViewCompositionalLayout {
        
        let width = view.frame.width / 3
        let height = view.frame.height / 3.5
        
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let item2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item2.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(0.5)), repeatingSubitem: item2, count: 2)
        
        
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height)),
            subitems: [verticalGroup, verticalGroup, item])
        
        
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height)),
            subitems: [item, verticalGroup, verticalGroup])

        
        let horizontalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height * 2)),
            subitems: [group1, group2])

        
        let section = NSCollectionLayoutSection(group: horizontalGroup)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout

    }
    
    
    func configureDataSource(with photo: [Photo]) {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseID, for: indexPath) as? CustomCell else {
                return UICollectionViewCell()
            }
            
            if indexPath.item == self.index1 {
                cell.setupText(text: self.myArray[indexPath.row].src.portrait ?? "")
                self.index1 += 10
            } else if indexPath.item == self.index2 {
                cell.setupText(text: self.self.myArray[indexPath.row].src.portrait ?? "")
                self.index2 += 10
            } else {
                cell.setupText(text: self.myArray[indexPath.row].src.medium ?? "")
            }
            return cell
        })

        

    }
    
    func updateData(photos: [Photo]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let number = myArray[indexPath.row]
        let vc = DetailsVC(imageName: number.src.portrait ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}



class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func makePexelsRequest(page: String, completion: @escaping (Result<PhotoModel, Error>) -> Void) {
        
        //let urlString = "https://api.pexels.com/v1/curated?page=1&per_page=80"
        let apiKey = "zW9FssWnr4GvHAC3pI1i4dLp2uhWXNTUkBnADoQVTVoXE5opbj5f7Lp5"
        
        let urlConfigure = "https://api.pexels.com/v1/curated?page=\(page)&per_page=80"
        
        
        guard let url = URL(string: urlConfigure) else {return}
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization" : apiKey]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if let error = error {
                print("error \(error)")
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let serverData = try decoder.decode(PhotoModel.self, from: data)
                completion(.success(serverData))
                
            } catch let error {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
}






