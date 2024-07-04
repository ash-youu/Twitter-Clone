//
//  Path.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/06/29.
//

import Foundation

final class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
