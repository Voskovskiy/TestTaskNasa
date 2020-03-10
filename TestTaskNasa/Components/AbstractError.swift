//
//  AbstractError.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/7/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation

enum AbstractError: LocalizedError {
    case message(String)
    
    var errorDescription: String? {
        switch self {
        case .message(let message): return message
        }
    }
}
