//
//  FrameGrabModifier.swift
//  SelectionEdit
//
//  Created by David Card on 8/19/24.
//

import Foundation
import SwiftUI

public struct FrameGrabModifier : ViewModifier {
    var id:UUID
    
    public init(id:UUID) {
        self.id = id
    }
    
    public func body(content: Content) -> some View {
          content
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) {value in
                            return [BoundsPreferenceData(id:self.id, bounds: value)]
                        }
                }
            )
    }
}

public extension View {
    func frameGrab(id:UUID) -> some View {
        modifier(FrameGrabModifier(id: id))
    }
}
