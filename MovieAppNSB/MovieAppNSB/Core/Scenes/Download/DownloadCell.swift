//
//  DownloadCell.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 16.05.2024.
//

import UIKit
import SnapKit

final class DownloadCell: UITableViewCell{
    
    // MARK: - UI Elements
    private lazy var posterImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var posterTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.adjustsFontForContentSizeCategory = true
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var playButton : UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    
    // MARK: - Properties
    
    static let reuseID: String = "DownloadCell"
  
    public var downloadMovie: DataEntities?{
        didSet{
            reloadUI()
        }
    }
    
    // MARK: - İnitialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ReloadUI
    
    private func reloadUI(){
        guard let downloadMovie = downloadMovie else{return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(downloadMovie.posterPath ?? "")") else{return}
        
        posterImage.sd_setImage(with: url, completed: nil)
        
        posterTitle.text = downloadMovie.originalName ?? downloadMovie.originalTitle
    }
    
}



// MARK: - Configure
private extension DownloadCell{
    func configure(){
        // Layout
        contentView.addSubview(stackView)
        stackView.addArrangedSubviewFromExt(views: posterImage,posterTitle,playButton)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Genişlik
        posterImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        posterTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
    
        
    }
    

    
    

    
}

