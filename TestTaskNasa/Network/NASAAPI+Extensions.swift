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
        case .getManifest(let rover):
            return "/manifests/\(rover)&\(apiAuthKey)"
        case .listPhotos(let rover, _, _, _):
            return "/rovers/\(rover)/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getManifest, .listPhotos:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getManifest:
            return ["api_key": apiAuthKey]
        case .listPhotos(_, let camera, let date, let page):
            return [
                "earth_date": date,
                "camera": camera,
                "page": page,
                "api_key": apiAuthKey
            ]
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
        case .getManifest, .listPhotos:
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
