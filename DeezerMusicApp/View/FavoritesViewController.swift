//
//  FavoritesViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    

}
