import UIKit

struct CocktailResponse: Codable {
    let drinks: [Cocktail]
}

struct Cocktail: Codable {
    let strDrink: String?
    let strCategory: String?
    let strIBA: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strDrinkThumb: String?
//
//    let strIngredient1: String?
//    let strIngredient2: String?
//    let strIngredient3: String?
//    let strIngredient4: String?
//    let strIngredient5: String?
//    let strIngredient6: String?
//
//    let strMeasure1: String
//    let strMeasure2: String
//    let strMeasure3: String
//    let strMeasure4: String
//    let strMeasure5: String
//    let strMeasure6: String
    
//    enum Alcohol: String, Codable {
//        case Alcohol
//        case NonAlcohol
//    }
}

