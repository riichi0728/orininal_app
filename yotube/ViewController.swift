//
//  ViewController.swift
//  yotube
//
//  Created by clark on 2022/05/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    var count: Int = 1
    var min: Int = 1
    var timer: Timer = Timer()
    let settingKey = "timer_value"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        displayUpdate()
        //  updateTime()
    }
    @IBAction func start() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.up),
                                         userInfo: nil,
                                         repeats: true)
        }
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = "Countdown"
        content.subtitle = "タイマー"
        content.body = "設定したタイマーが終了しました"
    }
    
    @IBAction func stop() {
        if timer.isValid {
            timer.invalidate()
        }
    }
    
    @objc func up() {
        count = count + 1
        if displayUpdate() <= 0 {
            count = 0
            
            timer.invalidate()
        }
    }
    
    @IBAction func reset() {
        // 1. タイマーが動いたらタイマーを止める
        if timer.isValid {
            timer.invalidate()
        }
        // 2. countを0.0に初期化する
        count = 0
        
        // 3. 初期化したcountをlabelに表示させる
        label.text = String(format: "%.2f", count)
        
    }
    
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainCount = timerValue - count
        label.text = timeString(time: TimeInterval(remainCount))
         
        if remainCount <= 0 {
            timer.invalidate()
            
            let content = UNMutableNotificationContent()
            content.title = "通知"
            content.body = "観んな"
            content.sound = UNNotificationSound.default
            
            // 直ぐに通知を表示
            let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
        return remainCount
        
    }
    
    func timeString (time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let min = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        return String(format: "%02d:%02d:%02d", hour,min,second)
        
    }
    @IBAction func localPush(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "お知らせ"
        content.body = "ボタンを押しました。"
        content.sound = UNNotificationSound.default
        
        // 直ぐに通知を表示
        let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // func updateTime() {
    
    //     let timerValue = UserDefaults.standard.array(forKey: settingKey) as? [Int] ?? []
    //     let hour:Int? = timerValue[0] ?? 0
    //    label.text = "残り\(String(describing: hour))秒"
    //}
    
    
    
    
}
