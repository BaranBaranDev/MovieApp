//
//  PreviewVC.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 14.05.2024.
//

import UIKit
import WebKit
import SnapKit

// CollectionView da hücrelere tıklananınca ön izleme sayfamız açılacak.
final class PreviewVC: UIViewController {
    // MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "fasfadsfdsfgaesgfaes"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "fasfadsfdsfgaesgfaes"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
     
    }
    
 
    public func configureUI(with model: PreviewModel){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.titleLabel.text = model.title
            self.overviewLabel.text = model.overview
            
            guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoID ?? "")") else {return}
            webView.load(URLRequest(url: url))
            
        }
    }
    
}

// MARK: - Layout

private extension PreviewVC{
    func layout(){
        makeWebView()
        makeTitleLabel()
        makeOverviewLabel()
        makeDownloadButton()
    }
    
    func makeWebView(){
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func makeTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    func makeOverviewLabel(){
        view.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    func makeDownloadButton(){
        view.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
}


