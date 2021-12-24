//
//  VocabularyCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/4/21.
//

import UIKit
import OSSSpeechKit

class VocabularyCLVCell: UICollectionViewCell {
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var phienAm: UILabel!
    @IBOutlet weak var nghia: UILabel!
    @IBOutlet weak var viDu: UILabel!
    @IBOutlet weak var nghiaViDu: UILabel!
    @IBOutlet weak var labelNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewNumber.roundCorners([.topRight, .bottomRight], radius: 5)
        
        // Initialization code
    }

    @IBAction func setSpeaker() {
        let speechKit = OSSSpeech.shared
        // Set the voice you wish to use - currently upper case for formality or language and country name
        speechKit.voice = OSSVoice(quality: .enhanced, language: .Japanese)
        // Set the text in the language you have set
        speechKit.speakText(phienAm.text)
        setDisableButton()
    }
    
    func setDisableButton() {
        speakerButton.alpha = 0.5
        speakerButton.isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setEnableButton), userInfo: nil, repeats: false)
    }
    
    @objc func setEnableButton() {
        speakerButton.alpha = 1
        speakerButton.isUserInteractionEnabled = true
    }
}
