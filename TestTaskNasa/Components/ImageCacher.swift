//
//  ImageCacher.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/8/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

class ImageCacher {
    
    func save(_ image: UIImage, name: String)
    {
        guard let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        // Change extension if you want to save as PNG.
        let imgPath = documentDirectoryPath.appendingPathComponent("1.jpg")

        try? image.jpegData(compressionQuality: 1)?.write(to: imgPath, options: .atomic)
    }
    
    func load(path: String) -> UIImage?
    {
        guard let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        // Change extension if you want to save as PNG.
        let imgPath = documentDirectoryPath.appendingPathComponent(path)
        guard let data = try? Data(contentsOf: imgPath, options: []) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}
