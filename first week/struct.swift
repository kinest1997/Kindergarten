```
import UIKit

struct Student{

    var subjects : [Subject]

    func totalAverage(student : Student) -> Double {
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
let science = Subject(subjectName: "science", subjectScore: 4.0)

let kang = Student(subjects: history)

```