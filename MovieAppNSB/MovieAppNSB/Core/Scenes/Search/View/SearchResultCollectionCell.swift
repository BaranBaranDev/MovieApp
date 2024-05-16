//
//  SearchResultCollectionCell.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 11.05.2024.
//

import UIKit
import SDWebImage

final class SearchResultCollectionCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID = "SearchResultCollectionCell"
    
    
    // MARK: - UI Elements
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    // MARK: - Helpers
    
    public func configure(with path: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(path)") else {
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
