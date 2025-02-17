//
//  TimerView.swift
//  voiceMemo
//
//  Created by 유연수 on 2024/07/15.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var timerViewModel = TimerViewModel()
    
    var body: some View {
        if timerViewModel.isDisplaySetTimeView {
            SetTimerView(timerViewModel: timerViewModel)
        } else {
            TimerOperation(timerViewModel: timerViewModel)
        }
    }
}

private struct SetTimerView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            TitleView()
                .padding(.top, 20)
            
            Spacer()
                .frame(height: 50)
            
            TimePickerView(timerViewModel: timerViewModel)
            
            Spacer()
                .frame(height: 30)
            
            TimerCreateBtnView(timerViewModel: timerViewModel)
            
            Spacer()
        }
    }
}

// MARK: - 타이틀 뷰
private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("타이머")
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - 타이머 피커 뷰
private struct TimePickerView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
            
            HStack {
                Picker("Hour", selection: $timerViewModel.time.hours) {
                    ForEach(0..<24) { hour in
                        Text("\(hour)시")
                    }
                }
                
                Picker("Minute", selection: $timerViewModel.time.minutes) {
                    ForEach(0..<60) { minute in
                        Text("\(minute)분")
                    }
                }
                
                Picker("Second", selection: $timerViewModel.time.seconds) {
                    ForEach(0..<60) { second in
                        Text("\(second)초")
                    }
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
        }
    }
}

// MARK: - 타이버 생성 버튼 뷰
private struct TimerCreateBtnView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        Button {
            timerViewModel.settingBtnTapped()
        } label: {
            Text("설정하기")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.customGreen)
        }
    }
}

// MARK: - 타이머 작동 뷰
private struct TimerOperation: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text("\(timerViewModel.timeRemaining.formattedTimeString)")
                        .font(.system(size: 28))
                        .foregroundColor(.customBlack)
                        .monospaced() // 숫자가 달라져도 동일한 글자 너비를 갖기
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: "bell.fill")
                        
                        Text("\(timerViewModel.time.convertedSeconds.formateedSettingTime)")
                            .font(.system(size: 16))
                            .foregroundColor(.customBlack)
                            .padding(.top, 10)
                    }
                }
                
                Circle()
                    .stroke(Color.customOrange, lineWidth: 6)
                    .frame(width: 350)
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                Button {
                    timerViewModel.cancelBtnTapped()
                } label: {
                    Text("취소")
                        .font(.system(size: 16))
                        .foregroundColor(.customBlack)
                        .padding(.vertical, 25)
                        .padding(.horizontal, 22)
                        .background(
                            Circle()
                                .fill(Color.customGray2.opacity(0.3))
                        )
                }
                
                Spacer()
                
                Button {
                    timerViewModel.pauseOrRestartBtnTapped()
                } label: {
                    Text(timerViewModel.isPaused ? "계속 진행" : "일시 정지")
                        .font(.system(size: 14))
                        .foregroundColor(.customBlack)
                        .padding(.vertical, 25)
                        .padding(.horizontal, 7)
                        .background {
                            Circle()
                                .fill(Color(red: 1, green: 0.75, blue: 0.52))
                        }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
