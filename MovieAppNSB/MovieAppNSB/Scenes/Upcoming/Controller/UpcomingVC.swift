//
//  UpcomingVC.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit


final class UpcomingVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        return tv
    }()
    
    
    // MARK: - Properties
    
    private let viewModel : UpcomingViewModel
    
    // MARK: - LifeCycle
    
    init(viewModel: UpcomingViewModel) {
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

extension UpcomingVC {
    private func setupUI(){
        drawDesign()
        setupNavBar()
        
    }
    private func drawDesign(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UpcomingTableCell.self, forCellReuseIdentifier: UpcomingTableCell.reuseID)
        
        viewModel.delegate = self // haberleşme için delege belirledim 
        
        
    }
    
    // Navigasyon çubuğunu yapılandırır: büyük başlıkları tercih eder ve her zaman büyük başlık modunu kullanır.
    private func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Upcoming"
    }
    
    private func fetchData(){
        viewModel.fetchData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource Protocol

extension UpcomingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableCell.reuseID, for: indexPath) as? UpcomingTableCell else{
            return UITableViewCell()
        }
        cell.movie = viewModel.upcomingMoviesArray[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height / 4 )
    }
    
}

// MARK: - UpcomingViewModelDelegate Protocol

extension UpcomingVC: UpcomingViewModelDelegate{
    func didFinish() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else{return}
            self.tableView.reloadData()
        }
    }
    
    func didFail(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
}
