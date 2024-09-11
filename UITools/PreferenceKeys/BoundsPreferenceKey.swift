//
//  BoundsPreferences.swift
//  SelectionEdit
//
//  Created by David Card on 8/19/24.
//

import Foundation
import SwiftUI

public struct BoundsPreferenceData: Equatable {
    var id:UUID
    var bounds: Anchor<CGRect>
    
}

public struct BoundsPreferenceKey: PreferenceKey {
    public typealias Value = [BoundsPreferenceData]
    
    public static var defaultValue: [BoundsPreferenceData] = []
    
    public static func reduce(value: inout [BoundsPreferenceData], nextValue: () -> [BoundsPreferenceData]) {
        
        value.append(contentsOf: nextValue())
    }
}
