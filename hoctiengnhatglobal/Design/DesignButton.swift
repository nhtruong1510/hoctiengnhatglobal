//
//  DesignButton.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/7/21.
//

import UIKit

class DesignButton: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        UIButton.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.identity
        })
        super.touchesBegan(touches, with: event)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
