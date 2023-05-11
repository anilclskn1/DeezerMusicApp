//
//  ArtistViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit

class ArtistViewController: UIViewController {
    
    var artistName = ""
    var artistID = 0
    var imageURL = URL(string: "")
    
    var imageView: UIImageView!
    let tableView = UITableView()
    let cellId = "cellId"
    var viewModel: AlbumsViewModel!
    var bgImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        self.navigationItem.title = artistName
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = AlbumsViewModel(apiClient: AlbumAPIClient(baseURL: URL(string: "https://api.deezer.com")!, artistID: artistID))
        initViews()
        // Do any additional setup after loading the view.
        viewModel.fetchAlbums { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

    func initViews(){

        
        
        bgImageView = UIImageView()
        bgImageView.sd_setImage(with: imageURL)
        bgImageView.clipsToBounds = true
        bgImageView.contentMode = .scaleToFill
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImageView)
        bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bgImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.addSubview(blurEffectView)
        blurEffectView.leadingAnchor.constraint(equalTo: bgImageView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: bgImageView.trailingAnchor).isActive = true
        blurEffectView.topAnchor.constraint(equalTo: bgImageView.topAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor).isActive = true

        imageView = UIImageView()
        imageView.sd_setImage(with: imageURL)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        // Add constraints to the table view
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
    }

}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // Return the number of rows you want to display
        return viewModel.numberOfItems()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // Dequeue a reusable cell and cast it to your custom table view cell class
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableViewCell
         
         // Set up the cell's image view, album name label, and release time label
         viewModel.configure(cell: cell, for: indexPath)

         cell.contentView.layoutMargins = .init(top: 0.0, left: 23.5, bottom: 0.0, right: 23.5)

         return cell
     }
     
     // MARK: - Table view delegate
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         // Return the height you want for your cells
         return 120
     }
    

    
    
}
