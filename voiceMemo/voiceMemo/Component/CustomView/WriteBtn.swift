//
//  WriteBtn.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/07/28.
//

import SwiftUI

// MARK: - 1️⃣ 뷰 모디파이어 프로토콜 채택
public struct WriteBtnViewModifier: ViewModifier {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("writeBtn")
                    }
                    
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        }
    }
}

// MARK: - 2️⃣ View의 extension에서 func으로 구현
extension View {
    public func writeBtn(perform action: @escaping () -> Void) -> some View {
        ZStack {
            self
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("writeBtn")
                    }
                    
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        }
    }
}


// MARK: - 3️⃣ 아예 새로운 뷰를 정의
public struct WriteBtnView<Content: View>: View {
    let content: Content
    let action: () -> Void
    
    public init(
        @ViewBuilder content: () -> Content,
        action: @escaping () -> Void
    ) {
        self.content = content()
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            content
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("writeBtn")
                    }
                    
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 50)
        }
    }
}
