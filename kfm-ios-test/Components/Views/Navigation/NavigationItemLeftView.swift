//
//  NavigationItemLeftView.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

protocol NavigationItemLeftViewDelegate: AnyObject {
    
    func navigationItemLeftAction()
}

internal final class NavigationItemLeftView: UIView {
    
    weak var delegate: NavigationItemLeftViewDelegate?
    
    private let imageView = UIImageView().then {
        $0.image = .chevronLeft
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .systemBlue
    }
    
    private let actionButton = UIButton().then {
        $0.addTarget(self, action: #selector(onTapActionButton), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        addSubviews(imageView, actionButton)
        
        imageView.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        
        actionButton.snp.makeConstraints {
            $0.top.right.bottom.left.equalTo(imageView)
        }
    }
    
    @objc private func onTapActionButton(_ sender: UIButton) {
        delegate?.navigationItemLeftAction()
    }
}
