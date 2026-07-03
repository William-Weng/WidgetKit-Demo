//
//  WordWidgetEntryView.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import SwiftUI
import WidgetKit
import AppIntents

// 4. 小工具 UI 畫面（雙按鈕排版）
struct WordWidgetEntryView: View {
    
    var entry: Provider.Entry
    
    // 🌟 核心關鍵：引入系統環境變數，用來得知目前小工具是什麼尺寸
    @Environment(\.widgetFamily) var family

    var body: some View {
        // 使用 switch 判斷目前尺寸
        switch family {
        case .systemSmall:
            // ─── 小尺寸：維持原本的單張單字卡設計 ───
            smallLayout
                .containerBackground(
                    LinearGradient(colors: [Color.blue, Color.purple.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing),
                    for: .widget
                )
            
        case .systemMedium, .systemLarge:
            // ─── 中尺寸：改用左右雙欄排版 ───
            mediumLayout
                .containerBackground(
                    LinearGradient(colors: [Color.purple.opacity(0.8), Color.indigo], startPoint: .topLeading, endPoint: .bottomTrailing),
                    for: .widget
                )
            
        default:
            // 保底處理（防呆）
            smallLayout
                .containerBackground(.background, for: .widget)
        }
    }
}

// MARK: - 私有屬性
private extension WordWidgetEntryView {
    
    // 佈局 A：原本的小尺寸排版
    var smallLayout: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                
                Spacer()
                
                Button(intent: SpeakCurrentWordIntent()) {
                    Image(systemName: "speaker.wave.2.fill")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(5)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                
                Button(intent: ChangeWordIntent()) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(5)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
            Text(entry.word)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.6)
            
            Text(entry.definition)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
                .padding(.top, 2)
            Spacer()
        }
        .padding(14)
        .widgetURL(URL(string: "wordwidget://detail?word=\(entry.word)"))
    }
    
    // 全新的中尺寸排版 (左右對開)
    var mediumLayout: some View {
        HStack(spacing: 16) {
            // 左半邊：沿用原本的小佈局內容（拿掉按鈕，留下主單字展示）
            VStack(alignment: .leading, spacing: 4) {
                Text("今日主修單字")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                Text(entry.word)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(entry.definition)
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer()
                
                // 喇叭與換字按鈕挪到左下方，中尺寸更好點擊
                HStack(spacing: 12) {
                    Button(intent: SpeakCurrentWordIntent()) {
                        Label("發音", systemImage: "speaker.wave.2.fill")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.purple)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    
                    Button(intent: ChangeWordIntent()) {
                        Label("換字", systemImage: "arrow.clockwise")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.purple)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 右半邊：延伸顯示明日/其他複習單字列表
            VStack(alignment: .leading, spacing: 8) {
                Text("📋 延伸複習")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white.opacity(0.7))
                
                Divider().background(Color.white.opacity(0.3))
                
                // 這裡先寫死兩組假資料做示範，您以後可以改用陣列傳入
                VStack(alignment: .leading, spacing: 6) {
                    Text("• Optimize (優化)")
                        .font(.system(size: 12, weight: .medium))
                    Text("• Timeline (時間軸)")
                        .font(.system(size: 12, weight: .medium))
                    Text("• Framework (架構)")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(.white)
                
                Spacer()
            }
            .frame(width: 140, alignment: .leading)
        }
        .padding(16)
        .widgetURL(URL(string: "wordwidget://detail?word=\(entry.word)"))
    }
}

#Preview {
    WordWidgetEntryView(entry: .snapshot)
}

