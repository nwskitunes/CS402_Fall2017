//
//  ViewController.swift
//  RollCast
//
//  Created by Wade Morris on 11/14/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var riverPicker: UIPickerView!
    
    var stateArray = ["Idaho", "Montana"]
    var idRiver = ["Snake", "Owhyee", "Silver Creek", "Boise", "Clearwater", "CDA", "Spokane"]
    var mtRiver = ["Big Hole", "Beaverhead", "Jefferson", "Upper Clark Fork", "Rock Creek"]
    var selectArray = ["Snake", "Owhyee", "Silver Creek", "Boise", "Clearwater", "CDA", "Spokane"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statePicker.dataSource = self
        statePicker.delegate = self
        riverPicker.dataSource = self
        riverPicker.delegate = self
    }
    // DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == statePicker){
            return stateArray.count
        }
        else if(pickerView == riverPicker){
            return selectArray.count
        }
        return 0
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == statePicker) {
            return stateArray[row]
        } else if (pickerView == riverPicker) {
            return selectArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == statePicker){
            switch row {
            case 0:
                selectArray = idRiver
            case 1:
                selectArray = mtRiver
//            case 2:
//                selectArray = ogRiver
//            case 3:
//                selectArray = waRiver
//            case 4:
//                selectArray = wyRiver
            default:
                selectArray = idRiver
            }
            riverPicker.reloadAllComponents()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

