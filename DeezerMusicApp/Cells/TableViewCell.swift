//
//  TableViewCell.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    let albumImageView = UIImageView()
    let albumNameLabel = UILabel()
    let releaseTimeLabel = UILabel()
    let bgView = UIView()
    let bgImageView = UIImageView()
    
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
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.layer.masksToBounds = true
        bgView.addSubview(albumImageView)
        
        // Set up the album name label
        albumNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        bgView.addSubview(albumNameLabel)
        
        // Set up the release time label
        releaseTimeLabel.font = UIFont.systemFont(ofSize: 14)
        releaseTimeLabel.textColor = .white
        bgView.addSubview(releaseTimeLabel)
        
        let blurEffect = UIBlurEffect(style: .light)

        // Create a visual effect view with the blur effect
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        // Add the visual effect view to the background image view
        bgImageView.addSubview(blurEffectView)
        
        // Add constraints to the subviews
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            bgImageView.topAnchor.constraint(equalTo: bgView.topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            
            albumImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            albumImageView.heightAnchor.constraint(equalToConstant: bgView.frame.height),
            albumImageView.topAnchor.constraint(equalTo: bgView.topAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),
            
            albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 16),
            albumNameLabel.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            releaseTimeLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 16),
            releaseTimeLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8),
            releaseTimeLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            
            blurEffectView.leadingAnchor.constraint(equalTo: bgImageView.leadingAnchor),
                blurEffectView.trailingAnchor.constraint(equalTo: bgImageView.trailingAnchor),
                blurEffectView.topAnchor.constraint(equalTo: bgImageView.topAnchor),
                blurEffectView.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor)
        ])
        
        bgImageView.layer.cornerRadius = bgView.layer.cornerRadius
        albumImageView.layer.cornerRadius = bgView.layer.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bgImageView.image = nil
        albumImageView.image = nil
        albumNameLabel.text = nil
        releaseTimeLabel.text = nil
    }
}
