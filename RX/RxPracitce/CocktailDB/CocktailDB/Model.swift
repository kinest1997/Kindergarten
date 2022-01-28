//
//  Model.swift
//  CocktailDB
//
//  Created by 강희성 on 2022/01/11.
//

import Foundation
import RxSwift
import RxCocoa

struct Model {
    
    ///string 을 받아서 request 를 생성해주는것
    func updateData(text: String) -> Single<[Cocktail]> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.thecocktaildb.com"
        urlComponents.path = "/api/json/v1/1/search.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "s", value: text == "" ? "martini" : text)
        ]
        let completeURL = urlComponents.url!
        var urlRequest = URLRequest(url: completeURL)
        urlRequest.httpMethod = "GET"
        
       return URLSession.shared.rx.data(request: urlRequest)
            .compactMap { data -> [Cocktail]? in
                do {
                    let cocktails = try? JSONDecoder().decode(CocktailResponse.self, from: data)
                    return cocktails?.drinks
                }
            }
            .asSingle()
    }
}

