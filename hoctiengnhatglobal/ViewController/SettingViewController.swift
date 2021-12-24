//
//  SettingViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit
import SwiftKeychainWrapper

class SettingViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var backgroundSwitch: UISwitch!
    @IBOutlet weak var labelBackground: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!

    var listLanguage: [Language] = Language.allCases
    var isGreenBg = false
    var chooseLanguage = 0
    var language: Language = .English
    var didSendDataBackground: ((Bool) -> ())?
    var didSendDataLanguage: ((Int) -> ())?
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setLanguage()
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            backgroundSwitch.setOn(true, animated: true)
            backgroundSwitch.isOn = true
            
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            backgroundSwitch.setOn(false, animated: true)
            backgroundSwitch.isOn = false
        }
        labelTitle.text = name
        tblView.dataSource = self
        tblView.delegate = self
        tblView.backgroundColor = .clear
        tblView.register(UINib(nibName: "SettingTBVCell", bundle: nil), forCellReuseIdentifier: "SettingTBVCell")
        backgroundSwitch.layer.borderWidth = 0.5
        backgroundSwitch.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        backgroundSwitch.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
        didSendDataLanguage!(chooseLanguage)
    }
    
    @IBAction func setBackground(_ sender: UISwitch) {
        if backgroundSwitch.isOn {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
//            backgroundSwitch.setOn(false, animated: true)
//            backgroundSwitch.isOn = false
        }
        else {
//            backgroundSwitch.setOn(true, animated: true)
//            backgroundSwitch.isOn = true
            labelTitle.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        KeychainWrapper.standard.set(backgroundSwitch.isOn, forKey: "BACKGROUND")
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listLanguage.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTBVCell", for: indexPath) as! SettingTBVCell
        chooseLanguage = KeychainWrapper.standard.integer(forKey: "LANGUAGE")!
        cell.imgView.isHidden = true
        if chooseLanguage == indexPath.item {
            cell.imgView.isHidden = false
        }
        cell.labelName.text = listLanguage[indexPath.row].text
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        KeychainWrapper.standard.set(indexPath.item, forKey: "LANGUAGE")
        chooseLanguage = indexPath.item
        tblView.reloadData()
        setLanguage()
    }

    func setLanguage() {
        if chooseLanguage == 1 {
            labelTitle.text = "Cài đặt"
            labelLanguage.text = "Ngôn ngữ"
            labelBackground.text = "Giao diện"
        }
        else {
            labelTitle.text = "Setting"
            labelLanguage.text = "Language"
            labelBackground.text = "Background"
        }
    }
}
