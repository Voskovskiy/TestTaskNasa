//
//  UIViewController+Extensions.swift
//  TestTaskNasa
//
//  Created by Roman Voskovskyi on 10.03.2020.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
