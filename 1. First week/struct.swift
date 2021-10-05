import UIKit

struct Student{
    var studyTime = 0
    var subjects: [Subject]
    
    mutating func study(){
        studyTime += 1
    }
    //struct 에서 객체가 가진 property 를 변경하는 method 를 작성할때는 변경한다는 의미에서 mutating 을 붙인다
    
    var totalAverageCP: Double {
       var subAverage: Double = 0
       var subTotal: Double = 0
       for subject in subjects {
           subTotal += subject.subjectScore
       }
       subAverage = subTotal / Double(subjects.count)

       return subAverage
   }
    
    func totalAverage() -> Double {
        var subAverage: Double = 0
        var subTotal: Double = 0
        for subject in subjects {
            subTotal += subject.subjectScore
        }
        subAverage = subTotal / Double(subjects.count)
    
        return subAverage
    }
}
struct Subject {
    let subjectName: String
    let subjectScore: Double
}
let history = Subject(subjectName: "history", subjectScore: 4.2)
let science = Subject(subjectName: "science", subjectScore: 3.3)

var kangLec = [history, science]
var kang = Student(subjects: kangLec)

kang.totalAverage()
//이건 method
kang.totalAverageCP
//이건 computed property
kang.study()


//아래쪽은 새로만든 것
struct Home {
    let space: Double
    let members: [Human]
    
    func familyAverageAge() -> Double {
        var ourAge = 0
        for member in members {
            ourAge += member.age
        }
        let averageAge
        = Double(ourAge / members.count)
        return Double(averageAge)
    }
    // 위는 메소드로 만든것 아래는 computed property
    var familyAverageWeight: Double {
        var totalWeight = 0.0
        var averageWeight = 0.0
        for member in members {
            totalWeight += member.weight
        }
        averageWeight = totalWeight / Double(members.count)
        return averageWeight
    }
    // 드디어 안보고 computed property와 method를 가진 struct 만들어냈다
    // 근데 뭔가 지저분하네
    
}

struct Human {
    var age: Int
    let name: String
    var weight: Double
}


var mother = Human(age: 51, name: "Jinah", weight: 83.4)
var son = Human(age: 24, name: "Heesung", weight: 63.4)
var daughter = Human(age: 23, name: "Heesu", weight: 54.4)

let myFamily = [mother, son, daughter]

let hwasung = Home(space: 105.6, members: myFamily)



print(hwasung.familyAverageAge())
//이친구는 method

print(hwasung.familyAverageWeight)
//이친구는 computed property

