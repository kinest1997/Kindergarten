# 예외처리

## 이것은 무엇인가?
* 오류처리 라고도 하며 프로그램이 오류를 일으켰을때 이것을 감지하고 회복시키는 일련의 과정

## 오류의 표현
* 오류는 Error 이라는 프로토콜을 준수하는 타입의 값에의해 표현(주로 열거형으로 표현)
* 만약 어떤 구문을 실행시켰는데 어떤 조건을 통과하지못해 오류가 발생했고 정상적으로 실행되지않을때 내가 정한 오류의 타입을 출력해줄수있다.
 * ex: 사용자가 1천원을사용하여 물건을 구매하려고할때 만약 내가 가진돈이 500원이면 구매가 불가능하고 넘어갈수가없는데. 그때 메세지를 출력해줄수있다. 지금 noMoney 라는 오류가 발생했고 그 오류에 대한 행동을 내가 정의해줄수있다. 약간 미리 예상하고 다 선택지를 만들어주는 느낌

```swift
enum terribleError: Error {
	case noMoney
	case noTime
	case noMemory
}

//대충이렇게 오류의 타입을 정해준다
```

## 함수

### try

- 아래 형태는 내가 레몬을 살수있는 돈이 있는지 알려주는 함수다
```swift
var Money = 1000
let lemon = 1500

func canIBuyLemon(_ myMoney: Int,_ lemonPrice: Int) throws -> String {
	guard myMoney > lemonPrice else {
		throw terribleError.noMoney
	}
	return "You can buy it"
}
```

* 인코딩, 디코딩 할때는 `try` 를 사용해 무조건 값이 매칭되는경우엔 사용한다. 혹은 값이 존재하지않으면 `try? ` 로 옵셔널하게 받아옴
 
* 만약`try canIBuyLemon(2500,2000)` 형태로 작성시에 오류가 날일이없는 함수라면 당장은 저렇게 적을수는 있지만 파라미터 값에 따라 오류를 뱉기때문에 이렇게 작성하면안된다.
오류가 발생했을때 그에따른 오류 핸들링 방법은 `do, catch` 가 도와준다.

### do,try,catch

- 이 함수를 이용하여 `do try catch` 문을 작성하면 아래와 같다

```swift
do {
	try canIBuyLemon(2000,2500)
} catch let error {
	print error
	//에러메세지는 noMoney 가 나온다
}
```

### try?
- `do catch` 를 사용하지않고 그냥 `try?` 만 사용할수도있다, 그경우 반환값은 optional 이 되며 `nil` 값을 반환할수도있다.
- 근데 만약 그 함수에서 반환하는 값이 옵셔널값 인데 또 그 함수에 `try?` 를 하면 2중 옵셔널이 되어버려 귀찮아진다.
- 아래의 경우 옵셔널 값을 뱉는다.
```swift
try? canIBuyLemon(3500,2500)
// option 로 감사져서 나옴
// 3500을 2000으로 변경시엔 nil 값
```

### try! 
- forcedUnwrapping 과 같은 개념인데 진짜 값이 무조건 존재한다면 사용해도 된다. 하지만 없을경우 자비없이 바로 런타임 오류



## defer
* 현재의 코드 블록을 나가기전에 반드시 수행해야하는 마지막 작업을 표시해준다
* 함수, 메소드, 반복분, 조건문 등등 보통의 코드 블록 어디서든지 사용이 가능하다
* 항상 defer 블록은 포함된 블럭이 종료되기 직전에 읽는다.

```swift
for i in (1...3).reversed() {
    defer {
        if i == 1 {
        print("Launched!")
    }
    }
    print("count: \(i)")
}
//count: 3
//count: 2
//count: 1
//Launched!

// defer 구문이 print 구문보다 위에있으나 3부터 1까지 출력 한 후 마지막에 defer 블록 내의 구문이 실행된다 
```

