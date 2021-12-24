//
//  CommunicationModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

class ChuongCommunication {
    var id: Int = 0
    var Description: String = ""
    var Description2: String = ""
    var Desc3: String = ""
    var FlagHoc: Int = 0
    var lock = 0
    
    init(id: Int, Description: String, Description2: String, Desc3: String, FlagHoc: Int, lock: Int){
        self.id = id
        self.Description = Description
        self.Description2 = Description2
        self.Desc3 = Desc3
        self.lock = lock
        self.FlagHoc = FlagHoc
    }
}

class DetailCommunication {
    var id: Int = 0
    var idHeader: Int = 0
    var tiengNhat: String = ""
    var phienAm: String = ""
    var tiengAnh: String = ""
    var tiengViet: String = ""
    var idChuong: Int = 0
    var favourite: Int = 0
    var sound: String = ""
    var isDownload: Int = 0
    var raw: Int = 0
    init(id: Int, idHeader: Int, tiengNhat: String, phienAm: String, tiengAnh: String, tiengViet: String, idChuong: Int, favourite: Int, raw: Int, sound: String, isDownload: Int){
        self.id = id
        self.idHeader = idHeader
        self.tiengNhat = tiengNhat
        self.phienAm = phienAm
        self.tiengAnh = tiengAnh
        self.tiengViet = tiengViet
        self.idChuong = idChuong
        self.favourite = favourite
        self.raw = raw
        self.sound = sound
        self.isDownload = isDownload
    }
}

class HeaderCommunication {
    var id: Int = 0
    var idChuong: Int = 0
    var Description: String = ""
    var DescriptionEN: String = ""
    var idDetail: Int = 0
    var FlagHoc: Int = 0
    
    init(id: Int, idChuong: Int, Description: String, DescriptionEN: String, FlagHoc: Int, idDetail: Int){
        self.id = id
        self.Description = Description
        self.DescriptionEN = DescriptionEN
        self.idDetail = idDetail
        self.FlagHoc = FlagHoc
        self.idChuong = idChuong
    }
}
