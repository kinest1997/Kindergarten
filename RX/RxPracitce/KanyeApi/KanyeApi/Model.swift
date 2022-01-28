//
//  Model.swift
//  KanyeApi
//
//  Created by 강희성 on 2022/01/13.
//

import Foundation
import RxCocoa
import RxSwift

struct Kanye: Codable {
    let quote: String
}

struct Model {
    func getQuote() -> Single<String>{
        var urlcomponents = URLComponents()
        urlcomponents.scheme = "https"
        urlcomponents.host = "api.kanye.rest"
        let completeurl = urlcomponents.url!
        let urlReq = URLRequest(url: completeurl)
        
        return URLSession.shared.rx.data(request: urlReq)
            .compactMap { data -> String? in
                do {
                    let quote = try? JSONDecoder().decode(Kanye.self, from: data)
                    return quote?.quote
                }
            }
            .asSingle()
    }
}
