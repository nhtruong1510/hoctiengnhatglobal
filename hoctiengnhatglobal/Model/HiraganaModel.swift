//
//  HiraganaModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

class HeaderHiragana {
    var id: Int = 0
    var hiragana: String = ""
    var katakana: String = ""
    var phienam: String = ""
    var groupId: Int = 0
    var complete: Int = 0
    var completeK: Int = 0
    init(id: Int, hiragana: String, katakana: String, phienam: String, groupId: Int, complete: Int, completeK: Int){
        self.id = id
        self.hiragana = hiragana
        self.katakana = katakana
        self.phienam = phienam
        self.groupId = groupId
        self.complete = complete
        self.completeK = completeK
    }
}

