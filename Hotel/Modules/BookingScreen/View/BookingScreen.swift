//
//  ApartmentScreen.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI


// TODO: Сделать шапку белой
struct BookingScreen<ViewModel>: View where ViewModel: BookingViewModelProtocol {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.loadingIndicator) private var showLoadingIndicator
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    nameBlock.padding(.top, 8)
                    bookingBlock.padding(.top, 8)
                    buyerBlock.padding(.top, 8)
                    touristesBlock
                    totalBlock.padding(.top, 8)
                    buttonSpacer.padding(.top, 10)
                }
            }
            .background(R.Colors.gray096)
            
            button
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitleDisplayMode(.inline)
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            
            ToolbarItem(placement: .principal) {
                Text(R.Strings.Booking.title)
                    .customFont(.sfProDisplay(.medium), ofSize: 18)
                    .foregroundColor(Color.black)
            }
        }
        .onAppear {
            showLoadingIndicator.wrappedValue = true
            viewModel.getInfo {
                showLoadingIndicator.wrappedValue = false
            }
        }
    }
}
