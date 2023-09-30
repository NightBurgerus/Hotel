//
//  BookingScreen+Subviews.swift
//  Hotel
//
//  Created by Чебупелина on 30.09.2023.
//

import SwiftUI


// MARK: - Name Block
extension BookingScreen {
    var rating: some View {
        RatingView(rating: viewModel.rating, ratingName: viewModel.ratingName)
    }
    
    var name: some View {
        HStack {
            Text(viewModel.hotelName)
                .customFont(.sfProDisplay(.medium), ofSize: 22)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    
    var address: some View {
        Button {
            print("~ address")
        } label: {
            HStack {
                Text(viewModel.hotelAddress)
                    .customFont(.sfProDisplay(.medium), ofSize: 14)
                    .foregroundColor(R.Colors.blue)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
    }
    
    var nameBlock: some View {
        BlockView {
            VStack(spacing: 8) {
                rating
                name
                address
            }
            .padding(16)
        }
    }
}

// MARK: - Booking Info
extension BookingScreen {
    var bookingBlock: some View {
        BlockView {
            VStack {
                LazyVGrid(columns: [GridItem(.fixed(130), alignment: .topLeading), GridItem(.flexible(), alignment: .topLeading)], spacing: 16) {
                    ForEach(0..<viewModel.departmentInfo.count, id: \.self) { i in
                        Text(viewModel.departmentInfo[i].row)
                            .customFont(.sfProDisplay(.regular), ofSize: 16)
                            .foregroundColor(R.Colors.gray)
                        Text(viewModel.departmentInfo[i].data)
                            .customFont(.sfProDisplay(.regular), ofSize: 16)
                            .foregroundColor(Color.black)
                    }
                }
            }
            .padding(16)
        }
    }
}

// MARK: - Buyer Info
extension BookingScreen {
    var buyerInfoLabel: some View {
        HStack {
            Text(R.Strings.Booking.buyerInfo)
                .customFont(.sfProDisplay(.medium), ofSize: 22)
            Spacer()
        }
    }
    
    var dataDontTransferLabel: some View {
        HStack {
            Text(R.Strings.Booking.dataDontTransfer)
                .customFont(.sfProDisplay(.regular), ofSize: 14)
                .foregroundColor(R.Colors.gray)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    
    var buyerBlock: some View {
        BlockView {
            VStack(spacing: 0) {
                buyerInfoLabel.padding(.bottom, 20)
                VStack(spacing: 8) {
                    PhoneTextField(phone: $viewModel.phoneNumber, isFirstResponder: $viewModel.phoneIsFirstResponder, error: $viewModel.phoneError)
                    GeneralTextField(title: R.Strings.Booking.email, placeholder: R.Strings.Booking.email, text: $viewModel.email, error: $viewModel.emailError, isFirstResponder: $viewModel.emailIsFirstResponder)
                }.padding(.bottom, 8)
                
                dataDontTransferLabel
            }
            .padding(16)
        }
    }
}

// MARK: - Touristes Block
extension BookingScreen {
    var addTourist: some View {
        BlockView {
            HStack {
                Text(R.Strings.Booking.addTourist)
                    .customFont(.sfProDisplay(.medium), ofSize: 22)
                    .foregroundColor(.black)
                Spacer()
                R.Images.AddButton
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)) {
                            self.viewModel.addTourist()
                        }
                    }
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 16)
        }
    }
    
    var touristesBlock: some View {
        VStack(spacing: 0) {
            ForEach(0..<viewModel.tourists.count, id: \.self) { i in
                TouristBlock(number: i + 1, tourist: $viewModel.tourists[i])
                    .padding(.top, 8)
            }
            addTourist.padding(.top, 8)
        }
    }
}

// MARK: - Total Block
extension BookingScreen {
    func totalRow(_ info: String, price: Double) -> some View {
        HStack {
            Text(info)
                .customFont(.sfProDisplay(.regular), ofSize: 16)
                .foregroundColor(R.Colors.gray)
            Spacer()
            Text("\(price.formatted) ₽")
                .customFont(.sfProDisplay(.regular), ofSize: 16)
                .foregroundColor(.black)
        }
    }
    
    func totalPrice(_ price: Double) -> some View {
        HStack {
            Text(R.Strings.Booking.toPay)
                .customFont(.sfProDisplay(.regular), ofSize: 16)
                .foregroundColor(R.Colors.gray)
            Spacer()
            Text("\(price.formatted) ₽")
                .customFont(.sfProDisplay(.semibold), ofSize: 16)
                .foregroundColor(R.Colors.blue)
        }
    }
    var totalBlock: some View {
        BlockView {
            VStack(spacing: 16) {
                totalRow(R.Strings.Booking.tour, price: 186600)
                totalRow(R.Strings.Booking.fuelCollection, price: 9300)
                totalRow(R.Strings.Booking.serviceFee, price: 2136)
                totalPrice(198036)
            }
            .padding(16)
        }
    }
}

// MARK: - Bottom Button
extension BookingScreen {
    var buttonSpacer: some View {
        GeneralButton(text: "\(R.Strings.Booking.pay) \(viewModel.totalPrice) ₽")
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 28, trailing: 16))
            .overlay(R.Colors.gray096)
    }
    var button: some View {
        VStack {
            Spacer()
                
            GeneralButton(text: "\(R.Strings.Booking.pay) \(viewModel.totalPrice)", action: payButtonPressed)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 28, trailing: 16))
                .background(Color.white)
                .border(R.Colors.gray232)
        }
    }
    
    private func payButtonPressed() {
        if viewModel.checkFields() {
            return
        }
        coordinator.push(.orderPaid)
    }
}
