//
//  KanjiHeaderViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/6/21.
//

import UIKit

class KanjiHeaderViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listHeader: [KanjiHeader] = [KanjiHeader]()
    var rank = 0
    var level = 0
    var nameChapter = ""
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
        labelName.text = "Kanji " + "N" + String(level + 1)
        self.collectionView.register(UINib(nibName: "TestCLVCell", bundle: nil), forCellWithReuseIdentifier: "TestCLVCell")
        collectionView.backgroundColor = .clear
        KanjiService.shared.getDataHeader() { repond,error in
            if let repond = repond{
                self.listHeader = repond
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
        // Do any additional setup after loading the view.
    }
    
    func getListHeader() -> [KanjiHeader]{
        var listHeader: [KanjiHeader] = [KanjiHeader]()
        for item in self.listHeader {
            if item.level == level + 1 {
                listHeader.append(item)
            }
        }
        return listHeader
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

extension KanjiHeaderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getListHeader().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCLVCell", for: indexPath) as! TestCLVCell
        cell.labelName.text = getListHeader()[indexPath.item].desc
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.viewNumber.backgroundColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        cell.labelName.textColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KanjiViewController") as! KanjiViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.language = language
        vc.isGreenBg = isGreenBg
        vc.level = level
        vc.rank = indexPath.item + 1
        vc.nameSection = getListHeader()[indexPath.item].desc
        self.present(vc, animated: true)
    }
}

extension KanjiHeaderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/2 - 20, height: 55)
        }
        return CGSize(width: collectionView.frame.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
