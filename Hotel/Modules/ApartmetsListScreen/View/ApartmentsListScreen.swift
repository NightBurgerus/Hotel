//
//  ApartmentsListScreen.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct ApartmensListScreen<ViewModel>: View where ViewModel: ApartmentsListViewModelProtocol {
    @StateObject var viewModel: ViewModel
    @Environment(\.loadingIndicator) private var showLoadingIndicator
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(0..<viewModel.rooms.count, id: \.self) { i in
                    ApartmentRow(apartment: viewModel.rooms[i])
                        .padding(.top, 8)
                }
                Spacer()
            }
        }
        .background(R.Colors.lightGray)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            
            ToolbarItem(placement: .principal) {
                Text(R.Strings.ApartmentsList.title)
                    .customFont(.sfProDisplay(.medium), ofSize: 18)
                    .foregroundColor(Color.black)
            }
        }
        .onAppear {
            showLoadingIndicator.wrappedValue = true
            viewModel.getApartments {
                showLoadingIndicator.wrappedValue = false
            }
        }
    }
}
