//
//  PhotoTableViewController.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit
import Moya

class PhotoTableViewController: UITableViewController {
    
    private let rover: Rover
    private let camera: Camera
    private let date: Date
    
    private var photos = [Photo]()
    
    init(rover: Rover, camera: Camera, date: Date) {
        self.rover = rover
        self.camera = camera
        self.date = date
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() // hides empty cells
        loadPhotos()
    }
    
    private func loadPhotos() {
        
        let provider = MoyaProvider<NASAAPI>()
        provider.request(.listPhotos(rover: rover.name, camera: camera.name, date: NASAAPI.string(date), page: 1)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.photos = Photo.parse((try? response.mapJSON()) as Any)
                
            case .failure:
                self.show(message: "Failed to load photos")
            }
            
            DispatchQueue.main.async {
                if self.photos.isEmpty {
                    self.show(message: "No photos")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = photos[indexPath.row]
        let cell: PhotoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let data = photo.data {
            cell.photoImageView.image = UIImage(data: data)
        }
        else {
            cell.photoImageView.setImage(url: photo.url) { data in
                photo.data = data
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = photos[indexPath.row]
        guard
            let data = photo.data,
            let image = UIImage(data: data)
        else { return }
        
        let photoViewController = PhotoViewController(image: image)
        navigationController?.pushViewController(photoViewController, animated: true)
    }
}
