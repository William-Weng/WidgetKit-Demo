//
//  ContentView.swift
//  Widget
//
//  Created by William.Weng on 2026/7/2.
//

import SwiftUI
import WidgetKit // 記得匯入

import SwiftUI
import WidgetKit

// 1. 定義單字模型 (符合 Codable 才能打包成 JSON 存入 UserDefaults)
struct Vocabulary: Codable {
    let word: String
    let definition: String
}

struct ContentView: View {
    
    // 2. 準備 10 組測試單字
    let test10Words: [Vocabulary] = [
        Vocabulary(word: "Persistent", definition: "堅持不懈的"),
        Vocabulary(word: "Efficient", definition: "高效率的"),
        Vocabulary(word: "Innovative", definition: "創新的"),
        Vocabulary(word: "Simplicity", definition: "簡約、單純"),
        Vocabulary(word: "Optimize", definition: "最佳化、優化"),
        Vocabulary(word: "Synchronize", definition: "同步"),
        Vocabulary(word: "Timeline", definition: "時間軸"),
        Vocabulary(word: "Context", definition: "上下文、語境"),
        Vocabulary(word: "Framework", definition: "框架、架構"),
        Vocabulary(word: "Extension", definition: "擴充功能")
    ]
    
    var body: some View {
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
        .padding()
    }
    
    // 3. 寫入 App Group 的核心函數
    func saveAndSyncWords() {
        // 請改成你自己的 App Group ID
        let groupID = Constant.suiteName
        
        guard let sharedDefaults = UserDefaults(suiteName: groupID) else {
            print("❌ 找不到 App Group，請檢查 Xcode 權限設定！")
            return
        }
        
        do {
            // 打包成 JSON Data
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(test10Words)
            
            // 存入單字庫，並重置播放進度（Index 歸零，從第一個單字開始放）
            sharedDefaults.set(encodedData, forKey: "all_500_words")
            sharedDefaults.set(0, forKey: "current_word_index")
            
            // 🔥 核心：通知小工具立刻醒來重新排程
            WidgetCenter.shared.reloadAllTimelines()
            print("✅ 10 組單字成功同步，已重置進度！")
            
        } catch {
            print("❌ 編碼失敗: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
