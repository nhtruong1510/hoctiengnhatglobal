//
//  BookmarkViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/8/21.
//

import UIKit

class BookmarkViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listDetailN1: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN2: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN3: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN4: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN5: [DetailVocabulary] = [DetailVocabulary]()
    var listAllDetail: [DetailVocabulary] = [DetailVocabulary]()
    var section = 0
    var chapter = 0
    var level = 0
    var nameSection = ""
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
        labelName.text = name
        self.collectionView.register(UINib(nibName: "VocabularyCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyCLVCell")
        collectionView.backgroundColor = .clear
        switch level {
        case 0:
            VocabularyN1Service.shared.getDataDetail(){ repond,error in
                if let repond = repond{
                    self.listDetailN1 = repond
                    self.collectionView.reloadData()
                }
            }
        case 1:
            VocabularyN2Service.shared.getDataDetail(){ repond,error in
                if let repond = repond{
                    self.listDetailN2 = repond
                    self.collectionView.reloadData()
                }
            }
        case 2:
            VocabularyN3Service.shared.getDataDetail(){ repond,error in
                if let repond = repond{
                    self.listDetailN3 = repond
                    self.collectionView.reloadData()
                }
            }
        case 3:
            VocabularyN4Service.shared.getDataDetail(){ repond,error in
                if let repond = repond{
                    self.listDetailN4 = repond
                    self.collectionView.reloadData()
                }
            }
        default:
            VocabularyN5Service.shared.getDataDetail(){ repond,error in
                if let repond = repond{
                    self.listDetailN5 = repond
                    self.collectionView.reloadData()
                }
            }
        }
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

        // Do any additional setup after loading the view.
    }
    
    func getListFavorite() -> [DetailVocabulary]{
        var listDetail: [DetailVocabulary] = [DetailVocabulary]()
        for item in self.listAllDetail {
            if item.favourite == 1 {
                listDetail.append(item)
            }
        }
        return listDetail
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

extension BookmarkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listAllDetail.removeAll()
        listAllDetail = listDetailN1 + listDetailN2 + listDetailN3 + listDetailN4 + listDetailN5
        return getListFavorite().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularyCLVCell", for: indexPath) as! VocabularyCLVCell
        if language == .English {
            cell.nghia.text = getListFavorite()[indexPath.item].nghiaENG
            cell.nghiaViDu.text = getListFavorite()[indexPath.item].nghiaViduENG
        }
        else if language == .Vietnamese {
            cell.nghia.text = getListFavorite()[indexPath.item].nghiaVN
            cell.nghiaViDu.text = getListFavorite()[indexPath.item].nghiaViduVN
        }
        else {
            cell.nghia.text = getListFavorite()[indexPath.item].nghiaINDO
            cell.nghiaViDu.text = getListFavorite()[indexPath.item].nghiaViduINDO
        }
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.phienAm.text = getListFavorite()[indexPath.item].phienam
        cell.viDu.text = getListFavorite()[indexPath.item].viduA
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.layer.cornerRadius = 15
        cell.favouriteButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        cell.favouriteButton.isUserInteractionEnabled = false
        return cell
    }
}

extension BookmarkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/2 - 20, height: 150)
        }
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
