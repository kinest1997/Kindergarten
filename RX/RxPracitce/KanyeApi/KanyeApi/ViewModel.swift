//
//  ViewModel.swift
//  KanyeApi
//
//  Created by 강희성 on 2022/01/13.
//

import Foundation
import RxCocoa
import RxSwift

struct ViewModel: ViewBindable {
    var buttonTapped = PublishRelay<Void>()
    
    var reloadKanye: Signal<String>
    
    init(model: Model = Model()) {
        
        reloadKanye = buttonTapped
            .debug("before")
            .flatMap { model.getQuote()}
            .debug("after")
            .asSignal(onErrorSignalWith: .empty())
    }
}
