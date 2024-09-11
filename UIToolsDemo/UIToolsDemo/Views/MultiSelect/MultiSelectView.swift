//
//  MultiSelectView.swift
//  UIToolsDemo
//
//  Created by David Card on 9/10/24.
//

import SwiftUI
enum MultiSelectViewItem: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    
    case list
    case circle

}


struct MultiSelectView: View {
    @State var tabSelection = MultiSelectViewItem.list
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("MultiSelect Demo")
            
            TabView(selection:$tabSelection) {
                ListSelectView()
                    .tabItem {
                        Text("List View")
                    }
                    .tag(MultiSelectViewItem.list)
                CircleSelectView()
                    .tabItem {
                        Text("Circle View")
                    }
                    .tag(MultiSelectViewItem.circle)
                
            }
           
        }
        
    }
}
