//
//  HomeCollectionCell.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 6.05.2024.
//

import UIKit
import SDWebImage

final class HomeCollectionCell: UICollectionViewCell {
    // MARK: - UI Elements
    private lazy var posterImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill // en boy korunarak doldur
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Properties
    static let reuseID: String = "HomeCollectionCell"
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // layout tanımlamamız
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.frame = contentView.bounds
    }
    
    // MARK: - Helpers
    public func configure(with path: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(path)") else{return}
        posterImage.sd_setImage(with: url, completed: nil)
        
    }
    
    
}

