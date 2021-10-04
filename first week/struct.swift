
import UIKit

//주석 추가 헤헤

struct Student{
    var studyTime = 0
    var subjects : [Subject]
    
    mutating func study(){
        studyTime += 1
    }
    func totalAverage() -> Double {
        var subAverage : Double = 0
        var subTotal : Double = 0
        for subject in subjects {
            subTotal += subject.subjectScore
        }
        subAverage = subTotal / Double(subjects.count)
    
        return subAverage
    }
}
struct Subject {
    let subjectName : String
    let subjectScore : Double
}
let history = Subject(subjectName: "history", subjectScore: 4.2)
let science = Subject(subjectName: "science", subjectScore: 3.3)

var kangLec = [history,science]
var kang = Student(subjects: kangLec)

kang.totalAverage()
kang.study()





