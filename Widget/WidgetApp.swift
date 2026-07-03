//
//  WidgetApp.swift
//  Widget
//
//  Created by William.Weng on 2026/7/2.
//

import SwiftUI

@main
struct WidgetApp: App {
    
    @Environment(\.openURL) private var openURL
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    deepLink(for: url)
                }
        }
    }
}

// MARK: - 私有API
private extension WidgetApp {
    
    /// 處理 .widgetURL() 傳來的 URL
    func deepLink(for url: URL) {
        
        guard url.scheme == "wordwidget" else { return }

        switch url.host {
        case "detail": detailAction(url: url, key: "word")
        default: break
        }
    }
    
    /// 分解URL => 處理相關功能 (wordwidget://detail?word=Persistent)
    /// - Parameters:
    ///   - url: 傳來的URL
    ///   - key: 要讀取的Key值
    func detailAction(url: URL, key: String) {
        guard let word = url.queryValue(for: "word") else { return }
        openDictionary(word)
    }
    
    /// 開啟線上字典網頁
    /// - Parameter word: 要查的單字
    func openDictionary(_ word: String) {
        guard let url = searchWordUrl(word) else { return }
        openURL(url)
    }
    
    /// 線上字典URL
    func searchWordUrl(_ word: String) -> URL? {
        let string = "https://www.ezabc.com.tw/showword/?srch_target=\(word)"
        return URL(string: string)
    }
}
