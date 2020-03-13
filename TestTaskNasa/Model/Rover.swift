//
//  RoverAndCameras.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation

class Rover {
    
    let name: String
    let cameras: [Camera]
    let minDate: Date
    let maxDate: Date
    
    init(name: String, cameras: [Camera], minDate: Date, maxDate: Date) {
        self.name = name
        self.cameras = cameras
        self.minDate = minDate
        self.maxDate = maxDate
    }
    
    static let all: [Rover] = [.curiosity, .opportunity, .spirit]
    
    static let curiosity = Rover(
        name: "Curiosity",
        cameras: [.fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam],
        minDate: date("2012-08-06"),
        maxDate: date("2019-09-28")
    )
    
    static let opportunity = Rover(
        name: "Opportunity",
        cameras: [.fhaz, .rhaz, .navcam, .pancam, .minites],
        minDate: date("2004-01-25"),
        maxDate: date("2018-06-11")
    )
    
    static let spirit = Rover(
        name: "Spirit",
        cameras: [.fhaz, .rhaz, .navcam, .pancam, .minites],
        minDate: date("2004-01-04"),
        maxDate: date("2010-03-21")
    )
}

fileprivate let date = NASAAPI.date
