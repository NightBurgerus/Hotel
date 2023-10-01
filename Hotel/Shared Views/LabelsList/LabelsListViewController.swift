//
//  LabelsListViewController.swift
//  Hotel
//
//  Created by Чебупелина on 30.09.2023.
//

import SwiftUI
import OSLog

/// __Контроллер списка лейблов__
/// Каждый лейбл добавляется в вертикальный стэк для определения размеров
/// Далее, пока все лейблы не будут добавлены в вертикальный стек заново,
/// эти лейблы "собираются" в строки (горизонтальные стеки).
/// Как только строка заполнена, она добавляется в вертикальный стек

final class LabelsListViewController<T: View>: UIViewController {
    @Binding var frame: CGRect
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    
    private var subviews = [T]()
    private let logger = Logger()
    
    init(subviews: [T],
         frame: Binding<CGRect>,
         horizontalSpacing: CGFloat,
         verticalSpacing: CGFloat) {
        self.subviews = subviews
        self._frame = frame
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
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
        if subviews.count == 0 {
            DispatchQueue.main.async {
                self.frame = CGRect.zero
            }
            return
        }
        for subview in subviews {
            
            let host = UIView(frame: view.frame)
            host.backgroundColor = UIColor.clear
            let vc = UIHostingController(rootView: subview)
            let uiSubview = vc.view!
            uiSubview.backgroundColor = UIColor.clear
            
            uiSubview.translatesAutoresizingMaskIntoConstraints = false
            host.addSubview(uiSubview)
            NSLayoutConstraint.activate([
                uiSubview.leadingAnchor.constraint(equalTo: host.leadingAnchor),
                uiSubview.topAnchor.constraint(equalTo: host.topAnchor)
            ])
            
            view.addSubview(host)
            
            vc.didMove(toParent: self)
        }
        
        DispatchQueue.main.async {
            self.collapceHostingViews()
            self.replace()
        }
   
    }
    
    private func collapceHostingViews() {
        for subview in view.subviews {
            let hosted = subview.subviews[0]
            subview.frame.size = hosted.bounds.size
        }
    }
    
    private func replace() {
        var rowWidth: CGFloat = view.subviews[0].frame.width
        for i in 1..<view.subviews.count {
            let subview = view.subviews[i]
            let prev = view.subviews[i - 1]
            
            let currentWidth = subview.frame.width
            let currentPosition = rowWidth + horizontalSpacing
            
            if currentPosition + currentWidth < view.frame.width {
                rowWidth += horizontalSpacing + currentWidth
                let y = prev.frame.origin.y
                let x = currentPosition
                let origin = CGPoint(x: x, y: y)
                    subview.frame.origin = origin
                
                continue
            }
            rowWidth = subview.frame.width
            let y = prev.frame.origin.y + prev.frame.height + verticalSpacing
            let x = 0.0
            let origin = CGPoint(x: x, y: y)
            subview.frame.origin = origin
            self.view.frame.size = CGSize(width: self.view.frame.width, height: subview.frame.maxY)
            self.frame = self.view.frame
            
        }
        
        var newFrame = CGRect(origin: view.frame.origin, size: .zero)
        let height = (view.subviews.last?.frame.maxY ?? 0.0)
        let newSize = CGSize(width: view.frame.width, height: height)
        newFrame.size = newSize
        frame = newFrame
    }
}

