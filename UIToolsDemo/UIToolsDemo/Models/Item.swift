//
//  Item.swift
//  SelectionEdit
//
//  Created by David Card on 8/18/24.
//

import Foundation
import SwiftData
import Combine

final class Item : Identifiable, Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    var id = UUID()
    
    var display:String
    var frame:CGRect
    var rotation:Double
    
    init(display:String, frame: CGRect, rotation: Double) {
        self.display = display
        self.frame = frame
        self.rotation = rotation
    }
    
}
