//
//  LogInformationView.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

protocol LogInformationViewDelegate: AnyObject {
    func didSelectLogItem(data: ConsolidatedWeather)
}

internal final class LogInformationView: UIView {
    
    weak var delegate: LogInformationViewDelegate?
    
    var data: [ConsolidatedWeather] = [] {
        didSet {
            collectionView.reloadData()
            logInformationLabel.text = scWeatherHistories
        }
    }
    
    private let logInformationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.getLayout(type: .log)
        let cellView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellView.register(cell: LogWeatherItemCollectionViewCell.self)
        cellView.backgroundColor = .systemBackground
        cellView.showsHorizontalScrollIndicator = false
        cellView.delegate = self
        cellView.dataSource = self
        
        return cellView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        addSubviews(logInformationLabel, collectionView)
        logInformationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(logInformationLabel.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

extension LogInformationView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectLogItem(data: data[indexPath.row])
    }
}

extension LogInformationView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cell: LogWeatherItemCollectionViewCell.self)
        cell.data = data[indexPath.row]
        
        return cell
    }
}
