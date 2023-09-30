//
//  LabelsListViewController.swift
//  Hotel
//
//  Created by Чебупелина on 30.09.2023.
//

import SwiftUI

/// __Контроллер списка лейблов__
/// Каждый лейбл добавляется в вертикальный стэк для определения размеров
/// Далее, пока все лейблы не будут добавлены в вертикальный стек заново,
/// эти лейблы "собираются" в строки (горизонтальные стеки).
/// Как только строка заполнена, она добавляется в вертикальный стек

final class LabelsListViewController<T: View>: UIViewController {
    @Binding var frame: CGRect
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat
    
    private var verticalStack = UIStackView()
    private var uiSubviews = [UIView]()
    private var subviews = [T]()
    
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
        verticalStack.axis = .vertical
        verticalStack.spacing = verticalSpacing
        view.addSubview(verticalStack)
        constraint(verticalStack, to: view)
        
        for subview in self.subviews {
            let uiSubview = UIHostingController(rootView: subview).view!
            let row = newRow()
            row.addArrangedSubview(uiSubview)
            row.addArrangedSubview(UIView())
            verticalStack.addArrangedSubview(row)
            uiSubviews.append(uiSubview)
        }
        
        DispatchQueue.main.async {
            self.makeRows()
            self.frame = self.verticalStack.frame
        }
    }
    
    private func makeRows() {
        var currentRow = newRow()
        let verticalStackWidth = verticalStack.frame.width
        clearVerticalStack()
        for uiSubview in uiSubviews {
            if currentRow.subviews.map({ $0.bounds.width }).reduce(0, +) + uiSubview.bounds.width < verticalStackWidth {
                currentRow.addArrangedSubview(uiSubview)
                continue
            }
            currentRow.addArrangedSubview(UIView())
            verticalStack.addArrangedSubview(currentRow)
            currentRow = newRow()
            currentRow.addArrangedSubview(uiSubview)
        }
        currentRow.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(currentRow)
        verticalStack.layoutIfNeeded()
    }
    
    private func clearVerticalStack() {
        verticalStack.subviews.forEach({ row in
            row.subviews.forEach { $0.removeFromSuperview() }
            row.removeFromSuperview()
        })
        let currentWidth = verticalStack.frame.width
        verticalStack.frame.size = CGSize(width: currentWidth, height: 0)
    }
    
    private func constraint(_ view: UIView, to superview: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
    private func newRow() -> UIStackView {
        let newRow = UIStackView()
        newRow.axis = .horizontal
        newRow.spacing = horizontalSpacing
        
        verticalStack.addArrangedSubview(newRow)
        constraint(newRow, to: verticalStack)

        return newRow
    }
}
