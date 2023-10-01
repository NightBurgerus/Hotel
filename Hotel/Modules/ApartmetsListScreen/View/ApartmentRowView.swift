//
//  ApartmentRowView.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

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
        PhotoCarouselView(photos: apartment.imageUrls)
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
        HStack {
            LabelsList(labels: apartment.peculiarities)
                .frame(width: UIScreen.main.bounds.width - 32)
            Spacer()
        }
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
            Text(apartment.pricePer)
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
