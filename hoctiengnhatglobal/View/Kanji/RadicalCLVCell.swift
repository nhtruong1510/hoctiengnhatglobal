//
//  RadicalCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/7/21.
//

import UIKit

class RadicalCLVCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var radicals = ""
    var language: Language = .English
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.backgroundColor = .clear
        self.collectionView.register(UINib(nibName: "ExampleCLVCell", bundle: nil), forCellWithReuseIdentifier: "ExampleCLVCell")
        collectionView.backgroundColor = .clear

        // Initialization code
    }
    
    func getListRadicals() -> [String] {
        var radicalArr = radicals.components(separatedBy: .newlines)
        var listEmpty: [Int] = []
        if radicalArr.count > 0 {
            for item in 0...radicalArr.count - 1 {
                if radicalArr[item] == "" {
                    listEmpty.append(item)
                }
            }
            for item in listEmpty.reversed() {
                radicalArr.remove(at: item)
            }
        }
        return radicalArr
    }

}

extension RadicalCLVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getListRadicals().count/4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCLVCell", for: indexPath) as! ExampleCLVCell
        
        if language == .English {
            if getListRadicals().count > indexPath.item*4 + 3{
                cell.labelName.text = getListRadicals()[indexPath.item*4 + 1]
            }
        }
        else if language == .Vietnamese {
            if getListRadicals().count > indexPath.item*4 + 3{
                cell.labelName.text = getListRadicals()[indexPath.item*4 + 2]
            }
        }
        else {
            if getListRadicals().count > indexPath.item*4 + 3{
                cell.labelName.text = getListRadicals()[indexPath.item*4 + 3]
            }
        }
        cell.labelJpn.text = getListRadicals()[indexPath.item*4]
        return cell
    }
}

extension RadicalCLVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 62, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
