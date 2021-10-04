import UIKit

let numberList : [Int] = [1,2,3,4,5,6,7,8,9,10]


// 가장 기본적인 클로저

var multiply : (Int,Int) -> Int = {
   a, b in return a * b
}

var multiply2 : (Int,Int) -> Int = {
    a , b in a * b
}


var multiply3 : (Int,Int) -> Int = {$0*$1}
// 이렇게도 될거같아서 하니까 되긴한다 앞의 두 값을 곱한것

// 여기서 자동으로 a,b 가 앞의 변수를 지칭하는건가?
// 어째서 무슨원리로

// 기본 용어 정리부터 다시해야할거같다
// 가장 간단한 map 사용법
//let stringList = numberList.map { a in
//    "\(a)"
//}

let stringList = numberList.map { a in return
    "\(a)"
}

print(stringList)


let oddNums = numberList.filter { !($0%2 == 0)
}
let oddnums2 = numberList.filter { (number) -> Bool in
    !(number % 2 == 0)
}

print(oddNums)
print(oddnums2)
// 축약해버리면 오히려알거같은데 풀어서 쓴게 어떻게 하는지 감이안온다

let evenNums = numberList.filter { num in
    num % 2 == 0
}
//여기서 제일 앞의 num 은 함수의 parameter 처럼 그냥 아무렇게나 붙여도 되는 이름이 맞는가? 이미 그 위치에 어떤것이 들어가던지 기능없는 이름일뿐인건가?

let nums1 = [1,2,3]
let factorial = nums1.reduce(2){
    (num1,num2) -> Int in num1 * num2
}
//여기서 reduce 값 뒤의 1은초기값? 아니다
// 맞네 저 숫자가 num 1 인거같다


struct Home {
    let space : Double
    let members : [Human]
    func familyAverageAge() -> Double {
        var ourAge = 0
        for member in members {
            ourAge += member.age
        }
        let averageAge
        = Double(ourAge / members.count)
        return Double(averageAge)
    }
    
    func familyAverageWeight() -> Double {
        var totalWeight = 0.0
        var averageWeight = 0.0
        for member in members {
            totalWeight += member.weight
        }
        averageWeight = totalWeight / Double(members.count)
        return averageWeight
    }
    // 드디어 안보고 computed property 를 가진 struct 만들어냈다
    //근데 뭔가 지저분하네
    
}

struct Human {
    var age : Int
    let name : String
    var weight : Double
}


var mother = Human(age: 51, name: "Jinah", weight: 83.4)
var son = Human(age: 24, name: "Heesung", weight: 63.4)
var daughter = Human(age: 23, name: "Heesu", weight: 54.4)

let myFamily = [mother,son,daughter]

let hwasung = Home(space: 105.6, members: myFamily)



print(hwasung.familyAverageAge())
print(hwasung.familyAverageWeight())



