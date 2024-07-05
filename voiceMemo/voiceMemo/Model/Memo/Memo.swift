//
//  Memo.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/07/05.
//

import Foundation

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()
    
    
    var convertedDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}
