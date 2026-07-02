//
//  MyWidget.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import SwiftUI
import WidgetKit

// 5. 小工具設定
struct MyWidget: Widget {
    
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("單字複習卡")
        .description("天天自動輪播新單字，幫你高效背單字。")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

#Preview("小工具實體預覽", as: .systemMedium, widget: {
    MyWidget()
}, timeline: {
    SimpleEntry(date: .now, word: "Persistent", definition: "堅持不懈的")
})
