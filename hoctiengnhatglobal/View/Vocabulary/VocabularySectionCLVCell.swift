//
//  VocabularySectionCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/4/21.
//

import UIKit

class VocabularySectionCLVCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelJpnName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var viewNumber: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewNumber.roundCorners([.topRight, .bottomRight], radius: 5)
        // Initialization code
    }

}
