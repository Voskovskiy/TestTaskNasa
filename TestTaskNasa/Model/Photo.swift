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
    let rover: String
    let date: String
    let camera: String
    
    init(url: URL, rover: String, camera: String, date: String) {
        self.url = url
        self.rover = rover
        self.camera = camera
        self.date = date
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
                let url = URL(string: urlString),
                let date = photoJSON["earth_date"] as? String,
                let cameraJSON = photoJSON["camera"] as? [String: Any],
                let roverJSON = photoJSON["rover"] as? [String: Any]
            else {
                return []
            }
            guard
                let camera = cameraJSON["full_name"] as? String,
                let rover = roverJSON["name"] as? String
                else {
                    return []
            }
            photos.append(Photo(url: url, rover: rover, camera: camera, date: date))
        }
        
        return photos
    }
}
