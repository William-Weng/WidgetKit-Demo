//
//  Model.swift
//  ExtensionExtension
//
//  Created by William.Weng on 2026/7/2.
//

import Foundation
import WidgetKit

// 1. 小工具專用單字模型 (需與主 App 一致)
struct Vocabulary: Codable {
    let word: String
    let definition: String
}
