//
//  VocabularyViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class VocabularyChapterViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listSection: [SectionVocabulary] = [SectionVocabulary]()
    var listChapter: [ChapterVocabulary] = [ChapterVocabulary]()
    var level = 0
    var name = ""
    var language: Language = .English
    var isGreenBg = false
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
        labelName.text = name + " N" + String(level + 1)
        self.collectionView.register(UINib(nibName: "VocabularyChapterCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyChapterCLVCell")
        collectionView.backgroundColor = .clear
        switch level {
        case 0:
            VocabularyN1Service.shared.getDataChapter(){ repond,error in
                if let repond = repond{
                    self.listChapter = repond
                    self.collectionView.reloadData()
                }
            }
        case 1:
            VocabularyN2Service.shared.getDataChapter(){ repond,error in
                if let repond = repond{
                    self.listChapter = repond
                    self.collectionView.reloadData()
                }
            }
        case 2:
            VocabularyN3Service.shared.getDataChapter(){ repond,error in
                if let repond = repond{
                    self.listChapter = repond
                    self.collectionView.reloadData()
                }
            }
        case 3:
            VocabularyN4Service.shared.getDataChapter(){ repond,error in
                if let repond = repond{
                    self.listChapter = repond
                    self.collectionView.reloadData()
                }
            }
        default:
            VocabularyN5Service.shared.getDataChapter(){ repond,error in
                if let repond = repond{
                    self.listChapter = repond
                    self.collectionView.reloadData()
                }
            }
        }
        
//        let a = "Relationships Between People - Relationships Between People - Hubungan antara Orang dan Orang"
//        print(a.components(separatedBy: .punctuationCharacters).count)
        
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

}

extension VocabularyChapterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listChapter.count
    }
    
    func getDescChapter(index: Int) -> String {
        let text = listChapter[index].desc2
        let textArr = text.components(separatedBy: .punctuationCharacters)
        if textArr.count > 0 {
            if language == .English {
                 return textArr[0]
            }
            else if language == .Vietnamese {
                return textArr[1]
            }
            else {
                return textArr[2]
            }
        }
        return ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularyChapterCLVCell", for: indexPath) as! VocabularyChapterCLVCell
        cell.labelEng.text = getDescChapter(index: indexPath.item)
        cell.labelJpn.text = listChapter[indexPath.item].desc
        var image = UIImage(named: "n" + String(level + 1) + "_" + String(indexPath.item + 1))
        if level == 4 {
            image = UIImage(named: "ic_chapter" + String(indexPath.item + 1))
        }
        cell.imgView.image = image
        cell.layer.cornerRadius = 15
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VocabularySectionViewController") as! VocabularySectionViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.level = level
        vc.name = name
        vc.chapter = indexPath.item + 1
        vc.nameChapter = getDescChapter(index: indexPath.item)
        vc.language = language
        vc.isGreenBg = isGreenBg
        self.present(vc, animated: true)
    }
}

extension VocabularyChapterViewController: UICollectionViewDelegateFlowLayout {
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
