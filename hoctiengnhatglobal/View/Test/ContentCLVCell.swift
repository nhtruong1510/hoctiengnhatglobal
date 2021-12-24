//
//  ContentCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/5/21.
//

import UIKit

class ContentCLVCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var listDetail: DetailQuiz!
    var location = -1
    var chooseAnswer = -1
    var isChoose = false
    var isResulted = false
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(UINib(nibName: "Content2CLVCell", bundle: nil), forCellWithReuseIdentifier: "Content2CLVCell")
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        // Initialization code
    }
}

extension ContentCLVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func getTrueAnswer()->Int {
        if listDetail.answer1 == listDetail.correctAnswer {
            return 0
        }
        else if listDetail.answer1 == listDetail.correctAnswer {
            return 1
        }
        else if listDetail.answer1 == listDetail.correctAnswer {
            return 2
        }
        else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Content2CLVCell", for: indexPath) as! Content2CLVCell
        if chooseAnswer == indexPath.item {
            chooseAnswer = -1
            cell.imgView.image = #imageLiteral(resourceName: "tick")
            cell.labelName.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
        else {
            cell.imgView.image = #imageLiteral(resourceName: "unticked")
            cell.labelName.textColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        }
        if isResulted {
            if getTrueAnswer() == indexPath.item {
                cell.labelName.textColor = .red
            }
        }
        if indexPath.item == 0 {
            cell.labelName.text = listDetail.answer1
        }
        else if indexPath.item == 1 {
            cell.labelName.text = listDetail.answer2

        }
        else if indexPath.item == 2 {
            cell.labelName.text = listDetail.answer3
        }
        else {
            cell.labelName.text = listDetail.answer4
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        chooseAnswer = indexPath.item
//        let cell = collectionView.cellForItem(at: indexPath) as! Content2CLVCell
//
//        collectionView.reloadData()
//        if !isChoose {
        NotificationCenter.default.post(name: Notification.Name("LOAD_CHOOSE_ANSWER"), object: AnswerModel(answer: indexPath.item, location: location))
//
//            isChoose = true
//        }
        
    }
}

extension ContentCLVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 21)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
