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
            VStack(spacing: 0) {
                ApartmentRow(apartment: Apartment(images: [], name: "Стандартный с видом на бассейн или сад", labels: ["Всё включено", "Кондиционер"], price: 186600.5, priceName: "за 7 ночей с перелётом"))
                    .padding(.top, 8)
                ApartmentRow(apartment: Apartment(images: [], name: "Стандартный с видом на бассейн или сад", labels: ["Всё включено", "Кондиционер"], price: 186600, priceName: "за 7 ночей с перелётом"))
                    .padding(.top, 8)
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
    @EnvironmentObject private var coordinator: Coordinator
    let apartment: Apartment
    
    var body: some View {
        BlockView {
            VStack(spacing: 0) {
                photos.padding(.bottom, 8)
                Group {
                    name.padding(.bottom, 8)
                    labels.padding(.bottom, 8)
                    aboutApartmentLabel.padding(.bottom, 16)
                    price.padding(.bottom, 16)
                    button
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
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
                .customFont(.sfProDisplay(.semibold), ofSize: 30)
                .foregroundColor(.black)
                .frame(height: 36)
            Text(apartment.priceName)
                .customFont(.sfProDisplay(.regular), ofSize: 16)
                .foregroundColor(R.Colors.gray)
                .frame(height: 19)
                .padding(.bottom, 3)
            Spacer()
        }
    }
    
    var button: some View {
        GeneralButton(text: R.Strings.ApartmentsList.chooseApartment, action: {
            coordinator.push(.booking)
        })
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
