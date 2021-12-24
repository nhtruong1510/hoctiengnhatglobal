//
//  VocabularySectionViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/4/21.
//

import UIKit

class VocabularySectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listSection: [SectionVocabulary] = [SectionVocabulary]()
    var chapter = 0
    var level = 0
    var nameChapter = ""
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
        labelName.text = "N" + String(level + 1) + " | " + nameChapter
        self.collectionView.register(UINib(nibName: "VocabularySectionCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularySectionCLVCell")
        collectionView.backgroundColor = .clear
        VocabularyN1Service.shared.getDataSection(){ repond,error in
            if let repond = repond{
                self.listSection = repond
                self.collectionView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func getListSection() -> [SectionVocabulary]{
        var listSection: [SectionVocabulary] = [SectionVocabulary]()
        for item in self.listSection {
            if item.idChapter == chapter {
                listSection.append(item)
            }
        }
        return listSection
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

extension VocabularySectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getListSection().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularySectionCLVCell", for: indexPath) as! VocabularySectionCLVCell
        if language == .English {
            cell.labelName.text = getListSection()[indexPath.item].desc2
        }
        else if language == .Vietnamese {
            cell.labelName.text = getListSection()[indexPath.item].desc3
        }
        else {
            cell.labelName.text = getListSection()[indexPath.item].desc4
        }
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.labelJpnName.text = getListSection()[indexPath.item].desc
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VocabularyViewController") as! VocabularyViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.level = level
        vc.chapter = chapter
        vc.name = name
        vc.section = indexPath.item + 1
        vc.nameSection = getListSection()[indexPath.item].desc
        vc.language = language
        vc.isGreenBg = isGreenBg
        self.present(vc, animated: true)
    }
}

extension VocabularySectionViewController: UICollectionViewDelegateFlowLayout {
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
