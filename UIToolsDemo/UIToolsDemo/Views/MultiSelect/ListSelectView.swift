//
//  ListSelectView.swift
//  UIToolsDemo
//
//  Created by David Card on 9/10/24.
//

import SwiftUI

struct ListSelectView: View {
    @State private var selection = Set<UUID>()
    
    @State var items = [Item]()
    
    var body: some View {
        NavigationView {
            VStack {
                List(items, selection: $selection) { item in
                    ItemView(item: item)
                        .frame(width:item.frame.width, height:item.frame.height)
                        .border(Color.red)
                }
                .navigationTitle("Contacts")
            }
        }

        .onAppear{
            initItems()
        }
    }
    
    private func initItems() {
        items.append(Item(display:"1", frame: CGRect(x: 0, y: 0, width: 50, height: 50), rotation: 0))
        items.append(Item(display:"2", frame: CGRect(x: 0, y: 170, width: 50, height: 250), rotation: 90))
        items.append(Item(display:"3", frame: CGRect(x: 0, y: 170, width: 50, height: 350), rotation: 120))
        items.append(Item(display:"4", frame: CGRect(x: 0, y: 170, width: 50, height: 150), rotation: 45))
        items.append(Item(display:"5", frame: CGRect(x: 0, y: 170, width: 50, height: 200), rotation: 200))
    }
}

