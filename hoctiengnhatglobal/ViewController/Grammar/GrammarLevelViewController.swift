//
//  GrammarLevelViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/5/21.
//

import UIKit

class GrammarLevelViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listGrammar: [GrammarModel] = [GrammarModel]()
    var level = 0
    var language: Language = .English
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
        labelName.text = name + " N" + String(level + 1)
        self.collectionView.register(UINib(nibName: "VocabularySectionCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularySectionCLVCell")
        collectionView.backgroundColor = .clear
        GrammarService.shared.getDataGrammar(){ repond,error in
            if let repond = repond{
                self.listGrammar = repond
                self.collectionView.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func getListGrammar() -> [GrammarModel]{
        var listGrammar: [GrammarModel] = [GrammarModel]()
        for item in self.listGrammar {
            if item.level == level + 1 {
                listGrammar.append(item)
            }
        }
        return listGrammar
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

extension GrammarLevelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getListGrammar().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularySectionCLVCell", for: indexPath) as! VocabularySectionCLVCell
        if language == .English {
            cell.labelName.text = getListGrammar()[indexPath.item].mean
        }
        else if language == .Vietnamese {
            cell.labelName.text = getListGrammar()[indexPath.item].mean_vn
        }
        else {
            cell.labelName.text = getListGrammar()[indexPath.item].mean_indo
        }
        cell.labelJpnName.text = getListGrammar()[indexPath.item].titel
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.viewNumber.backgroundColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GrammarViewController") as! GrammarViewController
        vc.name = name
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.language = language
        vc.isGreenBg = isGreenBg
        let viDu1 = getListGrammar()[indexPath.item].vidu1_vn
        let viDu2 = getListGrammar()[indexPath.item].vidu2_vn
        let viDu3 = getListGrammar()[indexPath.item].vidu3_vn
        let viDu4 = getListGrammar()[indexPath.item].vidu4_vn

        if language == .English {
            vc.name = getListGrammar()[indexPath.item].mean
            if viDu1.components(separatedBy: .newlines).count > 2 {
                vc.viDu1 = viDu1.components(separatedBy: .newlines)[2]
            }
            if viDu2.components(separatedBy: .newlines).count > 2 {
                vc.viDu2 = viDu2.components(separatedBy: .newlines)[2]
            }
            if viDu3.components(separatedBy: .newlines).count > 2 {
                vc.viDu3 = viDu3.components(separatedBy: .newlines)[2]
            }
            if viDu4.components(separatedBy: .newlines).count > 2 {
                vc.viDu4 = viDu4.components(separatedBy: .newlines)[2]
            }
            vc.formation = getListGrammar()[indexPath.item].formation
        }
        else if language == .Vietnamese {
            vc.name = getListGrammar()[indexPath.item].mean_vn
            vc.formation = getListGrammar()[indexPath.item].formation_vn
            if viDu1.components(separatedBy: .newlines).count > 6 {
                vc.viDu1 = viDu1.components(separatedBy: .newlines)[6]
            }
            if viDu2.components(separatedBy: .newlines).count > 6 {
                vc.viDu2 = viDu2.components(separatedBy: .newlines)[6]
            }
            if viDu3.components(separatedBy: .newlines).count > 6 {
                vc.viDu3 = viDu3.components(separatedBy: .newlines)[6]
            }
            if viDu4.components(separatedBy: .newlines).count > 6 {
                vc.viDu4 = viDu4.components(separatedBy: .newlines)[6]
            }
        }
        else {
            vc.name = getListGrammar()[indexPath.item].mean_indo
            vc.formation = getListGrammar()[indexPath.item].formation_indo
            if viDu1.components(separatedBy: .newlines).count > 5 {
                vc.viDu1 = viDu1.components(separatedBy: .newlines)[5]
            }
            if viDu2.components(separatedBy: .newlines).count > 5 {
                vc.viDu2 = viDu2.components(separatedBy: .newlines)[5]
            }
            if viDu3.components(separatedBy: .newlines).count > 5 {
                vc.viDu3 = viDu3.components(separatedBy: .newlines)[5]
            }
            if viDu4.components(separatedBy: .newlines).count > 5 {
                vc.viDu4 = viDu4.components(separatedBy: .newlines)[5]
            }

        }
        vc.listGrammar = getListGrammar()[indexPath.item]
        self.present(vc, animated: true)
    }
}

extension GrammarLevelViewController: UICollectionViewDelegateFlowLayout {
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

