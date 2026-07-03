//
//  WordWidget.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import SwiftUI
import WidgetKit

/// 小工具設定
struct WordWidget: Widget {
    
    let kind: String = "WordWidget"
    
    private let title = "單字複習卡"
    private let subtitle = "天天自動輪播新單字，幫你高效背單字。"
    private let families: [WidgetFamily] = [.systemSmall, .systemMedium]    // 支援的Widget大小
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WordWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(title)
        .description(subtitle)
        .supportedFamilies(families)
    }
}

#Preview("小工具實體預覽", as: .systemMedium, widget: {
    WordWidget()
}, timeline: {
    SimpleEntry(date: .now, word: "Persistent", definition: "堅持不懈的")
})
