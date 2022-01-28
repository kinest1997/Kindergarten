//
//  ViewController.swift
//  KanyeApi
//
//  Created by 강희성 on 2022/01/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ViewBindable {
    //    view -> viewModel
    var buttonTapped: PublishRelay<Void> { get }
    
    //    viewModel -> view
    var reloadKanye: Signal<String> { get }
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let guideLabel = UILabel()
    let quoteLabel = UILabel()
    
    let getButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [guideLabel, quoteLabel, getButton].forEach {
            view.addSubview($0)
        }
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(30)
        }
        quoteLabel.snp.makeConstraints {
            $0.leading.equalTo(guideLabel.snp.trailing).offset(30)
            $0.top.equalTo(guideLabel)
            $0.trailing.equalToSuperview()
        }
        
        getButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        view.backgroundColor = .white
        
        do { //getButton
            getButton.setTitleColor(.black, for: .normal)
            getButton.setTitle("명언생성", for: .normal)
            getButton.backgroundColor = .blue
        }
        
        do { //guideLabel
            guideLabel.textColor = .black
            guideLabel.text = "명언"
            guideLabel.textAlignment = .center
            guideLabel.font = .systemFont(ofSize: 20)
        }
        
        do { //quoteLabel
            quoteLabel.font = .systemFont(ofSize: 20)
            quoteLabel.numberOfLines = 0
            quoteLabel.textColor = .black
        }
    }
    
    func bind(viewModel: ViewBindable) {
        self.getButton.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        viewModel.reloadKanye
            .emit(to: self.quoteLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

