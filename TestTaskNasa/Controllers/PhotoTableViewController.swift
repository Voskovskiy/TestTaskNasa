//
//  PhotoTableViewController.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit
import Moya
import Kingfisher

class PhotoTableViewController: UITableViewController {
    
    private var photos = [Photo]()
    
    init(photors: [Photo]) {
        self.photos = photors
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView() // hides empty cells
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photo = photos[indexPath.row]
        let cell: PhotoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.configure(
            url: photo.url,
            rover: photo.rover,
            camera: photo.camera,
            date: photo.date
        )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let photo = photos[indexPath.row]
        
        KingfisherManager.shared.retrieveImage(with: photo.url, options: [.cacheMemoryOnly]) { result in
            switch result
            {
            case .failure: return
            case .success(let image):
                let photoViewController = PhotoViewController(image: image.image)
                photoViewController.title = photo.camera
                self.navigationController?.pushViewController(photoViewController, animated: true)
            }
        }
    }
}
