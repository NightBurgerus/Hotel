//
//  PhotoCarouselView.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct PhotoCarouselView: View {
    var photos = [Image("testImage1"), Image("testImage2"), Image("testImage2"), Image("testImage2"), Image("testImage2"), Image("testImage2"), Image("testImage2"), Image("testImage2")]
    @State private var currentSelection = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentSelection) {
                ForEach(0..<photos.count, id: \.self) { index in
                    photos[index]
                        .resizable()
                        .cornerRadius(15)
                        .frame(width: UIScreen.main.bounds.width - 32)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            tabSelection()
        }
        .frame(height: 257)
    }
    
    private func circle(opacity: Double) -> some View {
        Circle()
            .fill(Color.black.opacity(opacity))
            .frame(width: 7, height: 7)
    }
    
    private func tabSelection() -> some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<photos.count, id: \.self) { i in
                    circle(opacity: circleOpacity(index: i))
                        .padding([.vertical, .leading], 5)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
            .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
            .padding(.bottom, 8)
        }
    }
    
    private func circleOpacity(index: Int) -> Double {
        switch abs(currentSelection - index) {
        case 0: return 1.0
        case 1: return 0.22
        case 2: return 0.17
        case 3: return 0.1
        default: return 0.05
        }
    }
    
}
