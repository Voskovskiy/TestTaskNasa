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
    
    enum SelectedRover {
        case all
        case specific(Rover)
    }
    
    enum SelectedCamera {
        case all
        case specific(Camera)
    }
    
    // MARK: - Properties:
    
    @IBOutlet weak var roverPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var processButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    private let rovers = Rover.all
    private let cameras = Camera.all
    private lazy var minDate = rovers.min(by: { $0.minDate < $1.minDate })!.minDate
    private lazy var maxDate = rovers.max(by: { $0.maxDate > $1.maxDate })!.maxDate
    
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
            return rovers.count + 1
            
        case .cameras:
            switch selectedRover {
            case .all:
                return cameras.count + 1
                
            case .specific(let selectedRover):
                return selectedRover.cameras.count + 1
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch Component.allCases[component] {
        case .rovers:
            switch rover(at: row) {
            case .all:
                return "All Rovers"
            case .specific(let rover):
                return rover.name
            }
            
        case .cameras:
            switch camera(at: row) {
            case .all:
                return "All Cameras"
            case .specific(let camera):
                return camera.description
            }
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
    
    private func updateDatePicker() {
        
        let minDate: Date
        let maxDate: Date
        
        switch selectedRover {
        case .all:
            minDate = self.minDate
            maxDate = self.maxDate
            
        case .specific(let rover):
            minDate = rover.minDate
            maxDate = rover.maxDate
        }
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.date = maxDate
    }
    
    private var selectedRover: SelectedRover {
        return rover(at: roverPicker.selectedRow(inComponent: Component.rovers.rawValue))
    }
    
    private func rover(at row: Int) -> SelectedRover {
        if row == 0 {
            return .all
        }
        
        return .specific(rovers[row - 1])
    }
    
    private var selectedCamera: SelectedCamera {
        return camera(at: roverPicker.selectedRow(inComponent: Component.cameras.rawValue))
    }
    
    private func camera(at row: Int) -> SelectedCamera {
        if row == 0 {
            return .all
        }
        
        switch self.selectedRover {
        case .all:
            return .specific(cameras[row - 1])
            
        case .specific(let selectedRover):
            return .specific(selectedRover.cameras[row - 1])
        }
    }
    
    // MARK: - Actions
    
    @IBAction func processButtonAction(_ sender: Any) {
        
        let rovers: [Rover]
        var photos = [Photo]()
        let specificCamera: Camera?
        
        switch selectedRover {
        case .all:
            rovers = self.rovers
            
        case .specific(let rover):
            rovers = [rover]
        }
        
        switch selectedCamera {
        case .all:
            specificCamera = nil
            
        case .specific(let camera):
            specificCamera = camera
        }
        
        
        guard let photoLoader = PhotoLoader(rovers: rovers, specificCamera: specificCamera, date: datePicker.date) else {
            return
        }
        
        processButton.isEnabled = false
        statusLabel.text = "Processing your reqeust..."
        
        photoLoader.load { result in

            switch result {
            case .success(let response):
                photos.append(contentsOf: response)
                
            case .failure:
                self.show(message: "Failed to load photos")
            }
            
            DispatchQueue.main.async {
                if photos.isEmpty {
                    self.statusLabel.text = "No photos located. Please try again."
                    self.processButton.isEnabled = true
                    return
                } else {
                    let photoTableViewController = PhotoTableViewController(photors: photos)
                    
                    self.navigationController?.pushViewController(photoTableViewController, animated: true)
                    self.statusLabel.text = "Success. Awaiting new request"
                    self.processButton.isEnabled = true
                }
            }
        }
    }
}
