//
//  PhotoTableViewCell.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit
import Moya

class PhotoTableViewCell: UITableViewCell {
    
    let photoImageView = ImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func makeLayout() {
        
        photoImageView.contentMode = .scaleAspectFit
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        let heightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: 100)
        heightConstraint.priority -= 1
        heightConstraint.isActive = true
    }
}
