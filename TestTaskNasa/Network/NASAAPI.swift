//
//  NASAAPI.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/7/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation
import Moya

enum NASAAPI {
    case photos(rover: String, camera: String?, date: String)
}

extension NASAAPI
{
    static func date(_ string: String) -> Date
    {
        return formatter.date(from: string)!
    }
    
    static func string(_ date: Date) -> String
    {
        return formatter.string(from: date)
    }
}

fileprivate let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    return formatter
}()
