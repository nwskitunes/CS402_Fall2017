//
//  ViewController.swift
//  RollCast
//
//  Created by Wade Morris on 11/14/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var riverPicker: UIPickerView!
    
    private var stateArray:[String] = ["Idaho", "Montana"]
    private var idRiver:[String] = ["Big Wood", "Big Lost - Mackay", "Boise - South Fork", "Silver Creek", "The Upper Lost"]
    private var mtParse:[String] = ["BigHole", "Beaverhead", "Jefferson", "UpperClarkFork", "RockCreek"]
    private var mtRiver:[String] = ["Big Hole", "Beaverhead", "Jefferson", "Upper Clark Fork", "Rock Creek"]
    private var selectArray:[String] = ["Big Wood", "Big Lost - Mackay", "Boise - South Fork", "Silver Creek", "The Upper Lost"]
    private var riverSelect: String = "Big Wood"
    private var stateSelect: String = "Idaho"
    var riverReportString: String = ""
    private var currRiver: String = "Big Wood"
    private var currState: String = "Idaho"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statePicker.dataSource = self
        statePicker.delegate = self
        riverPicker.dataSource = self
        riverPicker.delegate = self
    }
    
    //Future code to implement dropdown UIPickerview with text field
    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        self.textBox.text = self.list[row]
//        self.dropDown.hidden = true
//        
//    }
//    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        
//        if textField == self.textBox {
//            self.dropDown.hidden = false
//            //if you dont want the users to se the keyboard type:
//            
//            textField.endEditing(true)
//        }
//        
//        
//    }
    

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
            self.stateSelect = stateArray[row]
            return stateArray[row]
        } else if (pickerView == riverPicker) {
            self.riverSelect = selectArray[row]
            print("**CURRENT STATE** = " + stateSelect + " %%$$CURRENT RIVER$$%% = " + riverSelect)
            
            //Alamofire requests and parsing
            
            if(stateSelect == "Montana"){
                var parseString: String = ""
                if let tempInt: Int = mtRiver.index(of: riverSelect){
                    parseString = mtParse[tempInt]
                }
                
                print("****WHAT RIVER AM I?**** = " + self.riverSelect)
                print("got to montana")
                Alamofire.request("https://www.parsehub.com/api/v2/projects/tTm_d3ndSbDz/last_ready_run/data?api_key=taFVm435GTUk").responseString{
                    response in
                    print (response)
                    if let JSON = response.result.value {
                        if (JSON.contains(parseString)) {
                            let riverInfo: [String] = JSON.components(separatedBy: "\"")
                            if let i:Int = riverInfo.index(of: parseString){
                                let riverInt:Int = i
                                self.riverReportString = riverInfoArray[riverInt + 2]
                                print("*****TEST REPORT*****" + self.riverReportString)
                            }
                            else{
                                self.riverReportString = ""
                            }
                            print("****This is the Report****" + self.riverReportString)
                        }
                    }
                    
                }
            }
            else if(stateSelect == "Idaho"){
                print("****WHAT RIVER AM I?= " + self.riverSelect)
                Alamofire.request("https://www.parsehub.com/api/v2/projects/taTEaYQGbC1h/last_ready_run/data?api_key=taFVm435GTUk").responseString{
                    response in
                    print(response)
                    
                }
                
            }
            return selectArray[row]
        }
        return ""

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("$$**CURRENT STATE 2**$$" + stateSelect)
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
            
            print("^^CURRENT STATE 4\n" + stateSelect)
            
            riverPicker.reloadAllComponents()
        }
//        print("###CURRENT RIVER 2 = " + riverSelect)
//        print("%%**CURRENT STATE 3**%%\n" + stateSelect)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.currRiver = self.riverSelect
        self.currState = self.stateSelect
//        print("Current River: " + currRiver + "Current State: " + currState)
    }
    
    @IBAction func goButton(_ sender: Any) {
        let reportControl = self.storyboard?.instantiateViewController(withIdentifier: "ReportController") as! ReportController
        reportControl.reportStringTest = self.riverReportString
        self.present(reportControl, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

