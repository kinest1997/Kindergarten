# Closure

이름이 없는 메소드

* closure 에는 3가지 타입이 있다.

1. global : 우리가 아는 func 키워드를 사용하여 만드는 함수
2. nested : 10/11 : 알게되었다 이것의 이름은 중첩 함수, 함수안에 함수가 존재하는 요상한 모양새
3. closure expressions : 지금 배우는 이름없는 기능수행 코드블록

## closure 기본 
```swift
{ (parameters) -> returntype in statements }

var multiply: (Int, Int) -> Int = {
   a, b in return a * b
}

var multiply2: (Int, Int) -> Int = {
    a , b in a * b
}


var multiply3: (Int, Int) -> Int = {$0*$1}

3가지 전부다 같은 클로저이다
```
* 여기서 따지고보면 클로저 라고 부를수있는 부분은 중괄호 부분이다
* 앞부분은 var 의 타입을 명시해준것뿐


## closure 예시들


## 1. map
* collection 의 각 항목의 데이터를 다튼 타입의 데이터로 변경하는 메소드
* 클로져를 이용하여 각 항목당 1번씩 호출되어 처리후 다시 반환된다.
* 가장 간단한 사용법
```swift
let numberList = [1, 2, 3, 4]
let stringList = numberList.map { a in return
    "\(a)"
//return 은 생략 가능하다
//더 줄이면 이렇게까지 가능
let stringList = numberList.map {"\($0)"}
```
이렇게 할경우 array 안의 모든 배열이 `string`으로 변환된 `stringList` 라는 배열이 새로 생긴다



## 2. filter
* collection 의 특정 element 를 걸러내는 메소드
* 클로저를 통해 걸러내야 할 데이터의 조건을 전달한다.

```swift

let oddnums2 = numberList.filter { (number) -> Bool in
    !(number % 2 == 0)
}

let oddNums = numberList.filter { !($0%2 == 0)
}
//가장 축약된거, element 를 2로 나눴을때 나머지가 0 이 아닌숫자가 나온다

let evenNums = numberList.filter { num in
    num % 2 == 0
}
```



## 3. reduce

* collection 내부의 모든 콘텐츠의 값을 하나의 값으로 합쳐주는 메소드
* 값을 합칠때 어떤방식으로 합칠지 표현할수있다.
```swift
 //팩토리얼
 let factorialFive = [1, 2, 3, 4, 5]
 
 let factorialNumber = factorialFive.reduce(1) { (num1, num2) -> Int in
     num1*num2
 }
 //여기서 reduce 뒤의 숫자를 0번 index 의 값으로 넣어줘야한다 num1의 값이다.
 print(factorialNumber) //120

```

## 4. 기타 연습

```swift
//2개의 수를 곱하는 클로져
var multiplyClosure: (Int, Int) -> Int = {
    a, b in return a * b
}

let result = multiplyClosure(4, 2)

//closure 를 parameter로 받는 함수
func operateTwoNum(a: Int, b: Int, operation : (Int, Int) -> Int) -> Int {
    //parameter로 2가지 int값을 받아서 int 값을 출력하는 형태를 넣을수있다는것
    let result = operation(a, b)
    return result
}

operateTwoNum(a: 4, b: 2, operation: multiplyClosure)


var addClosure: (Int , Int) -> Int = {
    a, b in return a + b
}
operateTwoNum(a: 3, b: 2, operation: addClosure)

//parameter 자체에 클로저를 넣어버리는 방법도있다
operateTwoNum(a: 4, b: 3){ a, b in return a - b }
//이게 왠지 깔끔하고 맘에든다


//클로저에 아무런 변수를 넣지않고 출력값도 없는 것도 가능하다
let voidClosure: () -> Void = {
    print("closure 사랑해")
}
voidClosure()

//capturing value
var count = 0

let incrementer = {
    count += 1
}
incrementer()
incrementer()
incrementer()

count

/*
//간단한 클로져
let superSimpleClosure = {
}
superSimpleClosure()
//클로져 실행시에는 함수처럼 ()를 붙여줘야한다

*/

let simpleClosure: (String) -> Void  = { name in
    print("안녕하세요 \(name)")
}

simpleClosure("love")
```




