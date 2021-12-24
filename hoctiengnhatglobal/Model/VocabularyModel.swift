//
//  VocabularyModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

class ChapterVocabulary {
    var id: Int = 0
    var IdChapter: Int = 0
    var desc: String = ""
    var desc2: String = ""
    var lock: Int = 0
    var FlagHoc: Int = 0
    
    init(id: Int, idChapter: Int, desc: String, desc2: String, lock: Int, flagHoc: Int){
        self.id = id
        self.IdChapter = idChapter
        self.desc = desc
        self.desc2 = desc2
        self.lock = lock
        self.FlagHoc = flagHoc
    }
}

class SectionVocabulary {
    var id: Int = 0
    var idChapter: Int = 0
    var desc: String = ""
    var desc2: String = ""
    var desc3: String = ""
    var desc4: String = ""
    var idSection: Int = 0
    var dohoanthanh: Int = 0
    var lock = 0
    
    init(id: Int, idChapter: Int, desc: String, desc2: String, desc3: String, desc4: String, lock: Int, doHoanThanh: Int){
        self.id = id
        self.idChapter = idChapter
        self.desc = desc
        self.desc2 = desc2
        self.desc3 = desc3
        self.desc4 = desc4
        self.lock = lock
        self.dohoanthanh = doHoanThanh
    }
}

class DetailVocabulary {
    var id: Int = 0
    var idSection: Int = 0
    var kotoba: String = ""
    var phienam: String = ""
    var nghiaENG: String = ""
    var nghiaVN: String = ""
    var nghiaINDO: String = ""
    var viduA: String = ""
    var ViduB: String = ""
    var nghiaViduENG: String = ""
    var nghiaViduVN: String = ""
    var nghiaViduINDO: String = ""
    var IdChapter: Int = 0
    var favourite: Int = 0
    var sound: String = ""
    var FlagHocTap: Int = 0
    init(id: Int, idSection: Int, kotoba: String, phienam: String, nghiaENG: String, nghiaVN: String, nghiaINDO: String, viduA: String, ViduB: String, nghiaViduENG: String, nghiaViduVN: String, nghiaViduINDO: String, IdChapter: Int, favourite: Int, sound: String, FlagHocTap: Int){
        self.id = id
        self.idSection = idSection
        self.kotoba = kotoba
        self.phienam = phienam
        self.nghiaENG = nghiaENG
        self.nghiaVN = nghiaVN
        self.nghiaINDO = nghiaINDO
        self.viduA = viduA
        self.ViduB = ViduB
        self.nghiaViduENG = nghiaViduENG
        self.nghiaViduVN = nghiaViduVN
        self.nghiaViduINDO = nghiaViduINDO
        self.IdChapter = IdChapter
        self.favourite = favourite
        self.sound = sound
        self.FlagHocTap = FlagHocTap
    }
}
