//
//  TodoListViewModek.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/06/30.
//

import Foundation

final class TodoListViewModel: ObservableObject {
    // 테이블뷰에 나타낼 투두 목록
    @Published var todos: [Todo]
    // 투두 편집 모드인지 확인
    @Published var isEditTodoMode: Bool
    // 삭제할 투두를 담을 배열
    @Published var removeTodos: [Todo]
    // 삭제 확인 얼럿을 표시할 것인지
    @Published var isDisplayRemoveTodoAlert: Bool
    
    // 삭제할 투두의 개수(얼럿창에 표시 필요)
    var removeTodosCount: Int {
        return removeTodos.count
    }
    
    // 네비게이션바 오른쪽 버튼 모드 - 편집(삭제 모드) / 완료
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditTodoMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = [Todo(title: "test", time: Date(), day: Date(), selected: false)],
        isEditTodoMode: Bool = false,
        removeTodos: [Todo] = [],
        isDisplayRemoveTodoAlert: Bool = false
    ) {
        self.todos = todos
        self.isEditTodoMode = isEditTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }
}

extension TodoListViewModel {
    func selectedBoxTapped(_ todo: Todo) {
        // 투두 체크시 토글 되도록
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].selected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo) {
        // 투두 생성시 목록에 추가
        todos.append(todo)
    }
    
    func navigationRightBtnTapped() {
        // 편집 모드일 때
        if isEditTodoMode {
            // 삭제할 투두가 없으면
            if removeTodos.isEmpty {
                // 편집 -> 완료 모드로 전환
                isEditTodoMode = false
            // 삭제할 투두가 있으면
            } else {
                // 투두 삭제를 위해 얼럿을 불러준다!
                setIsDisplayRemoveTodoAlert(true)
            }
        // 완료 모드일 때
        } else {
            // 완료 -> 편집 모드로 전환
            isEditTodoMode = true
        }
    }
    
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveTodoAlert = isDisplay
    }
    
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped() {
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        
        removeTodos.removeAll()
        isEditTodoMode = false
    }
}
