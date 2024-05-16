//
//  SearchResultController.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 11.05.2024.
//

import UIKit

// arama sonucunu gösteren vc
final class SearchResultController: UIViewController {
    
    // MARK: - UI Elements
    
    public lazy var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 130, height: 200)
        layout.minimumInteritemSpacing = 0 // hücre içerisi için mesafe
        layout.minimumLineSpacing = 1 // hücrenin dışında hücreler arası mesafe
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    // MARK: - Properties
    
    public var searchedMovies: [Movie] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
}

// MARK: - Helpers

extension SearchResultController {
    private func setupUI(){
        drawDesign()
    }
    private func drawDesign(){
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: SearchResultCollectionCell.reuseID)
    }
    
  
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension SearchResultController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionCell.reuseID, for: indexPath) as? SearchResultCollectionCell else{
            return UICollectionViewCell()}
        let model = searchedMovies[indexPath.item] 
        cell.configure(with: model.posterPath ?? "")
        return cell
    }
}


