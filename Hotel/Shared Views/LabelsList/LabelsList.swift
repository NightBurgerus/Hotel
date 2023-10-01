//
//  LabelsList.swift
//  Hotel
//
//  Created by Чебупелина on 27.09.2023.
//

import SwiftUI
import UIKit

/// __Список лейблов__
/// "Кондиционер", "30 км от моря" и так далее
/// Для отображения используется __LabelsListViewController__

struct LabelsList: View {
    var labels: [String]
    var horizontalSpacing: CGFloat = 5
    var verticalSpacing: CGFloat = 5
    @State private var frame = CGRect.zero
    
    var body: some View {
        LabelsListBridge(frame: $frame,
                         horizontalSpacing: horizontalSpacing,
                         verticalSpacing: verticalSpacing,
                         subviews: labels.map {
                            GeneralLabel(text: $0)
                        })
                        .frame(minWidth: frame.width, minHeight: frame.height)
    }
}

struct LabelsListBridge<T: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = LabelsListViewController
    @Binding var frame: CGRect
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    let subviews: [T]
    
    func makeUIViewController(context: Context) -> LabelsListViewController<T> {
        return LabelsListViewController(subviews: subviews,
                                        frame: $frame,
                                        horizontalSpacing: horizontalSpacing,
                                        verticalSpacing: verticalSpacing)
    }
    func updateUIViewController(_ uiViewController: LabelsListViewController<T>, context: Context) {
    }
}



