//
//  Constant.swift
//  Widget
//
//  Created by William.Weng on 2026/7/2.
//

import Foundation

/// 公用屬性
struct Constant {
    
    static let groupID = "group.idv.william.Widget"     // App Groups上加入的 Widget ID
    static let wordsKey = "all_500_words"               // 存入UserDefaults的Key (單字)
    static let indexKey = "current_word_index"          // 存入UserDefaults的Key (序號)
    
    // 取得兩邊共用的UserDefaults
    static var sharedDefaults: UserDefaults? {
        UserDefaults(suiteName: Constant.groupID)
    }
}
