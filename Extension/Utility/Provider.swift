//
//  Provider.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import WidgetKit

// 3. 時間軸提供者
struct Provider: TimelineProvider {
    
    let groupID = Constant.suiteName
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), word: "Persistent", definition: "堅持不懈的")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), word: "Efficient", definition: "高效率的"))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let sharedDefaults = UserDefaults(suiteName: groupID)
        
        var allWords: [Vocabulary] = []
        if let savedData = sharedDefaults?.data(forKey: "all_500_words") {
            allWords = (try? JSONDecoder().decode([Vocabulary].self, from: savedData)) ?? []
        }
        
        if allWords.isEmpty {
            allWords = [Vocabulary(word: "Persistent", definition: "堅持不懈的")]
        }
        
        let currentIndex = sharedDefaults?.integer(forKey: "current_word_index") ?? 0
        let wordIndex = currentIndex % allWords.count
        let targetVocab = allWords[wordIndex]
        
        let entry = SimpleEntry(date: currentDate, word: targetVocab.word, definition: targetVocab.definition)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}
