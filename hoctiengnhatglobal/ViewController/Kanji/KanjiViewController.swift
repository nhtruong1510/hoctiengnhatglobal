//
//  KanjiViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/6/21.
//

import UIKit

class KanjiViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionPageView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listOnyomi: [String] = []
    var listKunyomi: [String] = []
    var listKanji: [KanjiModel] = [KanjiModel]()
    var section = 0
    var rank = 0
    var level = 0
    var nameSection = ""
    var language: Language = .English
    var isGreenBg = false
    var chooseNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
        }
        labelName.text = "Kanji N" + String(level + 1) + " | " + "Set " + String(rank)
        self.collectionPageView.register(UINib(nibName: "KanjiTextCell", bundle: nil), forCellWithReuseIdentifier: "KanjiTextCell")
        collectionPageView.layer.cornerRadius = 15
        self.collectionView.register(UINib(nibName: "KanjiTextCell", bundle: nil), forCellWithReuseIdentifier: "KanjiTextCell")
        self.collectionView.register(UINib(nibName: "OnyomiCLVCell", bundle: nil), forCellWithReuseIdentifier: "OnyomiCLVCell")
        self.collectionView.register(UINib(nibName: "OnyomiTitleCLVCell", bundle: nil), forCellWithReuseIdentifier: "OnyomiTitleCLVCell")
        self.collectionView.register(UINib(nibName: "RadicalCLVCell", bundle: nil), forCellWithReuseIdentifier: "RadicalCLVCell")
        self.collectionView.register(UINib(nibName: "Example2CLVCell", bundle: nil), forCellWithReuseIdentifier: "Example2CLVCell")
        self.collectionView.register(UINib(nibName: "OnyomiNameCLVCell", bundle: nil), forCellWithReuseIdentifier: "OnyomiNameCLVCell")

        collectionView.backgroundColor = .clear
        var cellWidth = 0
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellWidth = Int(UIScreen.main.bounds.width) / 5 - 10
        } else {
            cellWidth = Int(UIScreen.main.bounds.width) / 3 - 10
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 120) / 90)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        KanjiService.shared.getDataKanji() { repond,error in
            if let repond = repond{
                self.listKanji = repond
                self.collectionView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func getListDetail() -> [KanjiModel]{
        var listKanji: [KanjiModel] = [KanjiModel]()
        for item in self.listKanji {
            if item.level == level + 1 && item.rank == rank {
                listKanji.append(item)
            }
        }
        return listKanji
    }
    
//    func getSetDetail() -> [KanjiModel]{
//        var listKanji: [KanjiModel] = [KanjiModel]()
//        for item in self.listKanji {
//            if item.level == level + 1 && item.rank == rank {
//                listKanji.append(item)
//            }
//        }
//        return listKanji
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension KanjiViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return 11
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if section == 2 {
                return 2
            }
            else if section == 4 {
                listOnyomi = getOnyomi(index: section)
                return listOnyomi.count/2
            }
            else if section == 6 {
                listKunyomi = getOnyomi(index: section)
                return listKunyomi.count/2
            }
            return 1
        }
        return getListDetail().count
    }
    
    func getOnyomi(index: Int) -> [String] {
        var listOnyomi: [String] = []
        var onyomi1 = ""
        var onyomi2 = ""
        var onyomi3 = ""
        var onyomi4 = ""

        if index == 5 {
            onyomi1 = getListDetail()[chooseNumber].k_vidu1
            onyomi2 = getListDetail()[chooseNumber].k_vidu2
            onyomi3 = getListDetail()[chooseNumber].k_vidu3
            onyomi4 = getListDetail()[chooseNumber].k_vidu4
        }
        else {
            onyomi1 = getListDetail()[chooseNumber].o_vidu1
            onyomi2 = getListDetail()[chooseNumber].o_vidu2
            onyomi3 = getListDetail()[chooseNumber].o_vidu3
            onyomi4 = getListDetail()[chooseNumber].o_vidu4
        }
        
        let onyomi1Arr = onyomi1.components(separatedBy: .newlines)
        let onyomi2Arr = onyomi2.components(separatedBy: .newlines)
        let onyomi3Arr = onyomi3.components(separatedBy: .newlines)
        let onyomi4Arr = onyomi4.components(separatedBy: .newlines)
        
        if onyomi1Arr.count > 3 {
            if language == .English {
                listOnyomi.append(onyomi1Arr[2])
            }
            else if language == .Vietnamese {
                listOnyomi.append(onyomi1Arr[1])
            }
            else {
                listOnyomi.append(onyomi1Arr[3])
            }
            listOnyomi.append(onyomi1Arr[0])
        }
        
        if onyomi2Arr.count > 3 {
            if language == .English {
                listOnyomi.append(onyomi2Arr[2])
            }
            else if language == .Vietnamese {
                listOnyomi.append(onyomi2Arr[1])
            }
            else {
                listOnyomi.append(onyomi2Arr[3])
            }
            listOnyomi.append(onyomi2Arr[0])
        }
        
        if onyomi3Arr.count > 3 {
            if language == .English {
                listOnyomi.append(onyomi3Arr[2])
            }
            else if language == .Vietnamese {
                listOnyomi.append(onyomi3Arr[1])
            }
            else {
                listOnyomi.append(onyomi3Arr[3])
            }
            listOnyomi.append(onyomi3Arr[0])
        }
        
        if onyomi4Arr.count > 3 {
            if language == .English {
                listOnyomi.append(onyomi4Arr[2])
            }
            else if language == .Vietnamese {
                listOnyomi.append(onyomi4Arr[1])
            }
            else {
                listOnyomi.append(onyomi4Arr[3])
            }
            listOnyomi.append(onyomi4Arr[0])
        }
        return listOnyomi
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KanjiTextCell", for: indexPath) as! KanjiTextCell
                cell.labelName.text = getListDetail()[chooseNumber].namekanji
                cell.labelName.font = .systemFont(ofSize: 50)
                return cell
            }
            if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KanjiTextCell", for: indexPath) as! KanjiTextCell
                let listMeaning = getOnyomi(index: indexPath.section)
                if listMeaning.count > 0 {
                    cell.labelName.text = listMeaning[1]
                }
                else {
                    cell.labelName.text = ""
                }
                cell.labelName.font = .boldSystemFont(ofSize: 16)
                return cell
            }
            else if indexPath.section == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnyomiNameCLVCell", for: indexPath) as! OnyomiNameCLVCell
                if indexPath.item == 0 {
                    cell.labelTitle.text = "Onyomi"
                    cell.labelName.text = getListDetail()[chooseNumber].onyomi
                }
                else {
                    cell.labelTitle.text = "Kunyomi"
                    cell.labelName.text = getListDetail()[chooseNumber].kunyomi
                }
                if isGreenBg {
                    cell.labelName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                else {
                    cell.labelName.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
                }
                return cell
            }
            else if indexPath.section == 10 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Example2CLVCell", for: indexPath) as! Example2CLVCell
                cell.listExample.removeAll()
                if language == .English {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu1_eng)
                }
                else if language == .Vietnamese {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu1_vn)
                }
                else {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu1_indo)
                }
                cell.listExample.append(getListDetail()[chooseNumber].cauvidu1_jp)
                
                if language == .English {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu2_eng)
                }
                else if language == .Vietnamese {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu2_vn)
                }
                else {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu2_indo)
                }
                
                cell.listExample.append(getListDetail()[chooseNumber].cauvidu2_jp)
                if language == .English {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu3_eng)
                }
                else if language == .Vietnamese {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu3_vn)
                }
                else {
                    cell.listExample.append(getListDetail()[chooseNumber].cauvidu3_indo)
                }
                cell.listExample.append(getListDetail()[chooseNumber].cauvidu3_jp)
                cell.collectionView.reloadData()
                return cell
            }
            else if indexPath.section == 8 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadicalCLVCell", for: indexPath) as! RadicalCLVCell
                cell.radicals = getListDetail()[chooseNumber].radicals
                cell.language = language
                cell.collectionView.reloadData()
                //cell.index = indexPath.item
                return cell
            }
            else if indexPath.section == 6 || indexPath.section == 4 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnyomiCLVCell", for: indexPath) as! OnyomiCLVCell
                if indexPath.section == 4 {
                    if listOnyomi.count > 0 {
                        cell.labelName.text = listOnyomi[indexPath.item*2]
                        cell.labelJpn.text = listOnyomi[indexPath.item*2 + 1]
                    }
                }
                else {
                    if listKunyomi.count > 0 {
                        cell.labelName.text = listKunyomi[indexPath.item*2]
                        cell.labelJpn.text = listKunyomi[indexPath.item*2 + 1]
                    }
                }
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnyomiTitleCLVCell", for: indexPath) as! OnyomiTitleCLVCell
            if indexPath.section == 3 {
                cell.labelName.text = "Onyomi"
            }
            else if indexPath.section == 5 {
                cell.labelName.text = "Kunyomi"
            }
            else if indexPath.section == 7 {
                cell.labelName.text = "Radicals"
            }
            else {
                cell.labelName.text = "Examples"
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KanjiTextCell", for: indexPath) as! KanjiTextCell
        cell.labelName.textColor = .black
        if chooseNumber == indexPath.item {
            cell.labelName.textColor = .red
        }
        if getListDetail().count > 0 {
            cell.labelName.text = getListDetail()[indexPath.item].namekanji
        }
        else {
            cell.labelName.text = ""
        }
        cell.labelName.font = .systemFont(ofSize: 17)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionPageView {
            chooseNumber = indexPath.item
            collectionView.reloadData()
            self.collectionView.reloadData()
        }
    }
}

extension KanjiViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionPageView {
            return CGSize(width: 50, height: collectionView.frame.height)
        }
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 120)
        }
        else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        else if indexPath.section == 2 {
            return CGSize(width: collectionView.frame.width, height: 40)
        }
        else if indexPath.section == 6 || indexPath.section == 4 {
            return CGSize(width: collectionView.frame.width, height: 55)
        }
        else if indexPath.section == 8 {
            return CGSize(width: collectionView.frame.width, height: 125)
        }
        else if indexPath.section == 10 {
            return CGSize(width: collectionView.frame.width, height: 250)
        }
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionPageView {
            return 0
        }
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionPageView {
            return 0
        }
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionView {
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        return .zero
    }
}

