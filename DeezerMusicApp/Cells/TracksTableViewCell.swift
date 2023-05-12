//
//  TracksTableViewCell.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import Foundation
import UIKit

class TracksTableViewCell: UITableViewCell {
    
    let trackImageView = UIImageView()
    let trackNameLabel = UILabel()
    let durationTimeLabel = UILabel()
    let bgView = UIView()
    let bgImageView = UIImageView()
    let heartIcon = UIImageView()
    
    

  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 1
        bgView.layer.cornerRadius = 10
        contentView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        // Set up the background image view
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.layer.masksToBounds = true
        bgView.addSubview(bgImageView)
        
        // Set up the image view
        trackImageView.contentMode = .scaleAspectFill
        trackImageView.layer.masksToBounds = true
        bgView.addSubview(trackImageView)
        
        heartIcon.contentMode = .scaleAspectFill
        heartIcon.layer.masksToBounds = true
        heartIcon.tintColor = UIColor(named: "colorr")
        bgView.addSubview(heartIcon)
        
        // Set up the album name label
        trackNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        bgView.addSubview(trackNameLabel)
        
        // Set up the release time label
        durationTimeLabel.font = UIFont.systemFont(ofSize: 14)
        bgView.addSubview(durationTimeLabel)
        
        let blurEffect = UIBlurEffect(style: .light)

        // Create a visual effect view with the blur effect
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        // Add the visual effect view to the background image view
        bgImageView.addSubview(blurEffectView)
        
        // Add constraints to the subviews
        heartIcon.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        durationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            bgImageView.topAnchor.constraint(equalTo: bgView.topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            
            trackImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            trackImageView.heightAnchor.constraint(equalToConstant: bgView.frame.height),
            trackImageView.topAnchor.constraint(equalTo: bgView.topAnchor),
            trackImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            trackImageView.widthAnchor.constraint(equalTo: trackImageView.heightAnchor),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 16),
            trackNameLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            trackNameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            heartIcon.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            heartIcon.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            heartIcon.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.6),
            heartIcon.widthAnchor.constraint(equalTo: heartIcon.heightAnchor),
            
            durationTimeLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 16),
            durationTimeLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 8),
            durationTimeLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            blurEffectView.leadingAnchor.constraint(equalTo: bgImageView.leadingAnchor),
                blurEffectView.trailingAnchor.constraint(equalTo: bgImageView.trailingAnchor),
                blurEffectView.topAnchor.constraint(equalTo: bgImageView.topAnchor),
                blurEffectView.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor)
        ])
        
        bgImageView.layer.cornerRadius = bgView.layer.cornerRadius
        trackImageView.layer.cornerRadius = bgView.layer.cornerRadius
        heartIcon.isUserInteractionEnabled = true
     
    }
   

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bgImageView.image = nil
        trackImageView.image = nil
        trackNameLabel.text = nil
        durationTimeLabel.text = nil
    }
}

