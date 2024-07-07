//
//  MemoViewModel.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/07/05.
//

import Foundation

final class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
