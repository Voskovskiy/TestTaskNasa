//
//  TargetType+Extensions.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/7/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import Foundation
import Moya

extension NASAAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.nasa.gov/mars-photos/api/v1")! }
    
    var apiAuthKey: String { return "gy9uMPidiAl5vQZYLngpxrn1HMUKhhZtyzApneKf" }
    
    var path: String {
        switch self {
        case .photos(let rover, _, _):
            return "/rovers/\(rover)/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any] {
        switch self {
        case .photos(_, let camera, let date):
            var parameters = [
                "earth_date": date,
                "api_key": apiAuthKey
            ]
            
            if let camera = camera {
                parameters["camera"] = camera
            }
            
            return parameters
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var task: Task {
        switch self {
        case .photos:
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
