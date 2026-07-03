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
        switch family {
        case .systemSmall: smallLayout
        case .systemMedium, .systemLarge: mediumLayout
        default: smallLayout
        }
    }
}

// MARK: - 私有屬性
private extension WordWidgetEntryView {
    
    /// 小尺寸排版
    var smallLayout: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 12) {
                speakWordButton(font: .system(size: 11, weight: .bold))
                changeWordButton(font: .system(size: 11, weight: .bold))
                Spacer()
            }
            
            Spacer()
            wordText(font: .system(size: 24, weight: .bold, design: .rounded))
            definitionText
            Spacer()
        }
        .padding(14)
        .containerBackground(gradientBackground, for: .widget)
        .widgetURL(URL(string: "wordwidget://detail?word=\(entry.word)"))
    }
    
    /// 中尺寸排版 (左右對開)
    var mediumLayout: some View {
        
        HStack(spacing: 16) {

            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                wordText(font: .system(size: 36, weight: .bold, design: .rounded))
                definitionText
                Spacer()
                HStack(spacing: 12) {
                    speakWordButton(font: .system(size: 16, weight: .bold))
                    changeWordButton(font: .system(size: 16, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                subTitleText
                Divider()
                    .background(Color.white.opacity(0.8))
                reviewItems(count: 5)
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(width: 100, alignment: .leading)
        }
        .padding(16)
        .containerBackground(gradientBackground, for: .widget)
        .widgetURL(URL(string: "wordwidget://detail?word=\(entry.word)"))
    }
}

// MARK: - 私有屬性
private extension WordWidgetEntryView {
    
    /// 中譯顯示
    var definitionText: some View {
        Text(entry.definition)
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.9))
            .padding(.top, 2)
    }
    
    /// 右邊的子標題
    var subTitleText: some View {
        Text("📋 延伸複習")
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(.white.opacity(0.7))
    }
    
    /// 漸層色背景
    var gradientBackground: some ShapeStyle {
        LinearGradient(colors: [.purple.opacity(0.8), .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

// MARK: - 私有屬性
private extension WordWidgetEntryView {
    
    /// 閱讀單字按鈕
    func speakWordButton(font: Font?) -> some View {
        
        Button(intent: SpeakWordIntent()) {
            Image(systemName: "speaker.wave.2.fill")
                .font(font)
                .foregroundColor(.purple)
                .padding(5)
                .background(Color.white)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
    
    /// 改變單字按鈕
    func changeWordButton(font: Font?) -> some View {
        
        Button(intent: ChangeWordIntent()) {
            Image(systemName: "arrow.clockwise")
                .font(font)
                .foregroundColor(.purple)
                .padding(5)
                .background(Color.white)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
    
    /// 單字顯示
    func wordText(font: Font?) -> some View {
        
        Text(entry.word)
            .foregroundColor(.white)
            .font(font)
            .minimumScaleFactor(0.6)
    }
    
    /// 延伸複習單字框
    func reviewItems(count: Int) -> some View {
        
        VStack(alignment: .leading, spacing: 6) {
            ForEach(reviews(count: count), id: \.self) { review in
                Text(review)
                    .font(.system(size: 12, weight: .medium))
            }
        }
    }
}

// MARK: - 私有API
private extension WordWidgetEntryView {
    
    /// 複習的單字 (後面的字)
    /// - Parameter count: 數量
    /// - Returns: [單字]
    func reviews(count: Int) -> [String] {
        
        let items: [String] = (1...count).compactMap { step in
            guard let target = Utility.shared.nextWord(step: step) else { return nil }
            return "• \(target.word)"
        }
        
        return items
    }
}

// MARK: - PreviewProvider
struct WordWidgetEntryView_Previews: PreviewProvider {
    
    static var previews: some View {
        WordWidgetEntryView(entry: .snapshot)
            .previewContext(WidgetPreviewContext(family: .systemMedium ))
    }
}

