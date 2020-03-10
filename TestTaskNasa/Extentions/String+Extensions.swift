//
//  String+Extensions.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/7/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
