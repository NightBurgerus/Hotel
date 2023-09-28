//
//  ApartmentScreen.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct BookingScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                nameBlock.padding(.top, 8)
                bookingBlock.padding(.top, 8)
                buyerBlock.padding(.top, 8)
            }
        }
        .background(R.Colors.gray)
    }
}

// MARK: - Name Block
private extension BookingScreen {
    var rating: some View {
        RatingView(rating: 5, ratingName: "Превосходно")
    }
    
    var name: some View {
        HStack {
            Text("Steigenberger Makadi")
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
                Text("Madinat Makadi, Safaga Road, Makadi Bay, Египет")
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
    var data: [(row: String, data: String)] {
        [
            ("Вылет из", "Санкт-Петербург"),
            ("Страна, город", "Египет, Хургада"),
            ("Даты", "19.09.2023 – 27.09.2023"),
            ("Кол-во ночей", "7 ночей"),
            ("Отель", "Steigenberger Makadi"),
            ("Номер", "Стандартный с видом на бассейн или сад"),
            ("Питание", "Все включено")
        ]
    }
    var bookingBlock: some View {
        BlockView {
            VStack {
                LazyVGrid(columns: [GridItem(.fixed(130), alignment: .topLeading), GridItem(.flexible(), alignment: .topLeading)], spacing: 16) {
                    ForEach(0..<data.count, id: \.self) { i in
                        Text(data[i].row)
                            .customFont(.sfProDisplay(.regular), ofSize: 16)
                            .foregroundColor(R.Colors.gray)
                        Text(data[i].data)
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
                    PhoneTextField(phone: .constant(""))
                    GeneralTextField(title: "Почта", placeholder: "examplemail.000@mail.ru", text: .constant(""))
                }.padding(.bottom, 8)
                
                dataDontTransferLabel
            }
            .padding(16)
        }
    }
}



struct ApartmentScreenPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookingScreen()
        }
    }
}
