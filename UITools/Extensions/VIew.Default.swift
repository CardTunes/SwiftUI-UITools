//
//  VIew.Shape.swift
//  UITools
//
//  Created by David Card on 9/21/24.
//

import Foundation
import SwiftUI

public extension View {
    func getShape(shape:any Shape) -> some Shape {
        return AnyShape(shape)
    }
    
    @ViewBuilder
    func modifiedDrop(isEnabled:Bool,callback: @escaping (_ items:[String],_ location:CGPoint)->Bool) -> some View {
        if isEnabled {
            self
                .dropDestination(for: String.self) { items, location in
                    return callback(items, location)
                }
        }
        self
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

