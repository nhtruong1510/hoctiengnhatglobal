//
//  KanjiModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

class Kanji {
    var id: Int = 0
    var level: Int = 0
    var bai: Int = 0
    var tenKanji: String = ""
    var amhan: String = ""
    var text1: String = ""
    var text2: String = ""
    var text3: String = ""
    var text4: String = ""
    var text5: String = ""
    var favourite: Int = 0
    var dohoanthanh: Int = 0
    var flagHoc: Int = 0
    init(id: Int, level: Int, bai: Int, tenKanji: String, amhan: String, text1: String, text2: String, text3: String, text4: String, text5: String, favourite: Int, dohoanthanh: Int, flagHoc: Int){
        self.id = id
        self.level = level
        self.bai = bai
        self.tenKanji = tenKanji
        self.amhan = amhan
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.text4 = text4
        self.text5 = text5
        self.favourite = favourite
        self.dohoanthanh = dohoanthanh
        self.flagHoc = flagHoc
    }
}

class KanjiModel {
    var id: Int = 0
    var level: Int = 0
    var rank: Int = 0
    var namekanji: String = ""
    var kunyomi: String = ""
    var onyomi: String = ""
    var radicals: String = ""
    var k_vidu1: String = ""
    var k_vidu2: String = ""
    var k_vidu3: String = ""
    var k_vidu4: String = ""
    var o_vidu1: String = ""
    var o_vidu2: String = ""
    var o_vidu3: String = ""
    var o_vidu4: String = ""
    var more1: String = ""
    var cauvidu1_jp: String = ""
    var cauvidu1_eng: String = ""
    var cauvidu1_vn: String = ""
    var cauvidu1_indo: String = ""
    var cauvidu2_jp: String = ""
    var cauvidu2_eng: String = ""
    var cauvidu2_vn: String = ""
    var cauvidu2_indo: String = ""
    var cauvidu3_jp: String = ""
    var cauvidu3_eng: String = ""
    var cauvidu3_vn: String = ""
    var cauvidu3_indo: String = ""
    var favourite: String = ""
    init(id: Int, level: Int, rank: Int, namekanji: String, kunyomi: String, onyomi: String, radicals: String, k_vidu1: String, k_vidu2: String, k_vidu3: String, k_vidu4: String, o_vidu1: String, o_vidu2: String, o_vidu3: String, o_vidu4: String, more1: String, cauvidu1_jp: String, cauvidu1_eng: String, cauvidu1_vn: String, cauvidu1_indo: String, cauvidu2_jp: String, cauvidu2_eng: String, cauvidu2_vn: String, cauvidu2_indo: String, cauvidu3_jp: String, cauvidu3_eng: String, cauvidu3_vn: String, cauvidu3_indo: String, favourite: String){
        self.id = id
        self.level = level
        self.rank = rank
        self.namekanji = namekanji
        self.kunyomi = kunyomi
        self.onyomi = onyomi
        self.radicals = radicals
        self.k_vidu1 = k_vidu1
        self.k_vidu2 = k_vidu2
        self.k_vidu3 = k_vidu3
        self.k_vidu4 = k_vidu4
        self.o_vidu1 = o_vidu1
        self.o_vidu2 = o_vidu2
        self.o_vidu3 = o_vidu3
        self.o_vidu4 = o_vidu4
        self.more1 = more1
        self.cauvidu1_jp = cauvidu1_jp
        self.cauvidu1_eng = cauvidu1_eng
        self.cauvidu1_vn = cauvidu1_vn
        self.cauvidu1_indo = cauvidu1_indo
        self.cauvidu2_jp = cauvidu2_jp
        self.cauvidu2_eng = cauvidu2_eng
        self.cauvidu2_vn = cauvidu2_vn
        self.cauvidu2_indo = cauvidu2_indo
        self.cauvidu3_jp = cauvidu3_jp
        self.cauvidu3_eng = cauvidu3_eng
        self.cauvidu3_vn = cauvidu3_vn
        self.cauvidu3_indo = cauvidu3_indo
        self.favourite = favourite
    }
}

class KanjiHeader {
    var id: Int = 0
    var level: Int = 0
    var rank: Int = 0
    var complete: Int = 0
    var desc: String = ""
    var locklesson: Int = 0
    init(id: Int, level: Int, rank: Int, complete: Int, desc: String, locklesson: Int){
        self.id = id
        self.level = level
        self.rank = rank
        self.complete = complete
        self.desc = desc
        self.locklesson = locklesson
    }
}
