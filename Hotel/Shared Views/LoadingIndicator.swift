//
//  LoadingIndicator.swift
//  Hotel
//
//  Created by Чебупелина on 30.09.2023.
//

import SwiftUI

/// __ Простой индикатор загрузки__

struct LoadingIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = LoadingIndicatorController
    
    func makeUIViewController(context: Context) -> LoadingIndicatorController {
        return LoadingIndicatorController()
    }
    
    func updateUIViewController(_ uiViewController: LoadingIndicatorController, context: Context) {
    }
}

final class LoadingIndicatorController: UIViewController {
    private let loadingIndicator = UIActivityIndicatorView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        loadingIndicator.style = .large
        loadingIndicator.color = UIColor(R.Colors.blue)
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loadingIndicator.startAnimating()
    }
    
    deinit {
        loadingIndicator.removeFromSuperview()
    }
}
