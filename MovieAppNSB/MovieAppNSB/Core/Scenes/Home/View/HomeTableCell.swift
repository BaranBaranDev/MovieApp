//
//  HomeTableCell.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 1.05.2024.
//

import UIKit

protocol HomeTableCellDelegate:AnyObject {
    func didTapped(_ cell: HomeTableCell,model:PreviewModel)
}

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
    
    weak var delegate: HomeTableCellDelegate?
    
    
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


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeTableCell: UICollectionViewDataSource{
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

extension HomeTableCell: UICollectionViewDelegate{
    // hücrelere tıklama olursa haberleşmeyi sağlar
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // kullanıcı bir öğe seçtikten sonra başka bir eylemi gerçekleştirmek istiyorsanız bu methodu kullanabilirsiniz.
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // film ismine ulaşacağız modelden
        let movies = movieArray[indexPath.item]
        guard let movieName = movies.originalName ?? movies.originalTitle else{return}
        guard let movieOverview = movies.overview else{return}
        
        // evet tıklanan hücrenin ismiyle veriyi alacağız
        YoutubeNetwork.shared.getMovie(with: "\(movieName) trailer ") { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let video):
                guard let searchVideoId = video.items[safe: indexPath.item]?.id.videoId else {
                    // video.items dizisi belirtilen indekse sahip değilse veya video.items[indexPath.item].id.videoId nil ise
                    return
                }
                // geçiş yapabilmek için delege kullandım çünkü celllerde Nav push kullanamam :) VC ye geçmeliyiz
                self.delegate?.didTapped(self, model: PreviewModel(videoID: searchVideoId, title: movieName, overview: movieOverview))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
}


