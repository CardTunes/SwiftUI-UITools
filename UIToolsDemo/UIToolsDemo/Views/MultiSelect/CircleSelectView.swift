//
//  CircleSelectView.swift
//  UIToolsDemo
//
//  Created by David Card on 9/10/24.
//

import SwiftUI
import Collections

struct CircleSelectView: View {
    @State var items = [Item]()
    @State var selection = Set<UUID>()
    
    var body: some View {
        MultiSelect(selection: $selection, items: items)
        {
            CircleLayout {
                ForEach(items, id:\.self) {item in
                    ItemView(item: item)
                        .frame(width:200, height: 20)
                        .border(Color.red)
                        .background(selection.contains(item.id)
                             ? Color(.systemGray)
                             : Color.clear )
                        .frameGrab(id: item.id)
                }
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .onAppear{
                initItems()
            }
        }
    }
    
    private func initItems() {
        items.append(Item(display:"1", frame: CGRect(x: 0, y: 0, width: 50, height: 50), rotation: 0))
        items.append(Item(display:"2", frame: CGRect(x: 0, y: 170, width: 50, height: 150), rotation: 90))
        items.append(Item(display:"3", frame: CGRect(x: 0, y: 170, width: 50, height: 150), rotation: 120))
        items.append(Item(display:"4", frame: CGRect(x: 0, y: 170, width: 50, height: 150), rotation: 45))
        items.append(Item(display:"5", frame: CGRect(x: 0, y: 170, width: 50, height: 150), rotation: 200))
    }
}

