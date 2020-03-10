//
//  Rover.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/4/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation
import RealmSwift

class RoverObject: Object {
    dynamic var name: String = ""
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date = Date()
    dynamic var cameras = [Camera]()
}
