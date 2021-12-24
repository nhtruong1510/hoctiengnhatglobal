//
//  QuizViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    var percent: Float = 0.0
    var listLevel: [Level] = Level.allCases
    var level: Level = .N1
    var language: Language = .English
    var isGreenBg = false
    var listDetail: [DetailQuiz] = [DetailQuiz]()
    var listDetailN1: [DetailQuiz] = [DetailQuiz]()
    var listDetailN2: [DetailQuiz] = [DetailQuiz]()
    var listDetailN3: [DetailQuiz] = [DetailQuiz]()
    var listDetailN4: [DetailQuiz] = [DetailQuiz]()
    var listDetailN5: [DetailQuiz] = [DetailQuiz]()
    var listNewDetailN1: [DetailQuiz] = [DetailQuiz]()
    var listNewDetailN2: [DetailQuiz] = [DetailQuiz]()
    var listNewDetailN3: [DetailQuiz] = [DetailQuiz]()
    var listNewDetailN4: [DetailQuiz] = [DetailQuiz]()
    var listNewDetailN5: [DetailQuiz] = [DetailQuiz]()

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
        self.collectionView.register(UINib(nibName: "VocabularyNCLVCell", bundle: nil), forCellWithReuseIdentifier: "VocabularyNCLVCell")
        collectionView.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        QuizService.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetail = repond
                self.collectionView.reloadData()
                self.getListDetail()
                self.getListNewDetail()
            }
        }
    }
    
    func getListDetail(){
        listDetailN1.removeAll()
        listDetailN2.removeAll()
        listDetailN3.removeAll()
        listDetailN4.removeAll()
        listDetailN5.removeAll()

        for item in self.listDetail {
            if item.level == "N1" && item.doHoanThanh == 1 {
                listDetailN1.append(item)
            }
            if item.level == "N2" && item.doHoanThanh == 1 {
                listDetailN2.append(item)
            }
            if item.level == "N3" && item.doHoanThanh == 1 {
                listDetailN3.append(item)
            }
            if item.level == "N4" && item.doHoanThanh == 1{
                listDetailN4.append(item)
            }
            if item.level == "N5" && item.doHoanThanh == 1{
                listDetailN5.append(item)
            }
        }
    }
    
    func getListNewDetail(){
        listNewDetailN1.removeAll()
        listNewDetailN2.removeAll()
        listNewDetailN3.removeAll()
        listNewDetailN4.removeAll()
        listNewDetailN5.removeAll()

        for item in self.listDetail {
            if item.level == "N1" && item.doHoanThanh == 0 {
                listNewDetailN1.append(item)
            }
            if item.level == "N2" && item.doHoanThanh == 0 {
                listNewDetailN2.append(item)
            }
            if item.level == "N3" && item.doHoanThanh == 0 {
                listNewDetailN3.append(item)
            }
            if item.level == "N4" && item.doHoanThanh == 0{
                listNewDetailN4.append(item)
            }
            if item.level == "N5" && item.doHoanThanh == 0{
                listNewDetailN5.append(item)
            }
        }
    }
    
    
    
    func getListDetailN1() -> [DetailQuiz] {
        var listDetail: [DetailQuiz] = [DetailQuiz]()
        for item in self.listDetail {
            if item.level == "N1" {
                listDetail.append(item)
            }
        }
        return listDetail
    }
    
    func getListDetailN2() -> [DetailQuiz] {
        var listDetail: [DetailQuiz] = [DetailQuiz]()
        for item in self.listDetail {
            if item.level == "N2" {
                listDetail.append(item)
            }
        }
        return listDetail
    }
    
    func getListDetailN3() -> [DetailQuiz] {
        var listDetail: [DetailQuiz] = [DetailQuiz]()
        for item in self.listDetail {
            if item.level == "N3" {
                listDetail.append(item)
            }
        }
        return listDetail
    }
    
    func getListDetailN4() -> [DetailQuiz] {
        var listDetail: [DetailQuiz] = [DetailQuiz]()
        for item in self.listDetail {
            if item.level == "N4" {
                listDetail.append(item)
            }
        }
        return listDetail
    }
    
    func getListDetailN5() -> [DetailQuiz] {
        var listDetail: [DetailQuiz] = [DetailQuiz]()
        for item in self.listDetail {
            if item.level == "N5" {
                listDetail.append(item)
            }
        }
        return listDetail
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

extension QuizViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listLevel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocabularyNCLVCell", for: indexPath) as! VocabularyNCLVCell
        cell.labelName.text = "Quiz " + listLevel[indexPath.item].text
        let image = UIImage(named: "level_" + String(indexPath.item + 1))
        if indexPath.item == 0 {
            percent = Float(listDetailN1.count)/Float(getListDetailN1().count)
        }
        else if indexPath.item == 1 {
            percent = Float(listDetailN2.count)/Float(getListDetailN2().count)
        }
        else if indexPath.item == 2 {
            percent = Float(listDetailN3.count)/Float(getListDetailN3().count)
        }
        else if indexPath.item == 3 {
            percent = Float(listDetailN4.count)/Float(getListDetailN4().count)
        }
        else if indexPath.item == 4 {
            percent = Float(listDetailN5.count)/Float(getListDetailN5().count)
        }
        cell.progress.progress = Float(percent)
        cell.labelProgress.text = "You completed " + String(Int(percent*100)) + " %"
        cell.imgView.image = image
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func getIdDescription(index: Int) -> Int {
        if index == 0 {
            return updateIdDescription(index: index, listDetail: listNewDetailN1)
        }
        else if index == 1 {
            return updateIdDescription(index: index, listDetail: listNewDetailN2)
        }
        else if index == 2 {
            return updateIdDescription(index: index, listDetail: listNewDetailN3)
        }
        else if index == 3 {
            return updateIdDescription(index: index, listDetail: listNewDetailN4)
        }
        else {
            return updateIdDescription(index: index, listDetail: listNewDetailN5)
        }
    }
    
    func updateIdDescription(index: Int, listDetail: [DetailQuiz]) -> Int {
        var idDescription = 0
        for item in listDetail {
            if idDescription == 0 {
                idDescription = item.idDescription
                continue
            }
            if item.idDescription < idDescription {
                idDescription = item.idDescription
            }
        }
        return idDescription
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! VocabularyNCLVCell
        if cell.progress.progress != 1.0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContentQuizViewController") as! ContentQuizViewController
            vc.level = listLevel[indexPath.item].text
            vc.idDescription = getIdDescription(index: indexPath.item)
//            if indexPath.item == 0 {
//                vc.listDetail = listNewDetailN1
//            }
//            else if indexPath.item == 1 {
//                vc.listDetail = listNewDetailN2
//            }
//            else if indexPath.item == 2 {
//                vc.listDetail = listNewDetailN3
//            }
//            else if indexPath.item == 3 {
//                vc.listDetail = listNewDetailN4
//            }
//            else if indexPath.item == 4 {
//                vc.listDetail = listNewDetailN5
//            }
            vc.listDetail = listDetail
            vc.language = language
            vc.isGreenBg = isGreenBg
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(vc, animated: true)
        }
    }
}

extension QuizViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/2 - 15, height: 128)
        }
        return CGSize(width: collectionView.frame.width, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
