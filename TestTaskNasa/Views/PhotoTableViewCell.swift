//
//  PhotoTableViewCell.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {
    
    private let roverLabel = UILabel()
    private let cameraLabel = UILabel()
    private let dateLabel = UILabel()
    private let photoImageView = ImageView()
    private let hStackView = UIStackView()
    private let vStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(url: URL, rover: String, camera: String, date: String) {
        roverLabel.text = rover
        cameraLabel.text = camera
        dateLabel.text = date
    
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(with: url)
    }
    
    private func makeLayout() {
        
        photoImageView.contentMode = .scaleAspectFit
        
        hStackView.axis = .horizontal
        hStackView.spacing = .margin * 2
        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        
        [hStackView, vStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [photoImageView, vStackView]
            .forEach(hStackView.addArrangedSubview)
        
        [roverLabel, cameraLabel, dateLabel]
            .forEach(vStackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .margin),
            hStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: .margin),
            hStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -.margin),
            hStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.margin),
            {
                let height = photoImageView.heightAnchor.constraint(equalToConstant: 100)
                height.priority -= 1
                return height
            }(),
            photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor)
        ])
    }
}
