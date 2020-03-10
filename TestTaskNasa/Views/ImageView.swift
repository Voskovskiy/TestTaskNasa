//
//  ImageView.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    private weak var activityIndicator: UIActivityIndicatorView?
    
    func setImage(url: URL, completion: @escaping (Data?) -> Void) {
        image = nil
        makeActivityIndicator().startAnimating()
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.activityIndicator?.removeFromSuperview()
                if let data = data {
                    self.image = UIImage(data: data)
                }
                completion(data)
            }
        }
    }
    
    private func makeActivityIndicator() -> UIActivityIndicatorView {
        if let activityIndicator = self.activityIndicator {
            return activityIndicator
        }
        
        let activityIndicator = UIActivityIndicatorView()
        self.activityIndicator = activityIndicator
        activityIndicator.color = .systemBlue
        activityIndicator.frame = frame
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(activityIndicator)
        
        return activityIndicator
    }
}
