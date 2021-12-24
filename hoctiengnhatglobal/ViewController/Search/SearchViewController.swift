//
//  SearchViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var labelTitle: UILabel!

    var language: Language = .English
    var isGreenBg = false
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelTitle.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
        }
        searchTextField.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        searchView.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        searchView.layer.cornerRadius = 10
        searchTextField.layer.cornerRadius = 10
        let color = #colorLiteral(red: 0.5056958199, green: 0.7601905465, blue: 0.7331368327, alpha: 1)
        let placeholder = searchTextField.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveToResultScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.searchText = searchTextField.text ?? ""
        vc.name = name
        vc.language = language
        vc.isGreenBg = isGreenBg
        self.present(vc, animated: true)
    }
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
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
