//
//  HotelScreen.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct HotelScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                mainBlock.padding(.bottom, 8)
                aboutBlock
                Spacer()
            }
        }
        .background(R.Colors.gray)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(R.Strings.Hotel.title)
                    .sfProDisplayFont(ofWeight: 500, size: 18)
            }
        }
    }
}

// MARK: - Main block
private extension HotelScreen {
    var hotelNameView: some View {
        HStack {
            Text("Steigenberger Makadi")
                .sfProDisplayFont(ofWeight: 500, size: 22)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 26)
    }
    
    var hotelAddressView: some View {
        HStack {
            Text("Madinat Makadi, Safaga Road, Makadi Bay, Египет")
                .sfProDisplayFont(ofWeight: 500, size: 14)
                .foregroundColor(R.Colors.blue)
            Spacer()
        }
        .frame(height: 17)
    }
    
    var hotelPriceView: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Text("от 134 673 ₽")
                .sfProDisplayFont(ofWeight: 600, size: 30)
                .frame(height: 36)
            Text("за тур с перелётом")
                .sfProDisplayFont(ofWeight: 400, size: 16)
                .foregroundColor(R.Colors.gray)
                .frame(height: 19)
                .padding(.bottom, 3)
            Spacer()
        }
    }
    
    var mainBlock: some View {
        BlockView(roundedCorners: [.bottomLeft, .bottomRight]) {
            VStack(spacing: 0) {
                PhotoCarouselView()
                    .padding(.bottom, 16)
                RatingView(rating: 5, ratingName: "Превосходно")
                    .padding(.bottom, 8)
                hotelNameView.padding(.bottom, 8)
                hotelAddressView.padding(.bottom, 16)
                hotelPriceView.padding(.bottom, 16)
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - About Hotel
private extension HotelScreen {
    var aboutLabel: some View {
        HStack {
            Text(R.Strings.Hotel.aboutHotel)
                .sfProDisplayFont(ofWeight: 500, size: 22)
            Spacer()
        }
    }
    
    var labels: some View {
        LabelsList(labels: ["3-я линия", "Платный Wi-Fi в фойе", "30 км до аэропорта", "1 км до пляжа"])
    }
    
    var hotelInfo: some View {
        HStack {
            Text("Отель VIP-класса с собственными гольф полями. Высокий уровнь сервиса. Рекомендуем для респектабельного отдыха. Отель принимает гостей от 18 лет!")
                .customFont(.sfProDisplay(.regular), ofSize: 16)
                .foregroundColor(Color.black.opacity(0.9))
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    
    var detailsInfo: some View {
        BlockView(backgroundColor: R.Colors.lightGray, cornerRadius: 15) {
            VStack(spacing: 10) {
                detailInfoRow(DetailsRowInfo.conveniences)
                detailInfoRow(DetailsRowInfo.included)
                detailInfoRow(DetailsRowInfo.notIncluded, hasDivider: false)
            }
            .padding(15)
        }
    }
    
    // TODO: Вынести в Model
    struct DetailsRowInfo {
        let image: Image
        let title: String
        let subtitle: String
        
        static let conveniences = DetailsRowInfo(image: R.Images.HappyEmoji, title: R.Strings.Hotel.conveniences, subtitle: R.Strings.Hotel.conveniencesSubtitle)
        
        static let included = DetailsRowInfo(image: R.Images.TickSquare, title: R.Strings.Hotel.included, subtitle: R.Strings.Hotel.includedSubtitle)
        
        static let notIncluded = DetailsRowInfo(image: R.Images.CloseSquare, title: R.Strings.Hotel.notIncluded, subtitle: R.Strings.Hotel.notIncludedSubtitle)
    }
    
    func detailInfoRow(_ info: DetailsRowInfo, hasDivider: Bool = true) -> some View {
        // TODO: вынести всю инфу в ВМ
        Button {
            print("~ info tap")
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    info.image.padding(.trailing, 12)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(info.title)
                            .customFont(.sfProDisplay(.medium), ofSize: 16)
                            .foregroundColor(R.Colors.darkGray)
                        Text(info.subtitle)
                            .customFont(.sfProDisplay(.medium), ofSize: 14)
                            .foregroundColor(R.Colors.gray)
                    }
                    Spacer()
                    R.Images.ArrowRightImage
                        .colorMultiply(Color.black)
                        .padding(.trailing, 8)
                }
                if hasDivider {
                    Divider()
                        .padding(.leading, 24 + 12)
                        .padding(.top, 10)
                }
            }
        }
    }
    
    var aboutBlock: some View {
        BlockView {
            VStack(spacing: 0) {
                aboutLabel.padding(.bottom, 16)
                labels.padding(.bottom, 12)
                hotelInfo.padding(.bottom, 16)
                detailsInfo
            }
            .padding(16)
        }
    }
}

struct HotelScreenPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotelScreen()
        }
    }
}
