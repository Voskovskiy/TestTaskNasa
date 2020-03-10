//
//  MainViewController.swift
//  TestTaskNasa
//
//  Created by Konstyantyn Voskovskyi on 3/2/20.
//  Copyright © 2020 Voskovskiy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    enum Component: Int, CaseIterable {
        case rovers
        case cameras
    }
    
    // MARK: - Properties:
    
    @IBOutlet weak var roverPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var processButton: UIButton!
    
    private let rovers = Rover.all

    override func viewDidLoad() {
        super.viewDidLoad()
        
        processButton.layer.cornerRadius = 10
        updateDatePicker()
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Component.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch Component.allCases[component] {
        case .rovers:
            return rovers.count
            
        case .cameras:
            let selectedRover = roverPicker.selectedRow(inComponent: Component.rovers.rawValue)
            return rovers[selectedRover].cameras.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch Component.allCases[component] {
            case .rovers:
                return rovers[row].name
                
            case .cameras:
                let selectedRover = roverPicker.selectedRow(inComponent: Component.rovers.rawValue)
                return rovers[selectedRover].cameras[row].description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch Component.allCases[component] {
            case .rovers:
                roverPicker.reloadComponent(Component.cameras.rawValue)
                updateDatePicker()
                
            case .cameras:
                break
        }
    }
    
    private func updateDatePicker()
    {
        let selectedRover = roverPicker.selectedRow(inComponent: Component.rovers.rawValue)
        let rover = rovers[selectedRover]

        datePicker.minimumDate = rover.minDate
        datePicker.maximumDate = rover.maxDate
        datePicker.date = rover.maxDate
    }
    
    // MARK: - Actions
    
    @IBAction func processButtonAction(_ sender: Any) {
        let rover = rovers[roverPicker.selectedRow(inComponent: Component.rovers.rawValue)]
        let camera = rover.cameras[roverPicker.selectedRow(inComponent: Component.cameras.rawValue)]
        let date = datePicker.date
        
        let photoTableViewController = PhotoTableViewController(
            rover: rover,
            camera: camera,
            date: date
        )
        
        navigationController?.pushViewController(photoTableViewController, animated: true)
    }
}
