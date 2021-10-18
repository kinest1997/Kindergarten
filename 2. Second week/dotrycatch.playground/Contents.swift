import UIKit

import UIKit


enum terribleError: Error {
    case noMoney
    case noTime
    case noMemory
    case cantBuyMilk
}


var Money = 1000
let lemon = 1500

func canIBuyLemon(_ myMoney: Int,_ lemonPrice: Int) throws -> String {
    guard myMoney > lemonPrice else {
        throw terribleError.noMoney
    }
    
    guard myMoney - lemonPrice > 500 else {
        throw terribleError.cantBuyMilk
    }
    return "You can buy it"
}


do {
    try canIBuyLemon(3000,2500)
} catch let error {
    print(error)
    //에러메세지는 noMoney 가 나온다
}





for i in (1...3).reversed() {
    defer {
        if i == 1 {
        print("Launched!")
    }
    }
    print("count: \(i)")
}
