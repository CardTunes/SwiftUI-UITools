//
//  ContentView.swift
//  UIToolsDemo
//
//  Created by David Card on 9/9/24.
//

import SwiftUI
import SwiftData

enum SideBarItem: String, Identifiable, CaseIterable {
    var id: String { rawValue }
    
    case multiSelect

}

struct ContentView: View {
    @State var sideBarVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State var selectedSideBarItem: SideBarItem = .multiSelect
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(SideBarItem.allCases, selection: $selectedSideBarItem) { item in
                NavigationLink(
                    item.rawValue.localizedCapitalized,
                    value: item
                )
            }
        } detail: {
            // 3
            switch selectedSideBarItem {
            case .multiSelect:
                MultiSelectView()
            }
        }
    }
}
