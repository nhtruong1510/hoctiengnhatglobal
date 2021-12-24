//
//  ContentQuizViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class ContentQuizViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextButton: UIButton!

    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resultAction() {
        isResult = true
        nextButton.isUserInteractionEnabled = true
        nextView.alpha = 1
        nextButton.alpha = 1
        resultView.backgroundColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        resultButton.setTitleColor(.white, for: .normal)
        QuizService.shared.updateDoHoanThanh(level: level, idDescription: idDescription)
        collectionView.reloadData()
    }
    
    @IBAction func nextAction() {
        if checkListDetail() {
            idDescription += 1
            listChooseAnswer.removeAll()
            collectionView.reloadData()
            isResult = false
        }
        else {
            dismiss(animated: true)
        }
    }
    
    var isResult = false
    var listDetail: [DetailQuiz] = [DetailQuiz]()
    var listChooseAnswer: [AnswerModel] = [AnswerModel]()
    var level = ""
    var nameChuong = ""
    var idDescription = 1
    var language: Language = .English
    var isGreenBg = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            collectionView.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            collectionView.backgroundColor = .clear
        }
        collectionView.layer.cornerRadius = 20
        labelName.text = "Quiz " + level
        nextView.layer.cornerRadius = 20
        nextView.layer.borderWidth = 1
        nextView.layer.borderColor = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        nextView.alpha = 0.5
        nextButton.alpha = 0.5
        nextButton.isUserInteractionEnabled = false
        resultView.layer.cornerRadius = 20
        resultView.layer.borderWidth = 1
        resultView.layer.borderColor = #colorLiteral(red: 0.9207936525, green: 0.4154287279, blue: 0.2274837196, alpha: 1)
        
        self.collectionView.register(UINib(nibName: "ContentCLVCell", bundle: nil), forCellWithReuseIdentifier: "ContentCLVCell")
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
        NotificationCenter.default.addObserver(self, selector: #selector(getListChooseAnswer(notification:)), name: NSNotification.Name("LOAD_CHOOSE_ANSWER"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func getListChooseAnswer(notification not: Notification) {
        let chooseAnswer = not.object as! AnswerModel
        var isDupplicate = false
        if listChooseAnswer.count > 0 {
            for item in 0...listChooseAnswer.count - 1 {
                if listChooseAnswer[item].location == chooseAnswer.location {
                    listChooseAnswer[item] = chooseAnswer
                    isDupplicate = true
                }
            }
        }
        if !isDupplicate {
            listChooseAnswer.append(chooseAnswer)
        }
        collectionView.reloadData()
    }
    
//    func getListCorrectAnswer() -> [Int]{
//        var listCorrectAnswer: [Int] = []
//        for item in getListDetail() {
//            if item.answer1 == item.correctAnswer {
//                listCorrectAnswer.append(0)
//            }
//            else if item.answer2 == item.correctAnswer {
//                listCorrectAnswer.append(1)
//            }
//            else if item.answer3 == item.correctAnswer {
//                listCorrectAnswer.append(2)
//            }
//            else if item.answer4 == item.correctAnswer {
//                listCorrectAnswer.append(3)
//            }
//        }
//        return listCorrectAnswer
//    }
    
    func getListDetail() -> [DetailQuiz]{
        var listDetail: [DetailQuiz] = [DetailQuiz]()
        for item in self.listDetail {
            if item.level == level && item.idDescription == idDescription {
                listDetail.append(item)
            }
        }
        return listDetail
    }
    
    func checkListDetail() -> Bool{
        for item in self.listDetail {
            if item.level == level && item.idDescription == idDescription {
                return true
            }
        }
        return false
    }
    
    func setupUIButton() {
        if listChooseAnswer.count == 4 {
            
        }
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

extension ContentQuizViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getListDetail().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCLVCell", for: indexPath) as! ContentCLVCell
        cell.labelName.text = String(indexPath.item + 1) + ". " + getListDetail()[indexPath.item].question
        cell.listDetail = getListDetail()[indexPath.item]
        for item in listChooseAnswer {
            if item.location == indexPath.item {
                cell.chooseAnswer = item.answer
                break
            }
        }
        cell.location = indexPath.item
        cell.isResulted = isResult
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension ContentQuizViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
