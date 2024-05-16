//
//  HomeVC.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit

// Bölümler için enum tanımladık, bu enum TableView'deki bölümleri temsil eder
enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case Toprated = 4
}


final class HomeVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var tableView : UITableView = {
        let tv = UITableView(frame: view.bounds, style: .grouped) // style dikkat
        return tv
    }()
    
    
    // MARK: - Properties
    
    private let sectionTitles : [String] = ["Trending Movies","Trending Tv","Popular","Upcoming Movies","Top rated"]
    
    private var arrMovie : [Movie] = []
    private var arrTv : [Movie] = []
    private var arrPopular : [Movie] = []
    private var arrupcoming : [Movie] = []
    private var arrToprated : [Movie] = []
    
    private let viewModel : HomeViewModel
    
    // MARK: - LifeCycle
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchData()
        viewModel.output = self
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}

// MARK: - Helpers

extension HomeVC {
    private func setupUI(){
        drawDesign()
        configureNavBar()
    }
    private func drawDesign(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableCell.self, forCellReuseIdentifier: HomeTableCell.reuseID)
        view.addSubview(tableView)
        
        // tableview için header alanı oluşturduk
        tableView.tableHeaderView = HeroHeaderView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: 450))
        
            
    }
    
    private func configureNavBar(){
        let image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self, action: nil),
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
}

// MARK: -  UITableViewDelegate && UITableViewDataSource Protocols
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count // bölüm adeti
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // hücrede adeti
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.reuseID, for: indexPath) as? HomeTableCell else{
            return UITableViewCell()
        }
        cell.delegate = self
        
        // Her bölüm için veri almak ve hücreyi yapılandırmak
        switch indexPath.section{ //indexPath.section: Bu, TableView'deki belirli bir bölümün indisini temsil eder.
        case Sections.TrendingMovies.rawValue:
            cell.configure(with: arrMovie)
    
        case Sections.TrendingTv.rawValue:
            cell.configure(with: arrTv)
            
        case Sections.Popular.rawValue:
            cell.configure(with: arrPopular)
            
        case Sections.Upcoming.rawValue:
            cell.configure(with: arrupcoming)
            
        case Sections.Toprated.rawValue:
            cell.configure(with: arrToprated)
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // hücrenin yüksekliği
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 // header ile cell arası mesafesi
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section] // bölüm başlıkları
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // Bölüm başlığının görüntülenmeye başlamadan önce çağrılır.
        
        // Görünümün bir UITableViewHeaderFooterView olup olmadığını kontrol ediyoruz.
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        // Başlık metninin yazı tipi ve kalınlığını ayarlıyoruz.
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetterOfWords()
    }
    
    // MARK: - UIScrollViewDelegate Protocol
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Güvenli alandaki üst boşluğu alır
        let defaultOffset = view.safeAreaInsets.top
        
        // ScrollView'in mevcut dikey kaydırma konumunu alır
        let currentOffset = scrollView.contentOffset.y
        
        // Güncellenmiş kaydırma konumunu hesaplar
        let updatedOffset = currentOffset + defaultOffset
        
        // Navigation Bar'ın transformunu ayarlar
        // ScrollView kaydırıldıkça, Navigation Bar yukarı veya aşağı doğru kayar
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -updatedOffset))
        //Transform, bir görünümün konumunu, boyutunu ve dönüşümünü değiştirmek için kullanılan bir özelliktir.
    }
}
// MARK: - HomeViewModelDelegate Protocol
extension HomeVC: HomeViewModelDelegate{
    func handleOutput(_ output: HomeViewModelOutput) {
        switch output{
        case .TrendMoviesOutput(let movie):
            self.arrMovie = movie
        case .TrendTvOutput(let tv):
            self.arrTv = tv
        case .PopularOutput(let popular):
            self.arrPopular = popular
        case .UpcomingOutput(let upcoming):
            self.arrupcoming = upcoming
        case .TopRatedOutput(let toprated):
            self.arrToprated = toprated
        case .ErrorOutput(let error):
            print(error.localizedDescription)
        }
        DispatchQueue.main.async{[weak self] in
            guard let self = self else{return}
            self.tableView.reloadData() // Yeni veri geldiğinde tabloyu güncelle
        }
      
    }
    
}


// MARK: - HomeTableCellDelegate Protocol
extension HomeVC: HomeTableCellDelegate{
    func didTapped(_ cell: HomeTableCell, model: PreviewModel) {
        DispatchQueue.main.async {
            let vc = PreviewVC()
            vc.configureUI(with: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
