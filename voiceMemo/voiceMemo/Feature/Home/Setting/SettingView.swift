//
//  SettingView.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/07/23.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            // 타이블 튜
            TitleView()
                .padding(.top, 20)
            
            Spacer()
                .frame(height: 50)
            
            // 총 탭 카운트 뷰
            TotalTabCountView()
            
            Spacer()
                .frame(height: 50)
            
            // 총 탭 무브 뷰
            TotalTabMoveView()
        }
    }
}

// MARK: - 타이블 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("설정")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.customBlack)
            
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.top, 30)
    }
}

// MARK: - 전체 탭 설정된 카운트 뷰
private struct TotalTabCountView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        // 각각 탭 카운트 뷰 (todolist, 메모장, 음성메모)
        HStack(spacing: 80) {
            TabCountView(title: "To do", count: homeViewModel.todosCount)
            TabCountView(title: "메모", count: homeViewModel.memosCount)
            TabCountView(title: "음성메모", count: homeViewModel.voiceRecordersCount)
        }
    }
}

// MARK: - 각 탭 설정된 카운트 뷰 (공통 뷰 컴포넌트)
private struct TabCountView: View {
    private var title: String
    private var count: Int
    
    fileprivate init(title: String, count: Int) {
        self.title = title
        self.count = count
    }
    
    fileprivate var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.customBlack)
            
            Text("\(count)")
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(.customBlack)
        }
    }
}

// MARK: - 전체 탭 이동 뷰
private struct TotalTabMoveView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    fileprivate var body: some View {
        VStack(spacing: 15) {
            Rectangle()
                .fill(Color.customGray1)
                .frame(height: 1)
            
            TabMoveView(
                title: "To do 리스트",
                tabAction: {
                    homeViewModel.changeSelectedTab(.todoList)
                }
            )
            
            TabMoveView(
                title: "메모",
                tabAction: {
                    homeViewModel.changeSelectedTab(.memo)
                }
            )
            
            TabMoveView(
                title: "음성메모",
                tabAction: {
                    homeViewModel.changeSelectedTab(.voiceRecorder)
                }
            )
            
            TabMoveView(
                title: "타이머",
                tabAction: {
                    homeViewModel.changeSelectedTab(.timer)
                }
            )
            
            Rectangle()
                .fill(Color.customGray1)
                .frame(height: 1)
            
            Spacer()
        }
    }
}

// MARK: - 각 탭 이동뷰
private struct TabMoveView: View {
    private var title: String
    private var tabAction: () -> Void
    
    fileprivate init(title: String, tabAction: @escaping () -> Void) {
        self.title = title
        self.tabAction = tabAction
    }
    
    fileprivate var body: some View {
        Button {
            tabAction()
        } label: {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.customBlack)
            
            Spacer()
            
            Image("arrowRight")
        }
        .padding(.horizontal, 20)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(HomeViewModel())
    }
}
