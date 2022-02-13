//
//  DetailViewController.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit
import RxSwift

internal final class DetailViewController: ViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: DetailViewModel?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    private let baseInformationView = BaseInformationView()
    private let logInformationView = LogInformationView()
    
    init(viewModel: DetailViewModel) {
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
        stackView.addArrangedSubview(logInformationView)
    }
    
    private func checkIfNeedRequestLogItem() {
        if let needRequestLog = self.viewModel?.screenModel.isNeedToRequestHistories, needRequestLog {
            fetchLogWeather()
        }
    }
    
    private func setupView() {
        setupStackView()
        
        if let data = self.viewModel?.screenModel.consolidatedWeather {
            baseInformationView.data = data
        }
        
        checkIfNeedRequestLogItem()
    }
    
    private func fetchLogWeather() {
        self.view.toggleLoadingIndicator(true)
        self.viewModel?.fetchLogWeather()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.view.toggleLoadingIndicator(true)
                    self?.logInformationView.data = response
                },
                onError: { [weak self] error in
                    self?.view.toggleLoadingIndicator(true)
                    self?.checkInternetConnection(error: error, action: {
                        self?.fetchLogWeather()
                    })
                }
            )
            .disposed(by: disposeBag)
    }
}
