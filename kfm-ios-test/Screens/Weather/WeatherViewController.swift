//
//  WeatherViewController.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit
import RxSwift

internal final class WeatherViewController: ViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: WeatherViewModel?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    private let baseInformationView = BaseInformationView()
    private lazy var weekInformationView = WeekInformationView().then {
        $0.delegate = self
    }
    private lazy var logInformationView = LogInformationView().then {
        $0.delegate = self
    }
    
    init(viewModel: WeatherViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupStackView() {
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        stackView.addArrangedSubview(baseInformationView)
        stackView.addArrangedSubview(weekInformationView)
        stackView.addArrangedSubview(logInformationView)
    }
    
    private func setupView() {
        self.title = self.viewModel?.screenResult.city
        self.navigationItem.largeTitleDisplayMode = .never
        
        setupStackView()
        fetchWeathers()
        addActionButtonView()
    }
    
    private func addActionButtonView() {
        guard let woeid = self.viewModel?.screenResult.woeid else {
            return
        }
        let contains = UserDefaultConfig.locationData.contains(where: { item in
            item.meta.woeid == woeid
        })
        
        let navigationItemRightView = NavigationItemRightView(actionButtonType: contains ? .remove : .add)
        navigationItemRightView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationItemRightView)
    }
    
    private func fetchWeathers() {
        self.view.toggleLoadingIndicator()
        self.viewModel?.fetchWeathers()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.baseInformationView.data = response.consolidated_weather.first
                    self?.baseInformationView.timezone = response.timezone
                    self?.weekInformationView.data = response.consolidated_weather.filter({ item in
                        item.id != response.consolidated_weather.first?.id
                    })
                    self?.fetchWeatherToday()
                },
                onError: { [weak self] error in
                    self?.view.toggleLoadingIndicator()
                    self?.checkInternetConnection(error: error, action: {
                        self?.fetchWeathers()
                    })
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func fetchWeatherToday() {
        self.viewModel?.fetchLogWeather()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.view.toggleLoadingIndicator()
                    self?.logInformationView.data = response
                },
                onError: { [weak self] error in
                    self?.view.toggleLoadingIndicator()
                    self?.checkInternetConnection(error: error, action: {
                        self?.fetchWeathers()
                    })
                }
            )
            .disposed(by: disposeBag)
    }
}

extension WeatherViewController: WeekInformationViewDelegate {
    
    func didSelectDayItem(data: ConsolidatedWeather) {
        if let woeid = self.viewModel?.screenResult.woeid {
            let result = DetailScreenResultModel(woeid: woeid, isNeedToRequestHistories: true, consolidatedWeather: data)
            self.navigationEvent.send(.next(result))
        }
    }
}

extension WeatherViewController: LogInformationViewDelegate {
    
    func didSelectLogItem(data: ConsolidatedWeather) {
        if let woeid = self.viewModel?.screenResult.woeid {
            let result = DetailScreenResultModel(woeid: woeid, isNeedToRequestHistories: false, consolidatedWeather: data)
            self.navigationEvent.send(.next(result))
        }
    }
}

extension WeatherViewController: NavigationItemRightViewDelegate {
    
    func navigationItemRightAction(type: ActionButtonType) {
        switch type {
        case .add:
            navigationItemRightActionAdd(title: scAdd, message: scAddMessage)
        case .remove:
            navigationItemRightActionRemove(title: scRemove, message: scRemoveMessage)
        }
    }
    
    func navigationItemRightActionAdd(title: String, message: String) {
        self.showAlertWithAction(title: title, confirm: title, message: message) {
            guard let screen = self.viewModel?.screenResult, let data = self.baseInformationView.data else {
                return
            }
            
            let locationData = HomeScreenResultModel(meta: screen, data: data)
            UserDefaultConfig.locationData.append(locationData)
            self.navigationEvent.send(.prev(nil))
        }
    }
    
    func navigationItemRightActionRemove(title: String, message: String) {
        self.showAlertWithAction(title: title, confirm: title, message: message) {
            guard let screen = self.viewModel?.screenResult,
                  let index = UserDefaultConfig.locationData.firstIndex(where: { $0.meta.woeid == screen.woeid }) else {
                return
            }
            
            UserDefaultConfig.locationData.remove(at: index)
            self.navigationEvent.send(.prev(nil))
        }
    }
}
