//
//  ViewModel.swift
//  CocktailDB
//
//  Created by 강희성 on 2022/01/11.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel: ViewBindable {
    
    var searchButtonTapped = PublishRelay<Void>()
    
    var textFieldText = PublishRelay<String>()
    
    var cellData: Driver<[Cocktail]>
    
    
    init(model: Model = Model()) {
        
        cellData = searchButtonTapped.withLatestFrom(textFieldText)
            .flatMapLatest(model.updateData)
            .asDriver(onErrorDriveWith: .empty())
    }
}
