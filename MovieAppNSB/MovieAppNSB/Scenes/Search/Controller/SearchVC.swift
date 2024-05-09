//
//  SearchVC.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit


final class SearchVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        return tv
    }()
    
    
    // MARK: - Properties
    
    private let viewModel : SearchViewModel
    
    // MARK: - LifeCycle
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension SearchVC {
    private func setupUI(){
        drawDesign()
        setupNavBar()
        
    }
    private func drawDesign(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.reuseID)
        
        viewModel.delegate = self
        
        
    }
    
    // Navigasyon çubuğunu yapılandırır: büyük başlıkları tercih eder ve her zaman büyük başlık modunu kullanır.
    private func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always // navigationController?.navigationItem değil, doğrudan navigationItem kullanın.
        title = "Search"
    }

    
    private func fetchData(){
        viewModel.fetchData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource Protocol

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.discoverMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.reuseID, for: indexPath) as? SearchTableCell else{
            return UITableViewCell()
        }
        cell.movie = viewModel.discoverMoviesArray[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height / 4 )
    }
    
}


extension SearchVC: SearchViewModelDelegate{
    func didFinish() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else{return}
            self.tableView.reloadData()
        }
    }
    
    func didFail(_ error: Error) {
        print(error.localizedDescription)
    }
}
