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
    
    
    private lazy var searchController : UISearchController = {
        let sc = UISearchController(searchResultsController: SearchResultController())
        sc.searchBar.placeholder = "Search for a Tv or a Movie"
        sc.searchBar.searchBarStyle = .prominent
        return sc
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
        
        // arama sonuçlarını güncellemek için delege belirttik. UISearchResultsUpdating Protokolü engtegre edeceğim
        searchController.searchResultsUpdater = self
        
        
    }
    
    // Navigasyon çubuğunu yapılandırır: büyük başlıkları tercih eder ve her zaman büyük başlık modunu kullanır.
    private func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always // navigationController?.navigationItem değil, doğrudan navigationItem kullanın.
        title = "Search"
        
        // SearchController
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
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

// MARK: - SearchViewModelDelegate Protocol
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


// MARK: - UISearchResultsUpdating Protocol

extension SearchVC: UISearchResultsUpdating {
    // Arama sonuçlarını güncellemek için UISearchResultsUpdating protokolünün gereksinimlerini karşılayan metod.
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar  // Arama çubuğunu al
        
        // Arama sorgusunu al, başında ve sonunda boşluk karakterleri varsa kaldır ve boş olup olmadığını kontrol et
        guard let query = searchBar.text?.trimmingCharacters(in: .whitespaces), !query.isEmpty, query.count >= 3,
              // Arama sonuçlarını gösterecek olan SearchResultController'ı al
              let resultsController = searchController.searchResultsController as? SearchResultController
        else { return }
        
        fetchSearch(searchQuery: query, resultController: resultsController)
    }
    
    // Belirli bir arama sorgusuyla arama sonuçlarını almak için özel bir fonksiyon
    private func fetchSearch(searchQuery: String, resultController: SearchResultController) {
        // MovieNetwork'ten arama sonuçlarını almak için bir ağ çağrısı yap
        viewModel.search(searchQuery: searchQuery, resultController: resultController)
        
    }
}


