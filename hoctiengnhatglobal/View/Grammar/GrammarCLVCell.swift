//
//  GrammarCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/5/21.
//

import UIKit
import OSSSpeechKit

class GrammarCLVCell: UICollectionViewCell {
    @IBOutlet weak var labelTitleName: UILabel!
    @IBOutlet weak var labelJpnName: UILabel!
    @IBOutlet weak var labelEngName: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var speakerButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func setSpeaker() {
        let speechKit = OSSSpeech.shared
        // Set the voice you wish to use - currently upper case for formality or language and country name
        speechKit.voice = OSSVoice(quality: .enhanced, language: .Japanese)
        // Set the text in the language you have set
        speechKit.speakText(labelJpnName.text)
        setDisableButton()
    }
    
    func setDisableButton() {
        speakerButton.alpha = 0.5
        speakerButton.isUserInteractionEnabled = false
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(setEnableButton), userInfo: nil, repeats: false)
    }
    
    @objc func setEnableButton() {
        speakerButton.alpha = 1
        speakerButton.isUserInteractionEnabled = true
    }
}
