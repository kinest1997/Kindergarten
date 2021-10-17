# Property

* 프로퍼티는 값을 특정 `struct`, `class`, `enum` 와 연결해준다.

* 프로퍼티의 종류엔 3가지가있다
 * 저장 프로퍼티 : Stored Property
 * 연산 프로퍼티 : Computed Property
 * 타입 프로퍼티 : Type Property
 
#### 번외
 
 * 프로퍼티 옵저버 


## Stored Property
 * 변수 저장 : `let`
 * 상수 저장 : `var`
 * 지연 저장 : `lazy var`
 * 상수와 변수 값을 인스턴스의 일부로 저장한다
 * 클래스와 구조체 에서만 사용
* 프로퍼티 선언시에 초기값을 줄수도있다.

```swift
struct Man {
var age : Int
let gender : String
}
let kang = Man(age: 20, gender: male)
kang.gender = woman
//위의 코드는 불가능하다, struct 는 value 타입이기때문에 let 으로 선언시에 프로퍼티들도 변경이 불가능해짐

// 하지만 class 의 경우엔 변경이 가능
class Man {
var age : Int = 20
var gender : String = "male"
// init 하기 귀찮아서 기본값을 줬다.
}
let kang = Man(age: 20, gender: male)
kang.age = 22
// kang 을 변수로 선언하던 let 으로 선언하던 값타입이 아닌 참조타입이기때문에 man 이라는 클래스 자체를 가진게 아닌 주소값을 가지고 있기때문에 해도 된다
```
### lazy var

* 원래 프로퍼티는 클래스나 스트럭트에 인스턴스가 생성될 당시에 만들어진다. 무조건 초기화 당시에 만들어진다. 하지만 lazy는 만들어지지 않는다. 
* 언제 만들어지냐? 내가 처음으로 사용할 때 만들어진다. 불러오거나 값을 집어넣는 등 처음 사용할 때 만들어진다. 안 써도 상관없지만, 성능개선할 수 있는 옵션같은 느낌.
* 만약 ViewController 같은걸 `lazy var VC = ViewController()`이렇게 선언할때 사용하면좋다


### observer
* 프로퍼티의 상태를 관찰하는놈
 * didset : 값이 변경된 직후
 * willset : 값이 변경되기 직전

```
var changeValue: Int = 0 {
    willSet(newValue) { //willV를 입력하지 않으면 기본값은 newValue, () 부분은 생략 가능하다
        print("newValue \(newValue)") // willSet이 먼저 불려진다.
    }
    // newValiue 위치의 값은 어떤이름을 줘도 상관없지만 

    didSet(value) { //아무것도를 입력하지 않으면 기본값은 oldValue, (value) 부분은 생략 가능하다
        print("oldValue \(value)") //0
    }
}
changeValue = 4
// newValue 4
// oldValue 0
// 이렇게 출력된다, 값이변경되는 시점 전 후에 뭔가 해야할때 이용하면 딱좋을듯

```


## Computed Property

* `struct`, `class`, `enum` 에서 사용
- 연산 프로퍼티는 저장을 할 수 있을까? -> 없다. 연산만 한다.

*  get, set 키워드를 통해 값을 간접적으로 설정 또는 받는다.
 * get: 값을 가져오는 것
 * set: 값을 집어넣는 것
* getter/setter가 다 있거나, readonly일 경우에는 get을 생략할 수 있다. writeonly일 때는 생략 불가
아래는 computed property 를 사용하지않고 메소드만을 사용한것

```
class A {
      private var total = 0 // 이 놈을 다른 곳에서 임의로 값을 바꿔버리면 안되기 때문에
      // private 를 붙여버리면 이 scope 를 벗어나면 이값에 접근이 불가능하다 (ex: A().total = 9 이렇게 못한다는 이야기)
      //그래서 메소드나 computed property 로만 접근이 가능함
      func getTotal() -> Int{   //읽기 전용
          return total
      }
      
      func setTotal(newValue: Int){     //쓰기 전용
          return total = newValue
      } //total에 값을 집어넣어선 안된다면, setTotal을 지우면 된다.
  }
```
뭔가 함수도 2개나쓰고 값에 접근하는거랑 그 값을 조정하는데 2가지를 별개로 해놓으니 지저분한거같다. 그떄 아래처럼 computed property 를 활용하면 좋다.

```
class B {
private var total = 0
var totalScore : Int {
	get {
	return total
	}
	set {
	total = newValue
	}
}
}
```
이렇게 하면 B().totalScore, B()totalScore = 9
이렇게 값을 보거나 값을 할당하거나 2가지 모두 할수있다 

## Type Property
* 특정 클래스안에 무조건 존재하는 기본값 같은 느낌
* 함수나 프로퍼티 모두에 사용 가능하다.
* 타입에 따른 속성을 정의 하는 역할
* 타입 프로퍼티는 heap,stack 과 관계 없이 data 영역에 전역 변수로서 저장된다.
* 반드시 기본값을 줘야한다
    - static method는 override 할 수 없다.
    - class method는 override 할 수 있다. `class func`
    - struct 안에는 class method를 만들 수 없다.
    - class 안에는 static property를 만들 수 있다.
    - 만약 static method 안에서 클래스 자체인 self 를 선언하면 해당 클래스가 아닌 클래스 타입을 말한다.

```
class Man {
static let gender: String = "Male"
class func nope() {
print("멈춰!")
}
}

class AlphaMale: Man {
override nope(){}
// 여기서 상속받아서 nope 를 사용하고싶어도 이미 Man 클래스에서 static 으로 선언되어 override 로 재정의가 불가능하다.
}

```

## 접근 제어
 - 프로퍼티 또는 메소드 앞에 붙이는 키워드로 표현
 - 각각의 프로퍼티, 메소드가 외부에서 접근을 어디까지 허용하는지를 표현
  - open: 다른 모듈에서 사용가능. override, subclassing 가능
  - public: 다른 모듈에서 사용가능. override, subclassing 불가능

-위의 두개는 거의 쓸일이 없다
 
  - internal: 기본 상태. 하나의 프로젝트(모듈) 내에서만 사용,(다른 외부 라이브러리를 가져와서 사용하는 SnapKit 같은경우 별도의 모듈로 취급)
  - fileprivate: 하나의 파일 (예. .swift) 내에서 사용 가능
  - private: 괄호 내에서 사용 가능. 하나의 파일에 있는 동일한 class의 extension은 제외

  * fileprivate 이랑 private 이랑 거의 차이가없다. 












