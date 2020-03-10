//
//  Photo.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

class Photo {
    let url: URL
    var data: Data?
    
    init(url: URL) {
        self.url = url
    }
    
    static func parse(_ json: Any) -> [Photo]
    {
        guard
            let json = json as? [String: Any],
            let photosJSON = json["photos"] as? [[String: Any]]
        else { return [] }
        
        var photos = [Photo]()
        
        for photoJSON in photosJSON {
            guard
                let urlString = photoJSON["img_src"] as? String,
                let url = URL(string: urlString)
            else {
                return []
            }
            photos.append(Photo(url: url))
        }
        
        return photos
    }
}
