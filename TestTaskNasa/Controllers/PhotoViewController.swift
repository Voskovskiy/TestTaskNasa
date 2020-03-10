//
//  PhotoViewController.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private let imageView = UIImageView()
    
    init(image: UIImage) {
        imageView.image = image
        
        super.init(nibName: nil, bundle: nil)
        
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
