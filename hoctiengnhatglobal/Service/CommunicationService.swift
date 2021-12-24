//
//  CommunicationService.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit
import SQLite

class CommunicationService: NSObject {
    static let shared: CommunicationService = CommunicationService()
    var DatabaseRoot: Connection?
    var listDataChuong: [ChuongCommunication] = [ChuongCommunication]()
    var listDataHeader: [HeaderCommunication] = [HeaderCommunication]()
    var listDataDetail: [DetailCommunication] = [DetailCommunication]()
    let Chuong = Table("Chuong")
    let Header = Table("Header")
    let Detail = Table("Detail")
    let id = Expression<Int>("id")
    let lock = Expression<Int>("lock")
    let FlagHoc = Expression<Int>("FlagHoc")
    let Description = Expression<String>("Description")
    let Description2 = Expression<String>("Description2")
    let Desc3 = Expression<String>("Desc3")

    let DescriptionEN = Expression<String>("DescriptionEN")
    let idChuong = Expression<Int>("idChuong")
    let idDetail = Expression<Int>("idDetail")
    
    let idHeader = Expression<Int>("idHeader")
    let phienAm = Expression<String>("phienAm")
    let tiengAnh = Expression<String>("tiengAnh")
    let tiengViet = Expression<String>("tiengViet")
    let nghiaINDO = Expression<String>("nghiaINDO")
    let tiengNhat = Expression<String>("tiengNhat")
    let favourite = Expression<Int>("favorite")
    let raw = Expression<Int>("raw")
    let sound = Expression<String>("sound")
    let isDownload = Expression<Int>("isDownload")
    
    func loadInit(linkPath: String){
        var dbPath : String = ""
        var dbResourcePath : String = ""
        
        let fileManager = FileManager.default
        do{
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("Kaiwa13.sqlite")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "Kaiwa13", ofType: "sqlite")!
                try fileManager.copyItem(atPath: dbResourcePath, toPath: dbPath)
            }
        }catch{
            print("An error has occured")
        }
        do {
            self.DatabaseRoot = try Connection (dbPath)
        } catch {
            print(error)
        }
    }
    
    func getDataChuong(closure: @escaping (_ response: [ChuongCommunication]?, _ error: Error?) -> Void) {
        
        listDataChuong.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(Chuong) {
                    listDataChuong.append(ChuongCommunication(id: user[id], Description: user[Description], Description2: user[Description2], Desc3: user[Desc3], FlagHoc: user[FlagHoc], lock: user[lock]))
                }
            } catch  {
            }
        }
        closure(listDataChuong, nil)
        
    }
    
    func getDataHeader(closure: @escaping (_ response: [HeaderCommunication]?, _ error: Error?) -> Void) {
        
        listDataHeader.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(Header) {
                    listDataHeader.append(HeaderCommunication(id: user[id], idChuong: user[idChuong], Description: user[Description], DescriptionEN: user[DescriptionEN], FlagHoc: user[FlagHoc], idDetail: user[idDetail]))
                }
            } catch  {
            }
        }
        closure(listDataHeader, nil)
        
    }

    func getDataDetail(closure: @escaping (_ response: [DetailCommunication]?, _ error: Error?) -> Void) {
        
        listDataDetail.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(Detail) {
                    listDataDetail.append(DetailCommunication(id: user[id], idHeader: user[idHeader], tiengNhat: user[tiengNhat], phienAm: user[phienAm], tiengAnh: user[tiengAnh], tiengViet: user[tiengViet], idChuong: user[idChuong], favourite: user[favourite], raw: user[raw], sound: user[sound], isDownload: user[isDownload]))
                }
            } catch  {
            }
        }
        closure(listDataDetail, nil)
        
    }
}
