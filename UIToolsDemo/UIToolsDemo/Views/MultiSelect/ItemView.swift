//
//  ItemView.swift
//  SelectionEdit
//
//  Created by David Card on 8/18/24.
//

import SwiftUI
import Combine

struct ItemView: View
{
    var item:Item
    var body: some View {
        GeometryReader {geometry in
            Text("\(item.id)")
        }

    }
}
