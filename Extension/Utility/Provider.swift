//
//  Provider.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import WidgetKit

/// Widget 的時間軸提供者（TimelineProvider）
/// 負責提供三種情境的資料：
/// 1. placeholder：Widget 還沒載入資料時的預覽
/// 2. snapshot：系統在快照（例如 Widget Gallery）使用
/// 3. timeline：實際顯示與更新的資料來源
struct Provider: TimelineProvider {
    
    /// 提供佔位資料（Skeleton UI）
    /// - 用於 Widget 尚未有真實資料時顯示
    /// - 通常會給固定、簡單的範例內容
    func placeholder(in context: Context) -> SimpleEntry {
        .placeholder
    }

    /// 提供快照資料（Snapshot）
    /// - 用於 Widget Gallery 預覽或系統快速渲染
    /// - 應該是「看起來像真的」資料，但不需要即時更新
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(.snapshot)
    }
    
    /// 提供時間軸資料（Timeline）/ policy = .never 表示不主動刷新
    /// - Widget 真正顯示時會使用這裡的資料
    /// - 可以決定未來何時更新（透過 policy）
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        
        let entries: [SimpleEntry] = timelineEntries ?? [.placeholder]
        let timeline = Timeline(entries: entries, policy: .never)
        
        completion(timeline)
    }
}

// MARK: - 私有屬性
private extension Provider {
    
    /// 從 shared container 讀取實際資料並轉成 Timeline Entry
    var timelineEntries: [SimpleEntry]? {
        
        guard let sharedDefaults = Constant.sharedDefaults,
              let savedData = sharedDefaults.data(forKey: Constant.wordsKey),
              let allWords: [Vocabulary] = savedData.decoded()
        else {
            return nil
        }
        
        let currentIndex = sharedDefaults.integer(forKey: Constant.indexKey)
        let wordIndex = currentIndex % allWords.count
        let target = allWords[wordIndex]
        let entry = SimpleEntry(date: .now, word: target.word, definition: target.definition)
                
        return [entry]
    }
}
