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
            let direction:Direction = newIndex > last ? .Ascending : .Descending

            var itemsToRemove = [UUID]()
            var itemsToAdd = [UUID]()
            
            let dirChanged = dirChanged(last: last, direction: direction)
            
            if dirChanged {
                let start = direction == .Ascending ? last : newIndex + 1
                let end = direction == .Ascending ? newIndex - 1 : last
                itemsToRemove = items[start...end].map{($0.id as? UUID)!}
                
                itemsToAdd = getOverlap(newIndex: newIndex, orig:orig, direction: direction)
            }
            else {
                let start = direction == .Ascending ? last + 1 : newIndex
                let end = direction == .Ascending ? newIndex : last - 1
                itemsToAdd = items[start...end].map{($0.id as? UUID)!}
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

//    private func add(id:UUID,  direction:Direction) {
//        selection.insert(id)
//        if direction == .Ascending {
//           selection.insert(id, at: 0)
//       }
//       else {
//           selection.append(id)
//       }
//    }
    
//    private func add(start:Int, end:Int) {
//        var items:[UUID] = items[start...end].map{($0.id as? UUID)!}
//        selection.formUnion(items)
////        if direction == .Ascending {
////            items.append(contentsOf: selection)
////            selection = OrderedSet(items)
////       }
////       else {
////           selection.append(contentsOf: items)
////       }
//    }
    
    private func add(items: inout [UUID]) {
        selection.formUnion(items)
    }
    
//    private func remove(start:Int, end:Int) {
//        let items:[UUID] = items[start...end].map{($0.id as? UUID)!}
//        selection.formSymmetricDifference(items)
//    }
//    
    private func remove(items: [UUID]) {
        selection.formSymmetricDifference(items)
    }
    
    private func remove(id:UUID) {
        selection.remove(id)
    }

//    func contains(id:UUID) -> Bool {
//        return selection.contains(id)
//    }

    private func removeAll() {
        selection.removeAll()
    }
    
    private func getOverlap(newIndex:Int, orig:Int, direction:Direction) -> [UUID] {
        var start = 0
        var end = 0
        if direction == .Ascending {
            if newIndex <= orig {
                return [UUID]()
            }
            start = orig
            end = newIndex
        }
        else {
            if newIndex >= orig {
                return [UUID]()
            }
            start = newIndex
            end = orig
        }
        
        return items[start...end].map{($0.id as? UUID)!}
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

