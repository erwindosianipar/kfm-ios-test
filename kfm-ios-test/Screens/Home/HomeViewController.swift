//
//  HomeViewController.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

import UIKit
import RxSwift

internal final class HomeViewController: ViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var searchController = UISearchController().then {
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = scSearchPlaceholder
        $0.searchBar.delegate = self
    }
    
    private lazy var tableView = UITableView().then {
        $0.register(cell: UITableViewCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private var viewModel: HomeViewModel?
    
    let some = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    init(viewModel: HomeViewModel) {
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
    
    private func largeTitleAndSearchView() {
        title = scAppTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupView() {
        largeTitleAndSearchView()
        setupTableView()
    }
    
    private func removeTableViewData() {
        self.viewModel?.cities = []
        self.tableView.reloadData()
    }
    
    func searchCity(name: String) {
        self.view.toggleLoadingIndicator()
        self.viewModel?.searchCity(name: name)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.viewModel?.cities = response
                    self?.tableView.reloadData()
                    self?.view.toggleLoadingIndicator()
                },
                onError: { [weak self] error in
                    self?.removeTableViewData()
                    self?.view.toggleLoadingIndicator()
                    self?.showAlert(title: scError, message: error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            searchCity(name: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.removeTableViewData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.removeTableViewData()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cities = self.viewModel?.cities else {
            return 0
        }
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: UITableViewCell.self)
        cell.textLabel?.text = self.viewModel?.cities[indexPath.row].title
        
        return cell
    }
}
