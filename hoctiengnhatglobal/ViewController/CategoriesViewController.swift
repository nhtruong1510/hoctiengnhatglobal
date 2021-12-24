//
//  CategoriesViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit
import SwiftKeychainWrapper

class CategoriesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!

    var listMenu: [MenuModel] = [MenuModel]()
    var language: Language = .English
    var isGreenBg = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CategoryCLVCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCLVCell")
        collectionView.backgroundColor = .clear
        listMenu = MenuData.shared.menu

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUIByKeychain()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupUIByKeychain() {
        if KeychainWrapper.standard.integer(forKey: "LANGUAGE") == nil || KeychainWrapper.standard.integer(forKey: "BACKGROUND") == nil {
            KeychainWrapper.standard.set(0, forKey: "LANGUAGE")
            KeychainWrapper.standard.set(false, forKey: "BACKGROUND")
        }
        let languageNumber = KeychainWrapper.standard.integer(forKey: "LANGUAGE")
        if languageNumber == 0 {
            language = .English
            labelTitle.text = "Categories"
        }
        else if languageNumber == 1 {
            language = .Vietnamese
            labelTitle.text = "Danh mục"
        }
        else {
            language = .Malay
            labelTitle.text = "Categories"
        }
        isGreenBg = KeychainWrapper.standard.bool(forKey: "BACKGROUND")!
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
        }
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCLVCell", for: indexPath) as! CategoryCLVCell
        if language == .Vietnamese {
            cell.labelName.text = listMenu[indexPath.item].textVN
        }
        else {
            cell.labelName.text = listMenu[indexPath.item].text
        }
        cell.imgView.image = listMenu[indexPath.item].image
        cell.layer.cornerRadius = 20
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "VocabularyNViewController") as! VocabularyNViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            if language == .Vietnamese {
                vc.name = listMenu[indexPath.item].textVN
            }
            else {
                vc.name = listMenu[indexPath.item].text
            }
            self.present(vc, animated: true)
        }
        else if indexPath.item == 2 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HiraganaViewController") as! HiraganaViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            self.present(vc, animated: true)
        }
        else if indexPath.item == 4 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CommunicationChuongVC") as! CommunicationChuongVC
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            if language == .Vietnamese {
                vc.name = listMenu[indexPath.item].textVN
            }
            else {
                vc.name = listMenu[indexPath.item].text
            }
            self.present(vc, animated: true)
        }
        else if indexPath.item == 3 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GrammarNViewController") as! GrammarNViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            if language == .Vietnamese {
                vc.name = listMenu[indexPath.item].textVN
            }
            else {
                vc.name = listMenu[indexPath.item].text
            }
            self.present(vc, animated: true)
        }
        else if indexPath.item == 5 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            self.present(vc, animated: true)
        }
        else if indexPath.item == 1 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "KanjiNViewController") as! KanjiNViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            self.present(vc, animated: true)
        }
        else if indexPath.item == 6 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            if language == .Vietnamese {
                vc.name = listMenu[indexPath.item].textVN
            }
            else {
                vc.name = listMenu[indexPath.item].text
            }
            self.present(vc, animated: true)
        }
        else if indexPath.item == 7 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BookmarkViewController") as! BookmarkViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            if language == .Vietnamese {
                vc.name = listMenu[indexPath.item].textVN
            }
            else {
                vc.name = listMenu[indexPath.item].text
            }
            self.present(vc, animated: true)
        }
        
        else if indexPath.item == 8 {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            vc.language = language
            vc.isGreenBg = isGreenBg
            vc.chooseLanguage = language.number
            if language == .Vietnamese {
                vc.name = listMenu[indexPath.item].textVN
            }
            else {
                vc.name = listMenu[indexPath.item].text
            }
            self.present(vc, animated: true)
            vc.didSendDataLanguage = { [weak self] language in
                    guard let self = self else { return }
                if language == 0 {
                    self.language = .English
                    self.labelTitle.text = "Categories"
                }
                else if language == 1 {
                    self.language = .Vietnamese
                    self.labelTitle.text = "Danh mục"
                }
                else if language == 2 {
                    self.language = .Malay
                    self.labelTitle.text = "Categories"
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/4 - 20, height: collectionView.frame.width/4 - 20)
        }
        return CGSize(width: collectionView.frame.width/2 - 15, height: collectionView.frame.width/2 - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
