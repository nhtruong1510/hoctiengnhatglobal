//
//  CommunicationHeaderVC.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/5/21.
//

import UIKit

class CommunicationHeaderVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var listHeader: [HeaderCommunication] = [HeaderCommunication]()
    var chuong = 0
    var nameChuong = ""
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
        labelName.text = nameChuong
        self.collectionView.register(UINib(nibName: "TestCLVCell", bundle: nil), forCellWithReuseIdentifier: "TestCLVCell")
        collectionView.backgroundColor = .clear
        CommunicationService.shared.getDataHeader(){ repond,error in
            if let repond = repond{
                self.listHeader = repond
                self.collectionView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func getListHeader() -> [HeaderCommunication]{
        var listHeader: [HeaderCommunication] = [HeaderCommunication]()
        for item in self.listHeader {
            if item.idChuong == chuong {
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

extension CommunicationHeaderVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getListHeader().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCLVCell", for: indexPath) as! TestCLVCell
        if language == .Vietnamese {
            cell.labelName.text = getListHeader()[indexPath.item].Description
        }
        else {
            cell.labelName.text = getListHeader()[indexPath.item].DescriptionEN
        }
        cell.labelName.textColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.layer.cornerRadius = 15
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommunicationViewController") as! CommunicationViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.chuong = chuong
        vc.name = name
        vc.language = language
        vc.isGreenBg = isGreenBg
        if language == .English {
            vc.nameChuong = getListHeader()[indexPath.item].DescriptionEN
        }
        else {
            vc.nameChuong = getListHeader()[indexPath.item].Description
        }
        vc.header = indexPath.item + 1
        self.present(vc, animated: true)
    }
}

extension CommunicationHeaderVC: UICollectionViewDelegateFlowLayout {
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
