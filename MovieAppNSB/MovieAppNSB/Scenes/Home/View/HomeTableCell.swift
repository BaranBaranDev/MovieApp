//
//  HomeTableCell.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit

final class HomeTableCell: UITableViewCell{
    // MARK: - UI Elements
    // her hücrede kayan bir yapı olmasını istiyorum o zaman collectionView kullanalım
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // yatay da hareketlendir
        layout.itemSize = .init(width: 140, height: 200) // boyutlandırdık
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    // MARK: - Properties
    static let reuseID: String = "HomeTableCell"
    
    private var movieArray : [Movie] = []
    
    // MARK: - İnitialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // alternatif subviews boyutlandırma, iyidir öneririm :)
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
    }
    
    private func setup(){
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: HomeCollectionCell.reuseID)
        
    }
    
    public func configure(with movies: [Movie]){
        self.movieArray = movies
        DispatchQueue.main.async {[weak self] in
            guard let self = self else{return}
            self.collectionView.reloadData()        }
    }
}

extension HomeTableCell: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.reuseID, for: indexPath) as? HomeCollectionCell
        else{
            return UICollectionViewCell()
        }
        
        guard let model = movieArray[indexPath.item].posterPath else{
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        return cell
    }
    
    
}
