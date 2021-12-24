//
//  Hiragana1CLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/4/21.
//

import UIKit

class Hiragana1CLVCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listHiragana: [HeaderHiragana] = [HeaderHiragana]()
    var isChooseHiragana = true
    
    override func awakeFromNib() {
        self.collectionView.register(UINib(nibName: "HiraganaCLVCell", bundle: nil), forCellWithReuseIdentifier: "HiraganaCLVCell")
        collectionView.backgroundColor = .clear
        super.awakeFromNib()
        // Initialization code
    }

}

extension Hiragana1CLVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listHiragana.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HiraganaCLVCell", for: indexPath) as! HiraganaCLVCell
        cell.labelName.text = listHiragana[indexPath.item].phienam
        if isChooseHiragana {
            cell.labelJpnName.text = listHiragana[indexPath.item].hiragana
            cell.contentView.backgroundColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        }
        else {
            cell.labelJpnName.text = listHiragana[indexPath.item].katakana
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        }
        cell.layer.cornerRadius = 15
        return cell
    }
}

extension Hiragana1CLVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/4 - 40, height: 56)
        }
        return CGSize(width: collectionView.frame.width/2 - 40, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
