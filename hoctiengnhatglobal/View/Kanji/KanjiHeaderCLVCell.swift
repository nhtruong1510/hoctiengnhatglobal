//
//  KanjiHeaderCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/6/21.
//

import UIKit

class KanjiHeaderCLVCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelProgress: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var progress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewNumber.roundCorners([.topRight, .bottomRight], radius: 5)

        // Initialization code
    }

}
