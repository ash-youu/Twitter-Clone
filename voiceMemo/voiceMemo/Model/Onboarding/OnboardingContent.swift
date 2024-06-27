//
//  OnboardingContent.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/06/27.
//

import Foundation

// 추후에 탭뷰에서도 사용할 것이기 때문에 Hashable 채택
struct OnboardingContent: Hashable {
    var imageFileName: String
    var title: String
    var subTitle: String
    
    init(imageFileName: String, title: String, subTitle: String) {
        self.imageFileName = imageFileName
        self.title = title
        self.subTitle = subTitle
    }
}
