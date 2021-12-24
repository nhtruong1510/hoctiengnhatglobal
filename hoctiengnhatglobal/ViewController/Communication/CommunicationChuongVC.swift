//
//  CommunicationViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class CommunicationChuongVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    var isGreenBg = false
    var listChuong: [ChuongCommunication] = [ChuongCommunication]()
    var chapter = 0
    var level = 0
    var nameChapter = ""
    var language: Language = .English
    var name = ""
    
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
        labelName.text = name
        self.collectionView.register(UINib(nibName: "VocabularyChapterCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyChapterCLVCell")

        collectionView.backgroundColor = .clear
        CommunicationService.shared.getDataChuong(){ repond,error in
            if let repond = repond{
                self.listChuong = repond
                self.collectionView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
//    func getListSection() -> [SectionVocabulary]{
//        var listSection: [SectionVocabulary] = [SectionVocabulary]()
//        for item in self.listSection {
//            if item.idChapter == chapter {
//                listSection.append(item)
//            }
//        }
//        return listSection
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

extension CommunicationChuongVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listChuong.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularyChapterCLVCell", for: indexPath) as! VocabularyChapterCLVCell
        if language == .Vietnamese {
            cell.labelEng.text = listChuong[indexPath.item].Description
        }
        else {
            cell.labelEng.text = listChuong[indexPath.item].Desc3
        }
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.labelJpn.text = listChuong[indexPath.item].Description2
        var image = UIImage(named: "n" + String(level + 1) + "_" + String(indexPath.item + 1))
        if indexPath.item > 13 {
            image = UIImage(named: "n" + String(level + 2) + "_" + String(indexPath.item + 1 - 13))
        }
        cell.imgView.image = image
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommunicationHeaderVC") as! CommunicationHeaderVC
        vc.name = name
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        if language == .Vietnamese {
            vc.nameChuong = listChuong[indexPath.item].Description
        }
        else {
            vc.nameChuong = listChuong[indexPath.item].Desc3
        }
        vc.language = language
        vc.isGreenBg = isGreenBg
        vc.chuong = indexPath.item + 1
        self.present(vc, animated: true)
    }
}

extension CommunicationChuongVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/2 - 15, height: 52)
        }
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
