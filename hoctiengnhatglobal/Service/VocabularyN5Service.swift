//
//  VocabularyN5Service.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import UIKit
import SQLite

class VocabularyN5Service: NSObject {
    static let shared: VocabularyN5Service = VocabularyN5Service()
    var DatabaseRoot: Connection?
    var listDataChapter: [ChapterVocabulary] = [ChapterVocabulary]()
    var listDataSection: [SectionVocabulary] = [SectionVocabulary]()
    var listDataDetail: [DetailVocabulary] = [DetailVocabulary]()
    let chapter = Table("Chapter")
    let section = Table("Section")
    let detail = Table("SectionDetail")
    let id = Expression<Int>("id")
    let idSection = Expression<Int>("idSection")
    let idChapter = Expression<Int>("idChapter")
    let IdChapter = Expression<Int>("IdChapter")
    let lock = Expression<Int>("lock")
    let FlagHoc = Expression<Int>("FlagHoc")
    let Desc = Expression<String>("Desc")
    let Desc2 = Expression<String>("Desc2")
    let Desc3 = Expression<String>("Desc3")
    let Desc4 = Expression<String>("Desc4")
    let dohoanthanh = Expression<Int>("dohoanthanh")
    
    let kotoba = Expression<String?>("kotoba")
    let phienam = Expression<String?>("phienam")
    let nghiaENG = Expression<String?>("nghiaENG")
    let nghiaVN = Expression<String?>("nghiaVN")
    let nghiaINDO = Expression<String?>("nghiaINDO")
    let viduA = Expression<String?>("viduA")
    let ViduB = Expression<String?>("ViduB")
    let nghiaViduENG = Expression<String?>("nghiaViduENG")
    let nghiaViduVN = Expression<String?>("nghiaViduVN")
    let nghiaViduINDO = Expression<String?>("nghiaViduINDO")
    let favourite = Expression<Int>("favorite")
    let sound = Expression<String?>("sound")
    let FlagHocTap = Expression<Int>("FlagHocTap")
    
    func loadInit(linkPath:String){
        var dbPath : String = ""
        var dbResourcePath : String = ""
        
        let fileManager = FileManager.default
        do{
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("TuVungJLPTN5_19.sqlite")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "TuVungJLPTN5_19", ofType: "sqlite")!
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
    
    func getDataChapter(closure: @escaping (_ response: [ChapterVocabulary]?, _ error: Error?) -> Void) {
        
        listDataChapter.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(chapter) {
                    listDataChapter.append(ChapterVocabulary(id: user[id], idChapter: user[IdChapter], desc: user[Desc], desc2: user[Desc2], lock: user[lock], flagHoc: user[FlagHoc]))
                }
            } catch  {
            }
        }
        closure(listDataChapter, nil)
        
    }
    
    func getDataSection(closure: @escaping (_ response: [SectionVocabulary]?, _ error: Error?) -> Void) {
        
        listDataSection.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(section) {
                    listDataSection.append(SectionVocabulary(id: user[id], idChapter: user[idChapter], desc: user[Desc], desc2: user[Desc2], desc3: user[Desc3], desc4: user[Desc4], lock: user[lock], doHoanThanh: user[dohoanthanh]))
                }
            } catch  {
            }
        }
        closure(listDataSection, nil)
        
    }

    func getDataDetail(closure: @escaping (_ response: [DetailVocabulary]?, _ error: Error?) -> Void) {
        
        listDataDetail.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(detail) {
                    listDataDetail.append(DetailVocabulary(id: user[id], idSection: user[idSection], kotoba: user[kotoba] ?? "", phienam: user[phienam] ?? "", nghiaENG: user[nghiaENG] ?? "", nghiaVN: user[nghiaVN] ?? "", nghiaINDO: user[nghiaINDO] ?? "", viduA: user[viduA] ?? "", ViduB: user[ViduB] ?? "", nghiaViduENG: user[nghiaViduENG] ?? "", nghiaViduVN: user[nghiaViduVN] ?? "", nghiaViduINDO: user[nghiaViduINDO] ?? "", IdChapter: user[IdChapter], favourite: user[favourite], sound: user[sound] ?? "", FlagHocTap: user[FlagHocTap]))
                }
            } catch  {
            }
        }
        closure(listDataDetail, nil)
        
    }
    
    func updateVocabFavourite(id: Int, idSection: Int, idChapter: Int){
        for item in self.listDataDetail {
            if item.id == id && item.idSection == idSection && item.IdChapter == idChapter {
                item.favourite = 1
            }
        }
        let userFilter = detail.filter(self.id == id && self.idSection == idSection && self.IdChapter == idChapter)
        do{
            let update = userFilter.update(self.favourite <- 1)
            try DatabaseRoot!.run(update)
        } catch{
            print("Update failed: \(error)")
        }
    }
    
    func deleteVocabFavourite(id: Int, idSection: Int, idChapter: Int){
        for item in self.listDataDetail {
            if item.id == id && item.idSection == idSection && item.IdChapter == idChapter {
                item.favourite = 0
            }
        }
        let userFilter = detail.filter(self.id == id && self.idSection == idSection && self.IdChapter == idChapter)
        do{
            let update = userFilter.update(self.favourite <- 0)
            try DatabaseRoot!.run(update)
        } catch{
            print("Update failed: \(error)")
        }
    }
    
    func checkVocabFavourite(id: Int, idSection: Int, idChapter: Int) -> Bool{
        for item in self.listDataDetail {
            if item.id == id && item.idSection == idSection && item.IdChapter == idChapter {
                if item.favourite == 0 {
                    return false
                }
                break
            }
        }
        return true
    }
}


