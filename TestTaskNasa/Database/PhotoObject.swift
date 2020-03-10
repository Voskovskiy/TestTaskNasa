//
//  PhotoObject.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/4/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoObject: Object {
    dynamic var date = Date()
    dynamic var pathToImage = [String]()
}
