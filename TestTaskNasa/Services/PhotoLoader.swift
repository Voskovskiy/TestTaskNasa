//
//  PhotoLoader.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/11/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation
import Moya

class PhotoLoader {
    private let rovers: [Rover]
    private let specificCamera: Camera?
    private let date: Date
    private let queue = DispatchQueue(label: "PhotoLoader.queue")
    
    init?(rovers: [Rover], specificCamera: Camera?, date: Date) {
        if rovers.isEmpty { return nil }
        
        self.rovers = rovers
        self.specificCamera = specificCamera
        self.date = date
    }
    
    func load(completion: @escaping (Result<[Photo], Error>) -> Void) {
        var requestCount = rovers.count
        var requests = [Cancellable]()
        var allPhotos = [Photo]()
        
        rovers.forEach { rover in
            let request = loadPhotos(rover: rover) { result in
                self.queue.async {
                    switch result {
                    
                    case .failure(let error):
                        requests.forEach {
                            $0.cancel()
                        }
                        completion(.failure(error))
                        
                    case .success(let photos):
                        allPhotos.append(contentsOf: photos)
                        
                        requestCount -= 1
                        if requestCount == 0 {
                            completion(.success(allPhotos))
                        }
                    }
                }
            }
            requests.append(request)
        }
    }
    
    private func loadPhotos(rover: Rover, completion: @escaping (Result<[Photo], Error>) -> Void) -> Cancellable {
        let nasaAPI = MoyaProvider<NASAAPI>()
        return nasaAPI.request(.photos(rover: rover.name, camera: specificCamera?.name, date: NASAAPI.string(date))) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try response.mapJSON()
                    let photos = Photo.parse(json)
                    completion(.success(photos))
                }
                catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
