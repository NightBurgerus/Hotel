//
//  HotelScreen.swift
//  Hotel
//
//  Created by Чебупелина on 26.09.2023.
//

import SwiftUI

struct HotelScreen<ViewModel>: View where ViewModel: HotelViewModelProtocol {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    mainBlock.padding(.bottom, 8)
                    aboutBlock.padding(.bottom, 12)
                    buttonSpacer
                    Spacer()
                }
            }
            .background(R.Colors.lightGray)
            button
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(R.Strings.Hotel.title)
                    .sfProDisplayFont(ofWeight: 500, size: 18)
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

// MARK: - Main block
private extension HotelScreen {
    var hotelNameView: some View {
        HStack {
            Text(viewModel.info?.name ?? "")
                .sfProDisplayFont(ofWeight: 500, size: 22)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(height: 26)
    }
    
    var hotelAddressView: some View {
        Button {
            
        } label: {
            HStack {
                Text(viewModel.info?.adress ?? "")
                    .sfProDisplayFont(ofWeight: 500, size: 14)
                    .foregroundColor(R.Colors.blue)
                Spacer()
            }
            .frame(height: 17)
        }
    }
    
    var hotelPriceView: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Text("от \((viewModel.info?.minimalPrice ?? 0.0).formatted) ₽")
                .sfProDisplayFont(ofWeight: 600, size: 30)
                .frame(height: 36)
            Text(viewModel.info?.priceForIt ?? "")
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
                PhotoCarouselView(photos: viewModel.info?.imageUrls ?? [])
                    .padding(.bottom, 16)
                Group {
                    RatingView(rating: viewModel.info?.rating ?? 0.0, ratingName: viewModel.info?.ratingName ?? "-")
                        .padding(.bottom, 8)
                    hotelNameView.padding(.bottom, 8)
                    hotelAddressView.padding(.bottom, 16)
                    hotelPriceView.padding(.bottom, 16)
                }
                .padding(.horizontal, 16)
            }
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
        LabelsList(labels: viewModel.info?.aboutTheHotel.peculiarities ?? [])
    }
    
    var hotelInfo: some View {
        HStack {
            Text(viewModel.info?.aboutTheHotel.description ?? "")
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

// MARK: - Bottom button
private extension HotelScreen {
    var buttonSpacer: some View {
        GeneralButton(text: R.Strings.Hotel.toApartmentChoose)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 28, trailing: 16))
            .overlay(R.Colors.lightGray)
    }
    var button: some View {
        VStack {
            Spacer()
                
            GeneralButton(text: R.Strings.Hotel.toApartmentChoose, action: {
                coordinator.push(.apartmentsList)
            })
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 28, trailing: 16))
            .background(Color.white)
            .border(R.Colors.gray232)
        }
    }
}

