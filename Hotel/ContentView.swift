//
//  ContentView.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ApartmensListScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
