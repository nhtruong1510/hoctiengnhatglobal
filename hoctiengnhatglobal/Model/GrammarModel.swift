//
//  GrammarModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

class GrammarModel {
    var id: Int = 0
    var level: Int = 0
    var titel: String = ""
    var mean: String = ""
    var mean_indo: String = ""
    var mean_vn: String = ""
    var formation: String = ""
    var formation_indo: String = ""
    var formation_vn: String = ""
    var vidu1: String = ""
    var vidu2: String = ""
    var vidu3: String = ""
    var vidu4: String = ""
    var vidu1_vn: String = ""
    var vidu2_vn: String = ""
    var vidu3_vn: String = ""
    var vidu4_vn: String = ""
    
    init(id: Int, level: Int, titel: String, mean: String, mean_indo: String, mean_vn: String, formation: String, formation_indo: String, formation_vn: String, vidu1: String, vidu2: String, vidu3: String, vidu4: String, vidu1_vn: String, vidu2_vn: String, vidu3_vn: String, vidu4_vn: String){
        self.id = id
        self.level = level
        self.titel = titel
        self.mean_indo = mean_indo
        self.mean_vn = mean_vn
        self.mean = mean
        self.formation = formation
        self.formation_indo = formation_indo
        self.formation_vn = formation_vn
        self.vidu2 = vidu2
        self.vidu1 = vidu1
        self.vidu3 = vidu3
        self.vidu4 = vidu4
        self.vidu1_vn = vidu1_vn
        self.vidu2_vn = vidu2_vn
        self.vidu3_vn = vidu3_vn
        self.vidu4_vn = vidu4_vn
    }
}
