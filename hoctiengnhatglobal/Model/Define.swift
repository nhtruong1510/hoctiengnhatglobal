//
//  Define.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

enum Level: CaseIterable {
    case N1
    case N2
    case N3
    case N4
    case N5
    var text: String {
        switch self {
        case .N1:
            return "N1"
        case .N2:
            return "N2"
        case .N3:
            return "N3"
        case .N4:
            return "N4"
        case .N5:
            return "N5"
        }
    }
    var imageData: String {
        switch self {
        case .N1:
            return "n1"
        case .N2:
            return "n2"
        case .N3:
            return "n3"
        case .N4:
            return "n4"
        case .N5:
            return "n5"
        }
    }
}

enum Language: CaseIterable {
    case English
    case Vietnamese
    case Malay
    var text: String {
        switch self {
        case .English:
            return "English"
        case .Vietnamese:
            return "Vietnamese"
        case .Malay:
            return "Indo"
        }
    }
    var number: Int {
        switch self {
        case .English:
            return 0
        case .Vietnamese:
            return 1
        case .Malay:
            return 2
        }
    }
}

