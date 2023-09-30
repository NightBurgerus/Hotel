//
//  ApartmentScreen.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI


// TODO: Сделать шапку белой
struct BookingScreen<ViewModel>: View where ViewModel: BookingViewModelProtocol {
    @EnvironmentObject private var coordinator: Coordinator
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

// MARK: - Name Block
private extension BookingScreen {
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
private extension BookingScreen {
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
private extension BookingScreen {
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
private extension BookingScreen {
    
    struct TouristBlock: View {
        let number: Int
        @Binding var tourist: TouristFieldModel
        @State private var isOpen = true
        
        var body: some View {
            BlockView {
                VStack {
                    title
                    
                    if isOpen {
                        GeneralTextField(title: R.Strings.Booking.name, placeholder: R.Strings.Booking.name, text: $tourist.value.name, error: $tourist.nameError, isFirstResponder: $tourist.nameIsFirstResponder)
                        
                        GeneralTextField(title: R.Strings.Booking.lastName, placeholder: R.Strings.Booking.lastName, text: $tourist.value.lastName, error: $tourist.lastNameError, isFirstResponder: $tourist.lastNameIsFirstResponder)
                        
                        DateTextField(title: R.Strings.Booking.dateOfBirth, placeholder: R.Strings.Booking.dateOfBirth, text: $tourist.value.dateOfBirth, error: $tourist.dateOfBirthError)
                        
                        GeneralTextField(title: R.Strings.Booking.citizenship, placeholder: R.Strings.Booking.citizenship, text: $tourist.value.citizenship, error: $tourist.citizenshipError, isFirstResponder: $tourist.citizenshipIsFirstResponder)
                        
                        PassportTextField(title: R.Strings.Booking.passportNumber, placeholder: R.Strings.Booking.passportNumber, text: $tourist.value.passportNumber, error: $tourist.passportError)
                        
                        DateTextField(title: R.Strings.Booking.dateOfPassport, placeholder: R.Strings.Booking.dateOfPassport, text: $tourist.value.dateOfPassport, error: $tourist.dateOfPassportError)
                    }
                }
                .padding(16)
            }
        }
        
        private var title: some View {
            HStack {
                Text(String.sequenceNumber(number) + " турист")
                    .customFont(.sfProDisplay(.medium), ofSize: 22)
                    .foregroundColor(.black)
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(R.Colors.blue.opacity(0.1))
                    
                    R.Images
                        .ArrowRightImage
                        .rotationEffect(.degrees(isOpen ? 90 : -90))
                }
                .frame(width: 32, height: 32)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        self.isOpen.toggle()
                    }
                }
            }
        }
    }
    
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
private extension BookingScreen {
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
private extension BookingScreen {
    var buttonSpacer: some View {
        GeneralButton(text: "\(R.Strings.Booking.pay) 198 036 ₽")
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 28, trailing: 16))
            .overlay(R.Colors.gray096)
    }
    var button: some View {
        VStack {
            Spacer()
                
            GeneralButton(text: "\(R.Strings.Booking.pay) 198 036 ₽", action: payButtonPressed)
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
