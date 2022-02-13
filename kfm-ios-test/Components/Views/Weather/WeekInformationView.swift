//
//  WeekInformationView.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

protocol WeekInformationViewDelegate: AnyObject {
    func didSelectDayItem(data: ConsolidatedWeather)
}

internal final class WeekInformationView: UIView {
    
    weak var delegate: WeekInformationViewDelegate?
    
    var data: [ConsolidatedWeather] = [] {
        didSet {
            collectionView.reloadData()
            weekInformationLabel.text = scForecastThisWeek
        }
    }
    
    private let weekInformationLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.getLayout(type: .weather)
        let cellView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellView.register(cell: DayWeatherItemCollectionViewCell.self)
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
        addSubviews(weekInformationLabel, collectionView)
        weekInformationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(weekInformationLabel.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(165)
        }
    }
}

extension WeekInformationView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectDayItem(data: data[indexPath.row])
    }
}

extension WeekInformationView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cell: DayWeatherItemCollectionViewCell.self)
        cell.data = data[indexPath.row]
        
        return cell
    }
}
