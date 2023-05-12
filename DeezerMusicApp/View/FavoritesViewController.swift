//
//  FavoritesViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let tableView = UITableView()
    let cellId = "cellId"
    let favorites = FavoriteSongsRepository()
    weak var delegate: FavoritesViewControllerDelegate?
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
    }
    
    func initViews(){

        
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TracksTableViewCell.self, forCellReuseIdentifier: cellId)

        view.addSubview(tableView)
        tableView.separatorStyle = .none
        // Add constraints to the table view
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        let tracksViewController = TracksViewController()
               tracksViewController.delegate = self
    }
    
    @objc func tapEdit(recognizer: UITapGestureRecognizer) {
        guard let tappedImageView = recognizer.view as? UIImageView else {
            return
        }
        let indexPath = IndexPath(row: tappedImageView.tag, section: 0)
        let song = favorites.getSong(indexPath: indexPath.row)
        
        favorites.deleteFavoriteSong(song)
        tableView.deleteRows(at: [indexPath], with: .left)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initViews()

        tableView.reloadData()
    }
    
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // Return the number of rows you want to display
        return favorites.getFavoriteSongs().count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // Dequeue a reusable cell and cast it to your custom table view cell class
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TracksTableViewCell
         cell.trackImageView.sd_setImage(with: favorites.getFovoriteImage(indexPath: indexPath.row))
         cell.trackNameLabel.text = favorites.getSongName(indexPath: indexPath.row)
         cell.durationTimeLabel.text = favorites.getSongDuration(IndexPath: indexPath.row)
         // Set up the cell's image view, album name label, and release time label
         cell.heartIcon.tag = indexPath.row
         let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
              // Add gesture recognizer to the view
        cell.heartIcon.addGestureRecognizer(recognizer)

         cell.heartIcon.image = UIImage(systemName: "heart.fill")
         

         return cell
     }
    
    
     
     // MARK: - Table view delegate
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         // Return the height you want for your cells
         return 120
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension FavoritesViewController: TracksViewControllerDelegate{
    func tracksViewController(_ viewController: TracksViewController, didTapEditOnSongAt indexPath: IndexPath) {
           // Reload the table view or update its data as needed
           tableView.reloadData()
       }
    
    
}
protocol FavoritesViewControllerDelegate: AnyObject {
    func favoritesViewController(_ viewController: FavoritesViewController, didTapEditOnSongAt indexPath: IndexPath)
}
