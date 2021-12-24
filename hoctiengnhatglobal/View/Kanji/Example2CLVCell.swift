//
//  Example2CLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/7/21.
//

import UIKit

class Example2CLVCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var listExample: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.backgroundColor = .clear
        self.collectionView.register(UINib(nibName: "ExampleCLVCell", bundle: nil), forCellWithReuseIdentifier: "ExampleCLVCell")
        collectionView.backgroundColor = .clear

        // Initialization code
    }

}

extension Example2CLVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listExample.count/2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCLVCell", for: indexPath) as! ExampleCLVCell
        cell.labelName.text = listExample[indexPath.item*2]
        cell.labelJpn.text = listExample[indexPath.item*2 + 1]
        //cell.contentView.backgroundColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        //cell.layer.cornerRadius = 15
        return cell
    }
}

extension Example2CLVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
