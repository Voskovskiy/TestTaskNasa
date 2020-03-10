//
//  Camera.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation

class Camera {
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    static let fhaz = Camera(name: "FHAZ", description: "Front Hazard Avoidance Camera")
    static let rhaz = Camera(name: "RHAZ", description: "Rear Hazard Avoidance Camera")
    static let mast = Camera(name: "MAST", description: "Mast Camera")
    static let chemcam = Camera(name: "CHEMCAM", description: "Chemistry and Camera Complex")
    static let mahli = Camera(name: "MAHLI", description: "Mars Hand Lens Imager")
    static let mardi = Camera(name: "MARDI", description: "Mars Descent Imager")
    static let navcam = Camera(name: "NAVCAM", description: "Navigation Camera")
    static let pancam = Camera(name: "PANCAM", description: "Panoramic Camera")
    static let minites = Camera(name: "MINITES", description: "Miniature TES")
}
