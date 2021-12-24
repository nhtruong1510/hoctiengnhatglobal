//
//  QuizService.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation
import SQLite

class QuizService: NSObject {
    static let shared: QuizService = QuizService()
    var DatabaseRoot: Connection?
    var listDataDetail: [DetailQuiz] = [DetailQuiz]()
    var listDataHeader: [HeaderQuiz] = [HeaderQuiz]()
    let Detail = Table("Detail")
    let Header = Table("Header")
    let Description = Expression<String>("description")
    let idDescription = Expression<Int>("idDescription")
    let division = Expression<Int>("division")
    var answer1 = Expression<String>("answer1")
    var answer2 = Expression<String>("answer2")
    var answer3 = Expression<String>("answer3")
    var answer4 = Expression<String>("answer4")
    var correctAnswer = Expression<String>("correctAnswer")
    let id = Expression<Int>("id")
    let level = Expression<String>("level")
    
    func loadInit(linkPath: String){
        var dbPath : String = ""
        var dbResourcePath : String = ""
        
        let fileManager = FileManager.default
        do{
            dbPath = try fileManager
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("QuizJLPT.sqlite")
                .path
            if !fileManager.fileExists(atPath: dbPath) {
                dbResourcePath = Bundle.main.path(forResource: "QuizJLPT", ofType: "sqlite")!
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
    
    let question = Expression<String>("question")
    let doHoanThanh = Expression<Int>("doHoanThanh")

    func getDataDetail(closure: @escaping (_ response: [DetailQuiz]?, _ error: Error?) -> Void) {
        
        listDataDetail.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(Detail) {
                    listDataDetail.append(DetailQuiz(id: user[id], level: user[level], question: user[question], division: user[division], answer1: user[answer1], answer2: user[answer2], answer3: user[answer3], answer4: user[answer4], correctAnswer: user[correctAnswer], idDescription: user[idDescription], doHoanThanh: user[doHoanThanh]))
                }
            } catch  {
            }
        }
        closure(listDataDetail, nil)
        
    }
    
    func getDataHeader(closure: @escaping (_ response: [HeaderQuiz]?, _ error: Error?) -> Void) {
        
        listDataHeader.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(Header) {
                    listDataHeader.append(HeaderQuiz(id: user[id], level: user[level], division: user[division], description: user[Description], idDescription: user[idDescription]))
                }
            } catch  {
            }
        }
        closure(listDataHeader, nil)
    }
    
    func updateDoHoanThanh(level: String, idDescription: Int) {
        for item in self.listDataDetail {
            if item.level == level && item.idDescription == idDescription {
                item.doHoanThanh = 1
            }
        }
        let userFilter = Detail.filter(self.level == level && self.idDescription == idDescription)
        do{
            let update = userFilter.update(self.doHoanThanh <- 1)
            try DatabaseRoot!.run(update)
        } catch{
            print("Update failed: \(error)")
        }
    }
}

