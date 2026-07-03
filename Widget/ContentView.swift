//
//  ContentView.swift
//  Widget
//
//  Created by William.Weng on 2026/7/2.
//

import SwiftUI
import WidgetKit

/// 主APP畫面
struct ContentView: View {
    
    private let test10Words = Vocabulary.test10Words
    
    var body: some View {
        bodyView
            .padding()
    }
}

// MARK: - 私有屬性
private extension ContentView {
    
    /// 單字小工具控制台View
    var bodyView: some View {
        
        VStack(spacing: 25) {
            Image(systemName: "book.closed.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("單字小工具控制台")
                .font(.title2.bold())
            
            Text("內建已準備好 10 組核心開發單字")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: saveAndSyncWords) {
                Text("同步 10 組單字到小工具")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
    }
}

// MARK: - 私有API
private extension ContentView {
    
    /// 寫入 App Group 的核心函數
    ///  
    /// 存入單字庫，並重置播放進度（Index 歸零，從第一個單字開始放）
    ///
    func saveAndSyncWords() {
        
        guard let sharedDefaults = Constant.sharedDefaults else { print("❌ 找不到 App Group，請檢查 Xcode 權限設定！"); return }
        
        do {
            let encodedData = try test10Words.encoded()
            
            sharedDefaults.set(encodedData, forKey: Constant.wordsKey)
            sharedDefaults.set(0, forKey: Constant.indexKey)
            
            WidgetCenter.shared.reloadAllTimelines()    // 🔥 核心：通知小工具立刻醒來重新排程
            print("✅ 10 組單字成功同步，已重置進度！")
        } catch {
            print("❌ 編碼失敗: \(error)")
        }
    }
}

#Preview {
    ContentView()
}




