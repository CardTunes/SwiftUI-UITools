//
//  BoundsPreferences.swift
//  SelectionEdit
//
//  Created by David Card on 8/19/24.
//

import Foundation
import SwiftUI

//public protocol MultiSelectData : Equatable {
//    var id:UUID {get set}
//    var rect: CGRect {get set}
//    init(id:UUID, rect:CGRect)
//}
//
//public struct BarPreferenceData: MultiSelectData {
//    public var id:UUID
//    public var rect: CGRect
//    public init(id:UUID, rect:CGRect) {
//        self.id = id
//        self.rect = rect
//    }
//}
//public struct VoicePreferenceData: MultiSelectData {
//    public var id:UUID
//    public var rect: CGRect
//    public init(id:UUID, rect:CGRect) {
//        self.id = id
//        self.rect = rect
//    }
//}

public struct RectPreferenceData: Equatable {
    public var id:UUID
    public var rect: CGRect
    public init(id:UUID, rect:CGRect) {
        self.id = id
        self.rect = rect
    }
}

//public struct BoundsPreferenceData: Equatable {
//    var id:UUID
//    var bounds: Anchor<CGRect>
//}
//
//public struct BoundsPreferenceKey<T>: PreferenceKey {
//    public typealias Value = [BoundsPreferenceData]
//    
//    public static var defaultValue: [BoundsPreferenceData] = []
//    
//    public static func reduce(value: inout [BoundsPreferenceData], nextValue: () -> [BoundsPreferenceData]) {
//        
//        value.append(contentsOf: nextValue())
//    }
//}

public struct RectPreferenceKey: PreferenceKey {
    public typealias Value = [RectPreferenceData]
    
    public static var defaultValue: [RectPreferenceData] = []
    
    public static func reduce(value: inout [RectPreferenceData], nextValue: () -> [RectPreferenceData]){
        value.append(contentsOf: nextValue())
    }
}
