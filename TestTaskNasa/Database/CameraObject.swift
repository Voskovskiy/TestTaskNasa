//
//  Camera.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/4/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation
import RealmSwift

class CameraObject: Object {
    dynamic var name = ""
    dynamic var fullName = ""
    dynamic var photoByDate = [PhotoObject]()
}
