//
//  GrammarService.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation
import SQLite

class GrammarService: NSObject {
    static let shared: GrammarService = GrammarService()
    var DatabaseRoot: Connection?
    var listDataGrammar: [GrammarModel] = [GrammarModel]()
    let grammar = Table("NguPhap")
    let titel = Expression<String>("titel")
    let mean = Expression<String>("mean")
    let mean_indo = Expression<String>("mean_indo")
    let mean_vn = Expression<String>("mean_vn")
    let formation = Expression<String>("formation")
    let formation_indo = Expression<String>("formation_indo")
    let formation_vn = Expression<String>("formation_vn")
    let vidu1 = Expression<String>("vidu1")
    let vidu2 = Expression<String>("vidu2")
    let vidu3 = Expression<String>("vidu3")
    let vidu4 = Expression<String>("vidu4")
    let vidu1_vn = Expression<String>("vidu1_vn")
    let vidu2_vn = Expression<String>("vidu2_vn")
    let vidu3_vn = Expression<String>("vidu3_vn")
    let vidu4_vn = Expression<String>("vidu4_vn")
    let id = Expression<Int>("id")
    let level = Expression<Int>("level")
    
    func loadInit(linkPath: String){
        var dbPath : String = ""
        var dbResourcePath : String = ""
        
        let fileManager = FileManager.default
        do{
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("NguPhapTiengNhat_7.sqlite")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "NguPhapTiengNhat_7", ofType: "sqlite")!
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
    
    func getDataGrammar(closure: @escaping (_ response: [GrammarModel]?, _ error: Error?) -> Void) {
        
        listDataGrammar.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(grammar) {
                    listDataGrammar.append(GrammarModel(id: user[id], level: user[level], titel: user[titel], mean: user[mean], mean_indo: user[mean_indo], mean_vn: user[mean_vn], formation: user[formation], formation_indo: user[formation_indo], formation_vn: user[formation_vn], vidu1: user[vidu1], vidu2: user[vidu2], vidu3: user[vidu3], vidu4: user[vidu4], vidu1_vn: user[vidu1_vn], vidu2_vn: user[vidu2_vn], vidu3_vn: user[vidu3_vn], vidu4_vn: user[vidu4_vn]))
                }
            } catch  {
            }
        }
        closure(listDataGrammar, nil)
        
    }
}
