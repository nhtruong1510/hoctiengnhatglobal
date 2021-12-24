//
//  Onyomi2CLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/7/21.
//

import UIKit

class Onyomi2CLVCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var language: Language = .English
    var listOnyomi: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.backgroundColor = .clear
        self.collectionView.register(UINib(nibName: "OnyomiCLVCell", bundle: nil), forCellWithReuseIdentifier: "OnyomiCLVCell")
        collectionView.backgroundColor = .clear

        // Initialization code
    }

}

extension Onyomi2CLVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOnyomi.count/2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnyomiCLVCell", for: indexPath) as! OnyomiCLVCell
        if listOnyomi.count > 0 {
            let numberOfItems = listOnyomi.count/2
            cell.labelJpn.text = listOnyomi[indexPath.item * numberOfItems]
            cell.labelName.text = listOnyomi[4 + indexPath.item*4]

            //cell.layer.cornerRadius = 15
        }
        return cell
    }
}

extension Onyomi2CLVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
