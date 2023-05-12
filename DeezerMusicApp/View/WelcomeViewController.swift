//
//  WelcomeViewController.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var imageView: UIImageView = {
        let welcomeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        welcomeImage.image = UIImage(named: "music")
        return welcomeImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.performSegue(withIdentifier: "fromWelcomeToMain", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
       
    }
    
  
    
    


}
