//
//  GrammarViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class GrammarViewController: UIViewController {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelJpnName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var name = ""
    var viDu1 = ""
    var viDu2 = ""
    var viDu3 = ""
    var viDu4 = ""
    var formation = ""
    var listGrammar: GrammarModel!
    var isGreenBg = false
    var language: Language = .English

    override func viewDidLoad() {
        super.viewDidLoad()
        labelJpnName.text = listGrammar.titel
        labelName.text = name
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
        }
        self.collectionView.register(UINib(nibName: "FormationCLVCell", bundle: nil), forCellWithReuseIdentifier: "FormationCLVCell")
        self.collectionView.register(UINib(nibName: "GrammarCLVCell", bundle: nil), forCellWithReuseIdentifier: "GrammarCLVCell")
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

extension GrammarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FormationCLVCell", for: indexPath) as! FormationCLVCell
            cell.labelName.text = formation
            cell.layer.cornerRadius = 15
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GrammarCLVCell", for: indexPath) as! GrammarCLVCell
        cell.labelTitleName.text = "Example " + String(indexPath.item + 1)
        if indexPath.item == 0 {
            cell.labelJpnName.text = listGrammar.vidu1
            cell.labelEngName.text = viDu1
            let phienAm = listGrammar.vidu1_vn.components(separatedBy: .newlines)
            if phienAm.count > 0{
                cell.labelJpnName.text = phienAm[0]
                cell.labelName.text = phienAm[4]
            }
            else {
                cell.labelJpnName.text = ""
                cell.labelName.text = ""
            }
        }
        else if indexPath.item == 1 {
            cell.labelEngName.text = viDu2
            let phienAm = listGrammar.vidu2_vn.components(separatedBy: .newlines)
            if phienAm.count > 0{
                cell.labelJpnName.text = phienAm[0]
                cell.labelName.text = phienAm[4]
            }
            else {
                cell.labelJpnName.text = ""
                cell.labelName.text = ""
            }
        }
        else if indexPath.item == 2 {
            cell.labelEngName.text = viDu3
            let phienAm = listGrammar.vidu3_vn.components(separatedBy: .newlines)
            if phienAm.count > 0{
                cell.labelJpnName.text = phienAm[0]
                cell.labelName.text = phienAm[4]
            }
            else {
                cell.labelJpnName.text = ""
                cell.labelName.text = ""
            }
        }
        else {
            cell.labelEngName.text = viDu4
            let phienAm = listGrammar.vidu4_vn.components(separatedBy: .newlines)
            if phienAm.count > 0{
                cell.labelJpnName.text = phienAm[0]
                cell.labelName.text = phienAm[4]
            }
            else {
                cell.labelJpnName.text = ""
                cell.labelName.text = ""
            }
        }
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.layer.cornerRadius = 15
        return cell
    }
}

extension GrammarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return CGSize(width: collectionView.frame.width/2 - 15, height: 80)
            }
            return CGSize(width: collectionView.frame.width, height: 80)
        }
        else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return CGSize(width: collectionView.frame.width/2 - 15, height: 200)
            }
            return CGSize(width: collectionView.frame.width, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
    }
}

