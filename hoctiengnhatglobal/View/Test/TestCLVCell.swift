//
//  TestCLVCell.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/5/21.
//

import UIKit

class TestCLVCell: UICollectionViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var viewNumber: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewNumber.roundCorners([.topRight, .bottomRight], radius: 5)

        // Initialization code
    }

}
