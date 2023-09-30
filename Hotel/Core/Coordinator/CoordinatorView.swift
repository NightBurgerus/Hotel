//
//  CoordinatorView.swift
//  Hotel
//
//  Created by Чебупелина on 29.09.2023.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    @State private var animating = false
    
    var body: some View {
        ZStack {
            NavigationStack(path: $coordinator.path) {
                coordinator.build(page: .hotel)
                    .navigationDestination(for: Page.self) { page in
                        coordinator.build(page: page)
                    }
            }
            .environmentObject(coordinator)
            .environment(\.loadingIndicator, $animating)
            .onAppear {
                // Белый фон у навбара
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = UIColor.white
                
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
            }
            
            if animating {
                LoadingIndicator()
            }
        }
    }
}

struct ShowLoadingIndicator: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(false)
}
extension EnvironmentValues {
    var loadingIndicator: Binding<Bool> {
        get { self[ShowLoadingIndicator.self] }
        set { self[ShowLoadingIndicator.self] = newValue }
    }
}
