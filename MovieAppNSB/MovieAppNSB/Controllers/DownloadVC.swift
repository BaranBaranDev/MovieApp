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
    
    

    
    // MARK: - LifeCycle
    

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
       
    }
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Bağımlılığı kullanarak bir şeyler yapın
        setupUI()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

// MARK: - Helpers

extension DownloadsVC {
    private func setupUI(){
        drawDesign()

        
    }
    private func drawDesign(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      
        
        
    }
    
 

    
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource Protocol

extension DownloadsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hrhhrsgsgs"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height / 4 )
    }
    
}


