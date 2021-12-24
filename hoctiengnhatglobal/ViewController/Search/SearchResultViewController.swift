//
//  SearchResultViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    var listDetailN1: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN2: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN3: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN4: [DetailVocabulary] = [DetailVocabulary]()
    var listDetailN5: [DetailVocabulary] = [DetailVocabulary]()
    var listAllDetail: [DetailVocabulary] = [DetailVocabulary]()

    var language: Language = .English
    var searchText = ""
    var isGreenBg = false
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
        if language == .Vietnamese {
            labelName.text = "Kết quả cho " + "'" + searchText + "'"
        }
        else {
            labelName.text = "Result for " + "'" + searchText + "'"
        }
        self.collectionView.register(UINib(nibName: "VocabularyCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyCLVCell")
        collectionView.backgroundColor = .clear
        VocabularyN1Service.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetailN1 = repond
            }
        }
        VocabularyN2Service.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetailN2 = repond
            }
        }
        VocabularyN3Service.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetailN3 = repond
            }
        }
        VocabularyN4Service.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetailN4 = repond
            }
        }
        VocabularyN5Service.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetailN5 = repond
                self.collectionView.reloadData()
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
    }
    
    func getListDetail() -> [DetailVocabulary]{
        var listDetail: [DetailVocabulary] = [DetailVocabulary]()
        for item in self.listAllDetail {
            if language == .English {
                if item.nghiaENG.lowercased().contains(searchText.lowercased()) || item.kotoba.contains(searchText) {
                    listDetail.append(item)
                }
            }
            else if language == .Vietnamese {
                if item.nghiaVN.lowercased().contains(searchText.lowercased()) || item.kotoba.contains(searchText) {
                    listDetail.append(item)
                }
            }
            else if language == .Malay {
                if item.nghiaINDO.lowercased().contains(searchText.lowercased()) || item.kotoba.contains(searchText) {
                    listDetail.append(item)
                }
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

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listAllDetail.removeAll()
        listAllDetail = listDetailN1 + listDetailN2 + listDetailN3 + listDetailN4 + listDetailN5
        return getListDetail().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularyCLVCell", for: indexPath) as! VocabularyCLVCell
        if language == .English {
            cell.nghia.text = getListDetail()[indexPath.item].nghiaENG
            cell.nghiaViDu.text = getListDetail()[indexPath.item].nghiaViduENG
        }
        else if language == .Vietnamese {
            cell.nghia.text = getListDetail()[indexPath.item].nghiaVN
            cell.nghiaViDu.text = getListDetail()[indexPath.item].nghiaViduVN
        }
        else {
            cell.nghia.text = getListDetail()[indexPath.item].nghiaINDO
            cell.nghiaViDu.text = getListDetail()[indexPath.item].nghiaViduINDO
        }
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.phienAm.text = getListDetail()[indexPath.item].phienam
        cell.viDu.text = getListDetail()[indexPath.item].viduA
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.favouriteButton.isHidden = true
        cell.layer.cornerRadius = 15
        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/2 - 15, height: 150)
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

