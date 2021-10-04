# Closure

이름이 없는 메소드

* closure 에는 3가지 타입이 있다.

> 1.  global : 우리가 아는 func 키워드를 사용하여 만드는 함수
2. nested : 아직 모른다...
3. closure expressions : 지금 배우는 이름없는 기능수행 코드블록

## closure 예시들

```
//2개의 수를 곱하는 클로져
var multiplyClosure : (Int, Int) ->Int = {
    a,b in return a * b
}

let result = multiplyClosure(4,2)

//closure 를 parameter로 받는 함수
func operateTwoNum(a: Int, b: Int , operation : (Int, Int) -> Int) -> Int {
    //parameter로 2가지 int값을 받아서 int 값을 출력하는 형태를 넣을수있다는것
    let result = operation(a, b)
    return result
}

operateTwoNum(a: 4, b: 2, operation: multiplyClosure)


var addClosure : (Int , Int) -> Int = {
    a,b in return a + b
}
operateTwoNum(a: 3, b: 2, operation: addClosure)

//parameter 자체에 클로저를 넣어버리는 방법도있다
operateTwoNum(a: 4, b: 3){a,b in return a - b}
//이게 왠지 깔끔하고 맘에든다


//클로저에 아무런 변수를 넣지않고 출력값도 없는 것도 가능하다
let voidClosure : () -> Void = {
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

let simpleClosure : (String) -> Void  = { name in
    print("안녕하세요 \(name)")
}

simpleClosure("love")

//trailing closure??

```

## 1. map





## 2. filter





## 3. reduce




