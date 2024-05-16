//
//  HeroHeaderView.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 2.05.2024.
//

import UIKit
import SnapKit

final class HeroHeaderView: UIView {

    // MARK: - UI Elements

    private lazy var heroImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "heroimage")
        return iv
    }()
    

    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()


    
    
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = self.bounds
    }
     
}

// MARK: - Helpers

extension HeroHeaderView {
    private func setupUI() {
        // Görünümü bozmamak için çağrılma sırasına dikkat et!
        addSubview(heroImageView)
        addGradient()
        makeLayout()
        
    }
}


// MARK: - Configure && CAGradientLayer


// Gradient Ext
private extension HeroHeaderView {
    // Çağrılma sırası önemli mesela configure altında çağırırsan butonlar tam gözükmez dikkat et.
    func addGradient(){
        let grandientLayer = CAGradientLayer()
        grandientLayer.frame = bounds
        grandientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(grandientLayer)
    }
}



private extension HeroHeaderView {
    func makeLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(playButton)
        stackView.addArrangedSubview(downloadButton)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50) // inset ile - yazmana gerek kalmıyor :)
        }
        
        playButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

