//
//  TracksViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import UIKit
import AVFoundation


class TracksViewController: UIViewController {
    
    var albumName = ""
    var albumID = 0
    let tracksTableView = UITableView()
    let cellId = "cellIddd"
    var viewModel: TracksViewModel!
    var favorites = FavoriteSongsRepository()
    weak var delegate: TracksViewControllerDelegate?
    var player : AVPlayer?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("albumName: \(albumID)")
        self.navigationItem.title = albumName
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }

    
    func initViews(){

       
        tracksTableView.delegate = self
        tracksTableView.dataSource = self
        tracksTableView.register(TracksTableViewCell.self, forCellReuseIdentifier: cellId)

        view.addSubview(tracksTableView)
        tracksTableView.separatorStyle = .none
        // Add constraints to the table view
        tracksTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tracksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tracksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tracksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tracksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       
    }
    
    func englishLowercaseString(from string: String) -> String {
        let englishCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let lowercaseString = string.lowercased()
        let filteredString = lowercaseString.components(separatedBy: englishCharacterSet.inverted).joined(separator: "")
        return filteredString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = TracksViewModel(apiClient: TracksAPIClient(baseURL: URL(string: "https://api.deezer.com")!, albumID: albumID), dataRepository: favorites)
        initViews()
        // Do any additional setup after loading the view.
        viewModel.fetchTracks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    print("girdii")
                    print("self.viewModel.tracks: \(self.viewModel.numberOfItems())")
                    self.tracksTableView.reloadData()
                }
            case .failure(let error):
                print("errorrr: \(error)")
            }
        }
    }

  
    @objc func tapEdit(recognizer: UITapGestureRecognizer) {
        guard let tappedImageView = recognizer.view as? UIImageView else {
                return
            }
            let indexPath = IndexPath(row: tappedImageView.tag, section: 0)
        let song = viewModel.getSong(at: indexPath.row)
        let isFavorite = favorites.getFavoriteSongs().contains { favoriteSong in
            return favoriteSong.title == song.title
        }
        if isFavorite {
            favorites.deleteFavoriteSong(song)
            tappedImageView.image = UIImage(systemName: "heart")
        } else {
            favorites.saveFavoriteSong(song)
            tappedImageView.image = UIImage(systemName: "heart.fill")
        }
        delegate?.tracksViewController(self, didTapEditOnSongAt: indexPath)
       

    }

    func playSound(url: URL)
    {
        
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVPlayer(url: url)
            guard let player = player
            else
            {
                return
            }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}



extension TracksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // Return the number of rows you want to display
        return viewModel.numberOfItems()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // Dequeue a reusable cell and cast it to your custom table view cell class
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TracksTableViewCell
         
         // Set up the cell's image view, album name label, and release time label
         viewModel.configure(cell: cell, for: indexPath)
         let song = viewModel.getSong(at: indexPath.row)
         let isFavorite = favorites.getFavoriteSongs().contains { favoriteSong in
             return favoriteSong.title == song.title
         }
         cell.heartIcon.tag = indexPath.row
         var recognizer = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
              // Add gesture recognizer to the view
              cell.heartIcon.addGestureRecognizer(recognizer)

         if isFavorite{ cell.heartIcon.image = UIImage(systemName: "heart.fill")}
         else{cell.heartIcon.image = UIImage(systemName: "heart")}
         return cell
     }
     
     // MARK: - Table view delegate
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         // Return the height you want for your cells
         return 120
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previewURL = viewModel.getPreview(at: indexPath.row)
        print("previewURL: \(previewURL)")
        playSound(url: previewURL)
    }

    
}

protocol TracksViewControllerDelegate: AnyObject {
    func tracksViewController(_ viewController: TracksViewController, didTapEditOnSongAt indexPath: IndexPath)
}
