//
//  CategoriesViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    let images = [UIImage.actions, UIImage.add, UIImage.actions, UIImage.add]
    let labels = ["Label 1", "Label 2", "Label 3", "Label 4"]
    
    let viewModel = CategoriesViewModel(apiClient: CategoriesAPIClient(baseURL: URL(string: "https://api.deezer.com")!))
    
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
        
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Categories"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        initViews()
        
        viewModel.fetchCategories { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        getAccessToken { result in
            switch result{
            case.success(let token):
                print(token)
            case.failure(let error):
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
        
        /*viewModel.fetchCategories { [weak self] result in
         guard let self = self else { return }
         
         switch result {
         case .success:
         DispatchQueue.main.async {
         self.collectionView.reloadData()
         }
         case .failure(let error):
         print(error.localizedDescription)
         }
         }*/
    }
    
    
    
    
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
    
}


