//
//  TableView+Extensions.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/9/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let reuseID = String(describing: Cell.self)
        register(Cell.self, forCellReuseIdentifier: reuseID)
        return dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! Cell
    }
}
