//
//  ApartmentsListScreen.swift
//  Hotel
//
//  Created by Чебупелина on 28.09.2023.
//

import SwiftUI

struct ApartmensListScreen: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ApartmentRow(apartment: Apartment(images: [], name: "Стандартный с видом на бассейн или сад", labels: ["Всё включено", "Кондиционер"], price: 186600, priceName: "за 7 ночей с перелётом"))
                ApartmentRow(apartment: Apartment(images: [], name: "Стандартный с видом на бассейн или сад", labels: ["Всё включено", "Кондиционер"], price: 186600, priceName: "за 7 ночей с перелётом"))
                Spacer()
            }
        }
        .background(R.Colors.gray)
    }
}

// TODO: Вынести в Model
struct Apartment: Identifiable {
    let id = UUID()
    let images: [URL]
    let name: String
    let labels: [String]
    let price: Double
    let priceName: String
}

// TODO: Вынести во View
struct ApartmentRow: View {
    let apartment: Apartment
    var body: some View {
        BlockView {
            VStack(spacing: 0) {
                photos.padding(.bottom, 8)
                name.padding(.bottom, 8)
                labels.padding(.bottom, 8)
                aboutApartmentLabel.padding(.bottom, 16)
                price.padding(.bottom, 16)
                button
            }
            .padding(16)
        }
    }
}

private extension ApartmentRow {
    var photos: some View {
        PhotoCarouselView()
    }
    var name: some View {
        HStack {
            Text(apartment.name)
                .customFont(.sfProDisplay(.medium), ofSize: 22)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    var labels: some View {
        LabelsList(labels: apartment.labels)
    }
    
    var aboutApartmentLabel: some View {
        HStack {
            LinkedLabel(text: R.Strings.ApartmentsList.moreInfo)
            Spacer()
        }
    }
    
    var price: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Text("\(apartment.price.formatted) ₽")
                .sfProDisplayFont(ofWeight: 600, size: 30)
                .frame(height: 36)
            Text(apartment.priceName)
                .sfProDisplayFont(ofWeight: 400, size: 16)
                .foregroundColor(R.Colors.gray)
                .frame(height: 19)
                .padding(.bottom, 3)
            Spacer()
        }
    }
    
    var button: some View {
        GeneralButton(text: "Выбрать номер")
            .frame(height: 48)
    }
}



struct ApartmensListScreenPreview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ApartmensListScreen()
        }
    }
}
