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
}
