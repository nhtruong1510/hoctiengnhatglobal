//
//  HiraganaViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

enum Hiragana: CaseIterable {
    case Hiragana
    case Katakana
    var text: String {
        switch self {
        case .Hiragana:
            return "Hiragana"
        case .Katakana:
            return "Katakana"
        }
    }
}

class HiraganaViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var katakanaView: UIView!
    @IBOutlet weak var katakanaButton: UIButton!
    @IBOutlet weak var hiraganaView: UIView!
    @IBOutlet weak var hiraganaButton: UIButton!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hiraganaAction() {
        choose = 0
        setChooseHiraganaView()
        setDefaultKatakanaView()
        labelName.text = "Hiragana"
        collectionView.reloadData()
    }
    
    @IBAction func katakanaAction() {
        choose = 1
        setChooseKatakanaView()
        setDefaultHiraganaView()
        labelName.text = "Katakana"
        collectionView.reloadData()
    }
    
    var isGreenBg = false
    var listTitleHiragana: [Hiragana] = Hiragana.allCases
    var listHiragana: [HeaderHiragana] = [HeaderHiragana]()
    var language: Language = .English
    var choose = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultKatakanaView()
        setChooseHiraganaView()
        collectionView.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            collectionView.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            collectionView.backgroundColor = .clear
        }
        if choose == 0 {
            labelName.text = "Hiragana"
        }
        else {
            labelName.text = "Katakana"
        }
        katakanaView.layer.cornerRadius = 20
        hiraganaView.layer.cornerRadius = 20
        collectionView.layer.cornerRadius = 20
        self.collectionView.register(UINib(nibName: "Hiragana1CLVCell", bundle: nil), forCellWithReuseIdentifier: "Hiragana1CLVCell")
        self.collectionView.register(UINib(nibName: "HiraganaTitleCell", bundle: nil), forCellWithReuseIdentifier: "HiraganaTitleCell")
        KanjiService.shared.getDataHiragana(){ repond,error in
            if let repond = repond{
                self.listHiragana = repond
                self.collectionView.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setDefaultHiraganaView() {
        hiraganaView.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        hiraganaView.layer.borderWidth = 1
        hiraganaView.layer.borderColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        hiraganaButton.setTitleColor(#colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1), for: .normal)
    }
    
    func setDefaultKatakanaView() {
        katakanaView.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        katakanaView.layer.borderWidth = 1
        katakanaView.layer.borderColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        katakanaButton.setTitleColor(#colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1), for: .normal)
    }
    
    func setChooseKatakanaView() {
        katakanaView.backgroundColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        katakanaButton.setTitleColor(.white, for: .normal)
    }
    
    func setChooseHiraganaView() {
        hiraganaView.backgroundColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        hiraganaButton.setTitleColor(.white, for: .normal)
    }
}

extension HiraganaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 2
//        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HiraganaTitleCell", for: indexPath) as! HiraganaTitleCell
//            cell.labelName.text = listTitleHiragana[indexPath.item].text
//            if choose == 1 {
//                if indexPath.item == 0 {
//                    cell.layer.borderWidth = 1
//                    cell.layer.borderColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
//                    cell.layer.cornerRadius = 18
//                }
//                else {
//                    cell.layer.borderWidth = 0
//                    cell.layer.borderColor = .none
//                    cell.roundCorners([.topLeft, .topRight], radius: 18)
//                }
//            }
//            else {
//                if indexPath.item == 1 {
//                    cell.layer.borderWidth = 1
//                    cell.layer.borderColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
//                    cell.layer.cornerRadius = 18
//                }
//                else {
//                    cell.layer.borderWidth = 0
//                    cell.layer.borderColor = .none
//                    cell.roundCorners([.topLeft, .topRight], radius: 18)
//                }
//            }
//            return cell
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Hiragana1CLVCell", for: indexPath) as! Hiragana1CLVCell
        if choose == 0 {
            cell.isChooseHiragana = true
        }
        else {
            cell.isChooseHiragana = false
        }
        cell.listHiragana = listHiragana
        cell.collectionView.reloadData()
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        return cell
    }
}

extension HiraganaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
