//
//  settingViewController.swift
//  yotube
//
//  Created by clark on 2022/06/07.
//

import UIKit

class settingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    let settingArray = [[Int](0...23),[Int](0...59),[Int](0...59)]
    let settingKey = "timer_value"
    var timetotal:Int!
    let settings = UserDefaults.standard
    @IBOutlet var timerSettingPicker: UIPickerView!
    @IBOutlet var mintimerSettingPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerSettingPicker.delegate = self
        timerSettingPicker.dataSource = self
        
//        mintimerSettingPicker.delegate = self
//        mintimerSettingPicker.dataSource = self
    
//        let settings = UserDefaults.standard
       
        let timerValue = settings.integer(forKey: settingKey)
        
       // for row in 0..<settingArray.count{
            //if settingArray[component][row] == timerValue {
               // timerSettingPicker.selectRow(row, inComponent: 0, animated: true)
       //     }
     //   }
    }
    @IBAction func decisionButton() {
        total()
        settings.set(timetotal, forKey: "timer_value")
         navigationController?.popViewController(animated: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return settingArray.count
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray[component].count
        
    }
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return String(settingArray[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      total()
        let setting = UserDefaults.standard
        setting.setValue(timetotal,forKey: settingKey)
        setting.synchronize()
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
         func total(){
             timetotal = settingArray[0][timerSettingPicker.selectedRow(inComponent: 0)] * 60 * 60 +
            settingArray[1][timerSettingPicker.selectedRow(inComponent: 1)] * 60 +
            settingArray[2][timerSettingPicker.selectedRow(inComponent: 2)]

            
             
             
         }
         
         
}
