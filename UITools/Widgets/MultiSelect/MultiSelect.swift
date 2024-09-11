//
//  MultiSelect.swift
//  SelectionEdit
//
//  Created by David Card on 8/18/24.
//

import Foundation
import SwiftUI
import Collections

enum Direction {
    case Descending
    case Ascending
}

extension OrderedSet where Element == UUID {
    func display() -> String {
        let result:[String] = self.map{$0.uuidString}
        return result.joined(separator: "\n")
    }
}

extension CGRect : Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(origin.x)
        hasher.combine(origin.y)
        hasher.combine(size.width)
        hasher.combine(size.height)
    }
}
public struct MultiSelect<Content: View, T : Identifiable>: View {
    @Binding var selection:Set<UUID>
    @State internal var frames = [CGRect]()
    @State private var lastIndex:Int?
    @State private var origin:Int?
    
    private var items:[T]
    private let content: Content

    public init(selection:Binding<Set<UUID>>, items:[T],  @ViewBuilder content: () -> Content) {
        self.content = content()
        _selection = selection
        self.items = items
    }

    public var body: some View {
        GeometryReader {geometry in
            content
                .contentShape(Rectangle())
                .gesture(
                    simpleDrag()
                )
                .onPreferenceChange(BoundsPreferenceKey.self) {preferences in
                   frames = preferences.map{geometry[$0.bounds]}
                }
        }
    }
   
    @State internal var location:CGPoint?  {
        didSet {
            if let val = self.location {
                setSelection(newValue: val)
            }
            else {
                lastIndex = nil
            }
        }
    }
    
    // For testing
    internal func setLocation(loc:CGPoint) {
            DispatchQueue.main.async {
                setSelection(newValue: loc)
            }
    }
    
    private func setSelection(newValue:CGPoint) {
        guard let newIndex = getSelectionIndex(location: newValue),
            let id = items[newIndex].id as? UUID,
            newIndex != lastIndex
        else {
            return
        }

        
        if let last = lastIndex,
            let lastId = self.items[last].id as? UUID,
            let orig = origin
            {
            let oldDir:Direction = last > orig ? .Ascending : .Descending
            let direction:Direction = newIndex > last ? .Ascending : .Descending
            let dirChanged = oldDir != direction
            
            var itemsToRemove = [UUID]()
            var itemsToAdd = [UUID]()
            
            if dirChanged {
                let rngToRemove =  direction == .Ascending ?
                    Range(last...newIndex - 1) : Range(newIndex + 1...last)
                itemsToRemove = items[rngToRemove].map{($0.id as? UUID)!}
                
                if let overlapRange = getOverlapRange(newIndex: newIndex, orig: orig, direction: direction) {
                    itemsToAdd =  items[overlapRange].map{($0.id as? UUID)!}
                }
            }
            else {
                let rngToAdd =  direction == .Ascending ?
                    Range(last + 1...newIndex) : Range(newIndex...last - 1)
                itemsToAdd = items[rngToAdd].map{($0.id as? UUID)!}
            }
               
            if itemsToRemove.count > 0 {
                remove(items: itemsToRemove)
            }
               
            if itemsToAdd.count > 0 {
                add(items: &itemsToAdd)
            }

        }
        else {
            addNew(id:id)
            origin = newIndex
        }
        lastIndex = newIndex
    }
    
    func display() -> String {
        let result:[String] = selection.map{$0.uuidString}
        return result.joined(separator: "\n")
    }
    
    private func getSelectionIndex(location:CGPoint?) -> Int? {
        if let loc = location, let index = frames.firstIndex(where: { $0.contains(loc) }) {
            return index
        } else {
            return nil
        }
    }
    
    private func addNew(id:UUID) {
        selection.removeAll()
        selection.insert(id)
    }

    private func add(items: inout [UUID]) {
        selection.formUnion(items)
    }

    private func remove(items: [UUID]) {
        selection.formSymmetricDifference(items)
    }
    
    private func remove(id:UUID) {
        selection.remove(id)
    }

    private func removeAll() {
        selection.removeAll()
    }
    
    private func getOverlapRange(newIndex:Int, orig:Int, direction:Direction) -> Range<Int>? {
        if direction == .Ascending {
            if newIndex <= orig {
                return nil
            }
            return Range(orig...newIndex)
        }
        else {
            if newIndex >= orig {
                return nil
            }
            return Range(newIndex...orig)
        }
        return nil
        
    }
        
    private func dirChanged(last:Int,  direction:Direction) -> Bool {
        guard let orig = origin else {
            return false
        }
        if last == orig  {
            return false
        }
        
        let oldDir:Direction = last < orig ? .Descending : .Ascending
        return oldDir != direction
    }

    private func simpleDrag() -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged({value in
                withAnimation {
                    location = value.location
                }
            })
            .onEnded({ _ in
                location = nil
                origin = nil
            })
    }
}

