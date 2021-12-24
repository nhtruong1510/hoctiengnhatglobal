//
//  MenuModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation
import UIKit

struct MenuModel {
    var image : UIImage!
    var text: String
    var textVN: String
}

class MenuData {
    static let shared: MenuData = MenuData()
    var menu = [
        MenuModel(image: #imageLiteral(resourceName: "languages"), text: "Vocabulary", textVN: "Từ vựng"),
        MenuModel(image: #imageLiteral(resourceName: "kanji"), text: "2300 Kanji", textVN: "2300 Kanji" ),
        MenuModel(image: #imageLiteral(resourceName: "alphabet_hiragana"), text: "Hiragana", textVN: "Hiragana"),
        MenuModel(image: #imageLiteral(resourceName: "grammar"), text: "Grammar", textVN: "Ngữ pháp"),
        MenuModel(image: #imageLiteral(resourceName: "communication"), text: "Communication", textVN: "Giao tiếp"),
        MenuModel(image: #imageLiteral(resourceName: "choose"), text: "Quiz", textVN: "Quiz"),
        MenuModel(image: #imageLiteral(resourceName: "searching"), text: "Search", textVN: "Tìm kiếm"),
        MenuModel(image: #imageLiteral(resourceName: "sofavorite"), text: "Bookmark", textVN: "Đánh dấu"),
        MenuModel(image: #imageLiteral(resourceName: "setting"), text: "Setting", textVN: "Cài đặt")
    ]
}

