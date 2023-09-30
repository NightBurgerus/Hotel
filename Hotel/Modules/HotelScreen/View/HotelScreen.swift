//
//  HotelScreen.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct HotelScreen<ViewModel>: View where ViewModel: HotelViewModelProtocol {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.loadingIndicator) private var showLoadingIndicator
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    mainBlock.padding(.bottom, 8)
                    aboutBlock.padding(.bottom, 12)
                    buttonSpacer
                    Spacer()
                }
            }
            .background(R.Colors.lightGray)
            button
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(R.Strings.Hotel.title)
                    .sfProDisplayFont(ofWeight: 500, size: 18)
            }
        }
        .onAppear {
            showLoadingIndicator.wrappedValue = true
            viewModel.loadData {
                showLoadingIndicator.wrappedValue = false
            }
        }
    }
}
