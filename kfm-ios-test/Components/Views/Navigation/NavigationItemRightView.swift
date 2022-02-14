//
//  NavigationItemRightView.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 14/02/22.
//

import UIKit

enum ActionButtonType {
    case add
    case remove
}

protocol NavigationItemRightViewDelegate: AnyObject {
    
    func navigationItemRightAction(type: ActionButtonType)
}

internal final class NavigationItemRightView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NavigationItemRightViewDelegate?
    private let actionButtonType: ActionButtonType
    
    private lazy var imageView = UIImageView().then {
        $0.tintColor = .systemBlue
    }
    
    private let actionButton = UIButton().then {
        $0.addTarget(self, action: #selector(onTapActionButton), for: .touchUpInside)
    }
    
    // MARK: - Constructor
    
    required init(actionButtonType: ActionButtonType) {
        self.actionButtonType = actionButtonType
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        setActionImage()
    }
    
    private func setActionImage() {
        let actionImage: UIImage
        switch self.actionButtonType {
        case .add:
            actionImage = .add
        case .remove:
            actionImage = .remove
        }
        
        imageView.image = actionImage
    }
    
    @objc private func onTapActionButton(_ sender: UIButton) {
        delegate?.navigationItemRightAction(type: self.actionButtonType)
    }
}
