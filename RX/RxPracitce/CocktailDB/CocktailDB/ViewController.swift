//
//  ViewController.swift
//  CocktailDB
//
//  Created by 강희성 on 2021/11/30.
//

import UIKit
import SnapKit
import Kingfisher
import RxRelay
import RxSwift
import RxCocoa


protocol ViewBindable {
    //view -> viewModel
    var searchButtonTapped: PublishRelay<Void> { get }
    var textFieldText: PublishRelay<String> { get }
    
    //viewModel -> view
    var cellData: Driver<[Cocktail]> { get }
}

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var cocktails: [Cocktail] = []
    
    let mainTableView = UITableView()
    let textField = UITextField()
    let searchButton = UIButton()
    let mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mainStackView)
        view.addSubview(mainTableView)
        mainStackView.addArrangedSubview(textField)
        mainStackView.addArrangedSubview(searchButton)
        mainStackView.axis = .vertical
        
        mainTableView.register(CocktailCell.self, forCellReuseIdentifier: "cocktail")
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom)
            $0.trailing.leading.bottom.equalToSuperview()
        }
        
        mainTableView.rowHeight = 100
        mainTableView.backgroundColor = .white
        textField.placeholder = "여기에 검색"
        mainStackView.backgroundColor = .brown
        searchButton.setTitle("검색", for: .normal)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
    }
    
    func bind(_ viewModel : ViewBindable = ViewModel()) {
        self.searchButton.rx.tap
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        self.textField.rx.text
            .compactMap { data in
                data
            }
            .bind(to: viewModel.textFieldText)
            .disposed(by: disposeBag)
        
        viewModel.cellData
            .drive(mainTableView.rx.items(cellIdentifier: "cocktail", cellType: CocktailCell.self)) { index, data, cell in
                guard let imageURL = URL(string: data.strDrinkThumb ?? ""),
                      let imageData = try? Data(contentsOf: imageURL)
                else { return }
                let image = UIImage(data: imageData)
                cell.mainImageView.image = image
                cell.mainTextLabel.text = data.strInstructions
            }
            .disposed(by: disposeBag)
    }
}
