//
//  ArtistsViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit

class ArtistsViewController: UIViewController {
    
    var categoryName = ""
    var genreID = 0
    
    var viewModel: ArtistsViewModel!
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = categoryName
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = ArtistsViewModel(apiClient: ArtistsAPIClient(baseURL: URL(string: "https://api.deezer.com")!, genreID: genreID))
        initViews()
        
        viewModel.fetchArtists { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func initViews(){
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        getAccessToken { result in
            switch result{
            case.success(let t):
                print(t)
            case.failure(let e):
                print(e)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtistVC" {
            let destinationVC = segue.destination as! ArtistViewController
            if let cellData = sender as? ArtistData {
                destinationVC.artistName = cellData.labelText
                destinationVC.artistID = cellData.artistID
                destinationVC.imageURL = cellData.artistImageURL
            }
        }
    }
    

}


extension ArtistsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoriesCollectionViewCell
        viewModel.configure(cell: cell, for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 12 // Subtracting the spacing between cells and section insets
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistName = viewModel.getArtistName(index: indexPath.row)
        let artistID = viewModel.getArtistID(index: indexPath.row)
        let artistImageURL = viewModel.getImageURL(index: indexPath.row)
        let artistCell = ArtistData(labelText: artistName, artistID: artistID, artistImageURL: artistImageURL)
        self.performSegue(withIdentifier: "toArtistVC", sender: artistCell)
    }
    
}
struct ArtistData {
    let labelText: String
    let artistID: Int
    let artistImageURL: URL
}
