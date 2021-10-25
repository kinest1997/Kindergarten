# Closure2

## 종류
### Named Closure
* 우리가 알고있는 이름이 있는 함수
* 1급 객체의 특성을 가진다
* 중첩함수와 전역함수가있다

```
func someFunc(){ print("함수")  } 
```
* Named Closure 라고 부르지않고 그냥 함수 라고 부르는것 뿐

### Unnamed Closure
* 아래와 같이 이름을 붙이지 않고 사용하는 함수
*  1급 객체의 특성을 가진다

> 1급 객체란?  First Class Citizen   
> 1. 변수나 상수에 저장 및 할당 가능  
> 2. 파라미터(객체의 인자)로 사용가능  
> 3. 함수(객체)에서 return 값으로 사용 가능

```
let closure = { print("Somaker") }
```

* 클로저는 아래와 같이 클로저 헤드와 클로저 바디로 이루어져 있다
* 바디와 헤드를 구분지어주는게 in 키워드

```swift
{ (parameters) -> returntype in 실행구문 }  
// in 이전까지가 헤드, 이후가 body
```

-
#### Parameter와 Return Type이 있는 클로저

```
let closure = { (name: String) -> String in
    return "Hello, \(name)"
}
```

* 위의 경우 `(name: String)` 부분이 함수처럼 `func etc(name: String)` 부분의 parameter랑 비슷해보인다, *하지만 클로저에선 함수 파라미터 이름(Argument Label)을 적어주지않는다*

```
func fName(agumentName paramName:Int)
let a = { (label: String) -> String }
```
* 위 코드처럼 원래 함수는 인자 이름, 파라미터 이름 둘다있는데 (보통 파라미터 이름을 그냥 인자이름으로 사용), 클로저는 파라미터 이름만 존재한다

-

#### Trailing Closure
*  함수의 마지막 파라미터가 클로저일 때,
이를 파라미터 값 형식이 아닌 함수 뒤에 붙여 작성하는 문법
이때, Argument Label은 생략된다

```
func doSomething(closure: () -> ()) {
    closure()
}
// 위처럼 클로저를 parameter로 받는 함수의 경우 마지막 parameter 가 클로저 이므로 

doSomething () { () -> () in
    print("Hello!")
}
// 이렇게 변할수있으며 파라미터가 클로저 하나인경우 호출구문 ()도 삭제 가능
// 하지만 파라미터가 여러개일경우 호출구문 삭제 금지
```
-

#### 경량문법(축약)
* 문법을 최적화 하여 클로저를 단순하게 사용할수있게 해주는것

```
doSomething(closure: { (a: Int, b: Int, c: Int) -> Int in
    return a + b + c
})
```
* 위의 형태의 클로저는 파라미터 타입과 리턴 타입은 생략가능하다

```
doSomething(closure: { (a, b, c) in
    return a + b + c
})
```

* 그럼 이렇게 변신하는데 a,b,c 가 2번 중복으로 나온다 코드에서 같은내용을 중복으로 적는것은 지양한다고했음, 그럼 어떻게 줄이는가?
* $ 와 index(순서) 를 이용해 파라미터에 순서대로 접근할수있다

```
doSomething(closure: {  
    return $0 + $1 + $2
})
```

* 그럼 이렇게 파라미터 이름과 in 키워드 까지 줄여버릴수있다,
* 근데 여기서 더 줄일수있다 만약 클로저 구문이 `{ return 실행구문 }` 형태로 단일 `return` 문만 남는다면 `return` 도 삭제 가능하다

```
doSomething(closure: {  
     $0 + $1 + $2
})
```
* 근데 마지막 파라미터가 클로저면 트레일링으로 가능하댔다

```
doSomething() {  
     $0 + $1 + $2
}
```
* 만약 파라미터가 하나이고 () 생성자에 아무것도 없는경우 생략가능

```
doSomething {  
     $0 + $1 + $2
}
```

* 세상 깔끔해졌다
* 위의 모든 doSomething 이라는 함수는 3개의 파라미터를 받아 1,2,3 번쨰 파라미터값을 다더하는 형태를 가진 클로저를 파라미터로 받는 함수다. 라는 뜻을가짐 하지만 점점 간단해지고 짧아짐


### @autoclosure
* 파라미터로 전달된 일반 구문 & 함수를 클로저로 래핑(Wrapping) 하는 것
* 원래 바로 실행되어야 하는 구문이 지연되어 실행한다는 특징이 있음
* 아직은 왜쓰는지 딱히 잘모르겠음, 나중에 알아보자

### @escaping
* 이친구도 마찬가지..


## Closure 값캡쳐

* 생성순간 값을 캡쳐한다.
* 클로져와 클로저주변것들을 자기가 캡쳐를 한다 하나의 주소를 가지면 여러명이 참조
활용하는 순간 주변의 값들을 가지고 온다

* Closure는 값의 타입이 Value건 Reference건 모두 
Reference Capture를 한다

* reference type 예시

```
func doSomething() {
    var num: Int = 0
    print("num check #1 = \(num)")
    
    let closure = {
        print("num check #3 = \(num)")
    }
    
    num = 20
    print("num check #2 = \(num)")
    closure()
}
// 클로저가 선언된 시점의 num 은 0 이지만 클로저가 사용될때는 20으로 업데이트 되있다. 
// 그러면 20을 출력한다
```

* value type 참조 예시

```
func doSomething() {
    var num: Int = 0
    print("num check #1 = \(num)")
    
    let closure = { [num] in
        // 여기서 그냥 num에 대괄호 씌워버린다
        print("num check #3 = \(num)")
    }
    
    num = 20
    print("num check #2 = \(num)")
    closure()
}
// 클로저가 선언된시점의 num 은 0이다 그래서 그 값의 주소를 따오는게 아니라 상수형태로 복사해서 value 로 가져와서 실행시켜도 그대로 0이 나온다
```












