//
//  ApartmentScreen.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct BookingScreen: View {
    @State private var touristes: [Tourist] = [Tourist()]
    @State private var phone = ""
    @State private var email = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                nameBlock.padding(.top, 8)
                bookingBlock.padding(.top, 8)
                buyerBlock.padding(.top, 8)
                touristesBlock
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
                    PhoneTextField(phone: $phone)
                    GeneralTextField(title: "Почта", placeholder: "Почта", text: $email)
                }.padding(.bottom, 8)
                
                dataDontTransferLabel
            }
            .padding(16)
        }
    }
}

// MARK: - Touristes Block
private extension BookingScreen {
    struct Tourist: Identifiable {
        let id = UUID()
        var name: String
        var lastName: String
        var dateOfBirth: String
        var citizenship: String
        var number: String
        var dateOfNumber: String
        
        init() {
            name = ""
            lastName = ""
            dateOfBirth = ""
            citizenship = ""
            number = ""
            dateOfNumber = ""
        }
    }
    
    struct TouristBlock: View {
        let number: Int
        @Binding var tourist: Tourist
        @State private var isOpen = true
        
        var body: some View {
            BlockView {
                VStack {
                    title
                    
                    if isOpen {
                        GeneralTextField(title: "Имя", placeholder: "Имя", text: $tourist.name)
                        GeneralTextField(title: "Фамилия", placeholder: "Фамилия", text: $tourist.lastName)
                        GeneralTextField(title: "Дата рождения", placeholder: "Дата рождения", text: $tourist.dateOfBirth)
                        GeneralTextField(title: "Гражданство", placeholder: "Гражданство", text: $tourist.citizenship)
                        GeneralTextField(title: "Номер загранпаспорта", placeholder: "Номер загранпаспорта", text: $tourist.number)
                        GeneralTextField(title: "Срок действия загранпаспорта", placeholder: "Срок действия загранпаспорта", text: $tourist.dateOfNumber)
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
                Text("Добавить туриста")
                    .customFont(.sfProDisplay(.medium), ofSize: 22)
                    .foregroundColor(.black)
                Spacer()
                R.Images.AddButton
                    .contentShape(Rectangle())
                    .onTapGesture {
                        touristes.append(Tourist())
                    }
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 16)
        }
    }
    
    var touristesBlock: some View {
        VStack(spacing: 0) {
            ForEach(0..<touristes.count, id: \.self) { i in
                TouristBlock(number: i + 1, tourist: $touristes[i]).padding(.top, 8)
            }
            addTourist.padding(.top, 8)
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
