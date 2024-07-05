//
//  MemoListViewModel.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/07/05.
//

import Foundation

final class MemoListViewModel: ObservableObject {
    // 테이블뷰에 나타낼 메모 목록
    @Published var memos: [Memo] = []
    // 메모 편집 모드인지 확인
    @Published var isEditMemoMode: Bool
    // 삭제할 메모를 담을 배열
    @Published var removeMemos: [Memo]
    // 삭제 확인 얼럿을 표시할 것인지
    @Published var isDisplayRemoveMemoAlert: Bool
    
    // 삭제할 투두의 개수(얼럿창에 표시 필요)
    var removeMemosCount: Int {
        return removeMemos.count
    }
    
    // 네비게이션바 오른쪽 버튼 모드 - 편집(삭제 모드) / 완료
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMemoMode ? .complete : .edit
    }
    
    init(
        // TODO: 추후 더미 데이터 삭제
        memos: [Memo] = [
            Memo(
                title: "퇴근 후 도서관 들르기",
                content: "꼭꼭!!!",
                date: Date()
            ),
            Memo(
                title: "퇴근 후 도서관 들르기",
                content: "꼭꼭!!!",
                date: Date()
            ),
            Memo(
                title: "퇴근 후 도서관 들르기",
                content: "꼭꼭!!!",
                date: Date()
            ),
        ],
        isEditMemoMode: Bool = false,
        removeMemos: [Memo] = [],
        isDisplayRemoveMemoAlert: Bool = false
    ) {
        self.memos = memos
        self.isEditMemoMode = isEditMemoMode
        self.removeMemos = removeMemos
        self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
    }
}

extension MemoListViewModel {
    func addMemo(_ memo: Memo) {
        memos.append(memo)
    }
    
    func navigationRightBtnTapped() {
        // 편집 모드일 때
        if isEditMemoMode {
            // 삭제할 메모가 없으면
            if removeMemos.isEmpty {
                // 편집 -> 완료 모드로 전환
                isEditMemoMode = false
                // 삭제할 메모가 있으면
            } else {
                // 투두 삭제를 위해 얼럿을 불러준다!
                setIsDisplayRemoveTodoAlert(true)
            }
        // 완료 모드일 때
        } else {
            // 완료 -> 편집 모드로 전환
            isEditMemoMode = true
        }
    }
    
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveMemoAlert = isDisplay
    }
    
    func memoRemoveSelectedBoxTapped(_ memo: Memo) {
        if let index = removeMemos.firstIndex(of: memo) {
            removeMemos.remove(at: index)
        } else {
            removeMemos.append(memo)
        }
    }
    
    func removeBtnTapped() {
        memos.removeAll { removeMemos.contains($0) }
        removeMemos.removeAll()
        isEditMemoMode = false
    }
}
