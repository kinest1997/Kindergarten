import UIKit

//생성 방법들

//array 생성
var a: Array<Int> = [1, 2, 3, 4, 5, 6, 7]
var b: [Int] = [1, 2, 3, 4, 5, 6]

//dictionary 생성
var c: Dictionary<Int, String> = [3:"똥", 2:"바보"]
var d: [Int : Double] = [1:2.3, 2:3.3]

//set 생성
var e: Set<Int> = [1, 2, 3]
var f: Set = [4, 5, 6]

//Array 기본적 사용법

//추가
a.append(4)

//특정 위치에 추가
a.insert(1, at: 0)

//제거
//특정 위치에 있는것 제거
a.remove(at: 1)

//맨앞이나 맨뒤 제거
a.removeFirst()
a.removeLast()

//전체 제거
//a.removeAll()

//특정 index 값의 element 에 접근
//a array의 3번째 값
a[2]

//enumerated
//array 의 index 값과 요소의 값 2가지 모두에 접근하고 싶을때 사용
var array : Array<Int> = [1, 2, 3, 4]
for (index, num) in array.enumerated() {
    print("\(index+1)번째 숫자는 \(num)입니다")
    //index,num 변수이름을 다른 어떤것으로 바꿔도 괜찮다.
}

//Bool
//비어있는가
a.isEmpty

//특정 element 를 포함하고있는가
a.contains(1)

//array 붙이기
let alpha = a + b
alpha

//dictionary 기본사용법

//특정 key 값을 가진 value
c[3]

//scoreDic=[:]
//이렇게 하면 빈 딕셔너리로만들기 가능

//특정 키 값의 밸류 변경 또는 추가
c[3] = "좋아"
c[1] = "정말"

//몇개를 가졌는가
c.count

//key 와 value 를 통째로 제거
c.removeValue(forKey: 3)

//set 기본적인 사용법

//홀수의 모임
var odd:Set = [1, 3, 5, 7, 9]
        
//짝수의 모임
let even:Set = [2, 4, 6, 8, 10]
        
//소수의 모임
let prime:Set = [2, 3, 5, 7, 11]
        
//홀수와 짝수의 교집합(Intersection) 만들기
odd.intersection(even)
        
//홀수와 소수의 교집합을 제외한 수(symmetricDifference)
odd.symmetricDifference(prime)
        
//홀수와 짝수의 합집합(union)
odd.union(even).sorted()
        
//홀수이면서 소수가 아닌 집합(subtracting)
odd.subtract(prime)
        
//여기까지 적용하고 oddDigits를 확인하면 [1,9] set가 나온다
odd
print(odd)

//이것을 sorted() 하면, Array의 형태로 정렬해서 출력된다
odd.sorted()
print(odd.sorted())
