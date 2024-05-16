//
//  DownloadsVC.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit


final class DownloadsVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: view.bounds, style: .plain)
        return tv
    }()
    
    
    private var viewModel: DownloadViewModel
    
    // MARK: - LifeCycle
    
    init(viewModel: DownloadViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDownloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Helpers
    
    
    private func fetchDownloadData(){
        viewModel.fetchDownloadData()
    }
}

// MARK: - setupUI

extension DownloadsVC {
    private func setupUI(){
        drawDesign()
        configureNavBar()
        
    }
    private func drawDesign(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DownloadCell.self, forCellReuseIdentifier: DownloadCell.reuseID)
        
        
    }
    
    private func configureNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Downloads"
    }
    
    
    
    
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource Protocol

extension DownloadsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.databaseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DownloadCell.reuseID, for: indexPath) as? DownloadCell else{return UITableViewCell()}
        
        cell.downloadMovie = viewModel.databaseArray[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height / 4 )
    }
    
    // commit editingStyle : hücrede yana kaydırıp işlem yapmamızı sağlar
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteData(indexPath: indexPath)
        }
    }

}

// MARK: - DownloadViewModelDelegate Protocol

extension DownloadsVC: DownloadViewModelDelegate {
    func didFinish() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateTableView()
        }
    }

    func didFail(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func updateTableView() {
        tableView.reloadData()
    }
}
