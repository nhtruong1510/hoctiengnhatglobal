//
//  KanjiService.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation
import SQLite

class KanjiService: NSObject {
    static let shared: KanjiService = KanjiService()
    var DatabaseRoot: Connection?
    var listDataKanji: [KanjiModel] = [KanjiModel]()
    var listDataHeader: [KanjiHeader] = [KanjiHeader]()
    var listDataHiragana: [HeaderHiragana] = [HeaderHiragana]()
    
    let hiragana = Expression<String?>("hiragana")
    let katakana = Expression<String?>("katakana")
    let phienam = Expression<String?>("phienam")
    let groupId = Expression<Int>("groupId")
    let completeK = Expression<Int>("completeK")
    
    let Kanji = Table("Kanji")
    let kanjiHeader = Table("KanjiHeader")
    let hiraganakatakana = Table("hiraganakatakana")
    
    let id = Expression<Int>("id")
    let level = Expression<Int>("level")
    let rank = Expression<Int>("rank")
    let namekanji = Expression<String>("namekanji")
    let kunyomi = Expression<String>("kunyomi")
    let onyomi = Expression<String>("onyomi")
    let radicals = Expression<String?>("radicals")
    let k_vidu1 = Expression<String?>("k_vidu1")
    let k_vidu2 = Expression<String?>("k_vidu2")
    let k_vidu3 = Expression<String?>("k_vidu3")
    let k_vidu4 = Expression<String?>("k_vidu4")
    let o_vidu1 = Expression<String?>("o_vidu1")
    let o_vidu2 = Expression<String?>("o_vidu2")
    let o_vidu3 = Expression<String?>("o_vidu3")
    let o_vidu4 = Expression<String?>("o_vidu4")
    let more1 = Expression<String?>("more1")
    let cauvidu1_jp = Expression<String?>("cauvidu1_jp")
    let cauvidu1_eng = Expression<String?>("cauvidu1_eng")
    let cauvidu1_vn = Expression<String?>("cauvidu1_vn")
    let cauvidu1_indo = Expression<String?>("cauvidu1_indo")
    let cauvidu2_jp = Expression<String?>("cauvidu2_jp")
    let cauvidu2_eng = Expression<String?>("cauvidu2_eng")
    let cauvidu2_vn = Expression<String?>("cauvidu2_vn")
    let cauvidu2_indo = Expression<String?>("cauvidu2_indo")
    let cauvidu3_jp = Expression<String?>("cauvidu3_jp")
    let cauvidu3_eng = Expression<String?>("cauvidu3_eng")
    let cauvidu3_vn = Expression<String?>("cauvidu3_vn")
    let cauvidu3_indo = Expression<String?>("cauvidu3_indo")
    let favourite = Expression<String>("favorite")

    let complete = Expression<Int>("complete")
    let desc = Expression<String>("desc")
    let locklesson = Expression<Int>("locklesson")
    
    func loadInit(linkPath: String){
        var dbPath : String = ""
        var dbResourcePath : String = ""
        
        let fileManager = FileManager.default
        do{
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("KANJI2020_30.sqlite")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "KANJI2020_30", ofType: "sqlite")!
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
    
    func getDataKanji(closure: @escaping (_ response: [KanjiModel]?, _ error: Error?) -> Void) {
        
        listDataKanji.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(Kanji) {
                    listDataKanji.append(KanjiModel(id: user[id], level: user[level], rank: user[rank], namekanji: user[namekanji], kunyomi: user[kunyomi], onyomi: user[onyomi], radicals: user[radicals] ?? "", k_vidu1: user[k_vidu1] ?? "", k_vidu2: user[k_vidu2] ?? "", k_vidu3: user[k_vidu3] ?? "", k_vidu4: user[k_vidu4] ?? "", o_vidu1: user[o_vidu1] ?? "", o_vidu2: user[o_vidu2] ?? "", o_vidu3: user[o_vidu3] ?? "", o_vidu4: user[o_vidu4] ?? "", more1: user[more1] ?? "", cauvidu1_jp: user[cauvidu1_jp] ?? "", cauvidu1_eng: user[cauvidu1_eng] ?? "", cauvidu1_vn: user[cauvidu1_vn] ?? "", cauvidu1_indo: user[cauvidu1_indo] ?? "", cauvidu2_jp: user[cauvidu2_jp] ?? "", cauvidu2_eng: user[cauvidu2_eng] ?? "", cauvidu2_vn: user[cauvidu2_vn] ?? "", cauvidu2_indo: user[cauvidu2_indo] ?? "", cauvidu3_jp: user[cauvidu3_jp] ?? "", cauvidu3_eng: user[cauvidu3_eng] ?? "", cauvidu3_vn: user[cauvidu3_vn] ?? "", cauvidu3_indo: user[cauvidu3_indo] ?? "", favourite: user[favourite]))
                }
            } catch  {
            }
        }
        closure(listDataKanji, nil)
        
    }
    
    func getDataHeader(closure: @escaping (_ response: [KanjiHeader]?, _ error: Error?) -> Void) {
        
        listDataHeader.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(kanjiHeader) {
                    listDataHeader.append(KanjiHeader(id: user[id], level: user[level], rank: user[rank], complete: user[complete], desc: user[desc], locklesson: user[locklesson]))
                }
            } catch  {
            }
        }
        closure(listDataHeader, nil)
        
    }
    
    func getDataHiragana(closure: @escaping (_ response: [HeaderHiragana]?, _ error: Error?) -> Void) {
        
        listDataHiragana.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(hiraganakatakana) {
                    listDataHiragana.append(HeaderHiragana(id: user[id], hiragana: user[hiragana] ?? "", katakana: user[katakana] ?? "", phienam: user[phienam] ?? "", groupId: user[groupId], complete: user[complete], completeK: user[completeK]))
                }
            } catch  {
            }
        }
        closure(listDataHiragana, nil)
        
    }
}
