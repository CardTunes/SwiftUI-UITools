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
    var enabled:Bool
    
    public init(id:UUID, enabled:Bool) {
        self.id = id
        self.enabled = enabled
    }
    
    public func body(content: Content) -> some View {
        if enabled {
            content
              .overlay(
                  GeometryReader { geometry in
                      Color.clear
                          .preference(key: RectPreferenceKey.self,
                                value: [RectPreferenceData(id:self.id, rect: geometry.frame(in: .named("cfd31281-32a6-438a-a348-f3ad4bd2319a")))])

                  }
              )
        }
        else {
            content
        }

    }
}

public extension View {
    func frameGrab(id:UUID, enabled:Bool) -> some View {
        modifier(FrameGrabModifier(id: id, enabled: enabled))
    }
}
