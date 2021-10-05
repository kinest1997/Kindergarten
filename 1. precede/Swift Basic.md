# Swift

## 1. Comment
주석 이라고 한다

* 1줄을 주석처리할때  코드 양끝에 `/`을 붙여주면 그 문장은 읽지않고 넘어간다.   
```
/someCode/
```    

* 여러줄을 주석처리 하고싶을때  코드 시작부분에 `/*`  끝부분에 `*/` 를 붙여주면 그 구간은 읽지않고 넘어간다  
```
/* longerCode */
```

## 2. Tupple

1개의 자료에 2가지 이상의 데이터가 들어있을때 
그것을 튜플 형태라고 한다. 

ex : 좌표` (x,y)`  
튜플 값은 아래처럼 접근이 가능하다  

```
let coordinate1 = (x : 2, y : 3)
coordinate1.0
// 2 
coordinate1.1
// 3
coordinate1.x
// 2
coordinate1.y
// 3

let (x2,y2) = coordinate1
x2
// 2
x3
//3
```

## 3. Boolean

`true`, `false` 2가지 값만을 가지는 형태  
명제의 참과 거짓을 구별할때 사용한다.  
`>`, `<`,`==` 3가지가 있다.  
`&&`,`||` 2가지 를 이용하여 다양한 조건을 만들어낼수있다.

```
let yes = true
let no = false

let threeIsGreaterThanTwo = 3 > 2
// 위의 조건은 true 이다
if threeIsGreaterThanTwo {
    print("참이다")
} else{
    print("거짓이다")
}

let heeSungIsMale = true
let yourNameKang = true
let myNameKang = false
// 두 불리언값을 가지는 형태를 and 나 or 값으로 더 표현 가능
let heesungAndMale = heeSungIsMale && yourNameKang
// && 즉 and 는 둘다 참이여야 true 값을 반환 한다
let kangOrMale = myNameKang || heeSungIsMale
// || 즉 or 은 둘중 하나만 참이여도 true 값을 반환한다
```

## 4. if else
```
if 조건 ....{
    조건이 참인 경우 수행하는 코드
 } else if ...조건 {
 // if 조건이 거짓일때 새롭게 다른 조건의 참거짓을 확인하여 수행하는코드
 }
 else {
// 위의 조건들이 모두 거짓일때 수행하는 코드
 }
 }
```
 

 예시는 아래와 같다

```
let a = 9  
let b = 14  
let c = 10  
if a > b {
    print("a가 b보다 크다")
} else if a > c {
    print("a가 c보다 크다")
}else {
    print("a가 제일작다")
}
```
 
## 5. Scope


```
func countDown(number : Int) {
    // 여기서 var count 변수는 countnum안에서만 유효한 변수이다
    var count = number
    
    for _ in 1...number {
        print("\(count)")
        count -= 1
        if count == 0{
            print("GO!")
            break
            // break 코드 사용시 for 문을 즉시 종료시킨다
        }
    }
}
// var count 는 func 안의 변수이므로 밖에서 사용할수없다
countDown(number: 8)
```

## 6. while

while 문에는 repeat while , while 문 2가지 종류가 있다

* `while`문  
* 조건 검사를 먼저 실행한 뒤 조건이 참일경우 코드를 실행 한다.
*  조건 -> 코드수행 -> 조건

```
while 조건 {
code
}
//형식은 위와 같고 아래 예제가 있다

var i = 0

while i < 10 {
print("아직이야..")
if i == 10 { break 
//break 코드 사용시 아래의 코드는 수행하지않고 while 문을 종료한다.}
i += 1
}

```

* `repeat while` 문
*  코드를 먼저 실행한 후 조건을 검사한다.
*  코드수행 -> 조건 -> 코드수행

```
repeat {
code
} while 조건
// 형식은 위와 같고 예제는 아래에 있다

var j = 0  

repeat {
print("이친구도 아직이야..")
if j == 6 {
break
}
j += 1
} while j < 10
```

## 7. for loop
* `...`,`..<`2종류가 있다
* `x...y`  x 이상 y 이하 를 뜻한다.
*  `x..<y` x 이상 y 미만을 뜻한다
*  for 루프 에서 앞부분 `for i in 1...4 ` i 부분의 문자는 어떤것으로도 할수있으며 루프안에서만 유효한 것이다. 

```
let closedRange = 1...10

let halfClosedRange = 1..<9
var sum = 0
for i in 1...10 {
    print("sum--\(sum)")
    sum += i
}
```

만약 for 문의 앞부분 문자를 scope 안에서 사용하지않을경우 언더바 _ 를 사용하여 없애줄수있다

```
for _ in 1...3{
    print("hurai")
}
```

`x % y == z`  
// x 를 y 로 나눴을떄 나머지가 z 가 된다는 뜻, % 는 나눈 후의 나머지를 구하는데 사용,

```
for evenNum in closedRange {
    if evenNum % 2 == 0 {
        print("\(evenNum)")
    }
}

// 위의 코드와 동일하지만 다른 표현방식이다
for evenNum in closedRange where evenNum % 2 == 0 {
    print("\(evenNum)")
}

//continue
for evenNum in closedRange {
    if evenNum == 4 {
        continue
        // continue 코드 사용시 아래 남아있는 코드는 실행시키지않고 다음루프로 넘어간다
    }
    print("\(evenNum)")
}
```


for loop 중첩도 가능하다, 하지만 성능,가독성 면에서 매우 떨어진다  
구구단 

```
for i in closedRange{
    for j in halfClosedRange{
        print("\(i)x\(j)=\(i*j)")
    }
}

```

## 8. switch

* 확인하려는 변수가 블럭안에서 가능한 케이스일경우 수행시킨다
* 기본 형태는 아래와 같다
*  변수가 모든케이스에 해당하는 경우를 제외하고는 default 값이 반드시 있어야한다.
* 기본 형태는 아래와 같다

```
switch 변수 {
case :
case :
default :
 } 
```

예시


```
let number1 = 8
switch number1 {
case 0...10 :
    print("this is zero to ten")
//만약 case 중에서 위에서 먼저 부합하는게 나오면 아래의 케이스는 수행되지않고 넘어간다
case 8 :
    print (8)
// 위의 case 에 해당하는것이 없을때 아래의 default 값을 출력한다
default :
    print("i have no idea")
    }
    
 let pet = "bird"
switch pet {
case "pet","dog","bird" : print("Oh it is pet")
default : print("it's not a pet")
}

let number2 = 18
switch number2 {
// switch 문에서도 where 를 이용하여 조건을 추가시킬수있다
case _ where number2 % 3 == 0 :
print("3의 배수입니다")
// 언더바 _ 를 사용시 해당하는 부분을 사용하지않는다는 뜻
default :
    print("3의 배수가 아닙니다")
}
```
* 튜플의 형태를 가진것도 switch 구문을 이용할수있다.

```
//튜플형태를 가진것도 switch 를 사용할수있다
let coordinate2 = (3,9)
switch coordinate2 {
case (0,0) :
    print("원점에 있네요")
case (_,0) :
    print("x축 위에있네요")
//만약 언더바로 표시한 부분의 값을 사용하고싶을때 let x 등의 문자로 표시하면 사용가능하다

case(0,let y) :
    print("y축 위에있네요, \(y)좌표")
case(let x, let y) where x == y :
    print("\(x),\(y) 같다잉")
default :
    print("왜 거기있니")
}
```

## 9.  function
* 기능을 수행하는 코드 블록
* 기본 형태는 아래와 같다

```
function() {
code
}
```
### 함수와 메소드의 차이점
* 함수는 어디서나 독립적으로 사용 가능하다
`functionName()`
* 메소드는 object 에 속해서 사용된다.
`object.methodName()`

```
//변수가 1개인 함수
//변수를 100배 곱하여 출력하는 함수
func multiply1(num : Int ) {
    print("\(num * 100)")
}
multiply1(num: 100)

//만약 함수에서 parameter의 이름을 안적고 변수만 적고싶을때 앞에 언더바를 넣으면 된다.
// 하지만 이름을 안적으면 헷갈릴수도있으니 그냥 적는게 나은듯 하다
func multiply3(_ num : Int ) {
    print("\(num * 100)")
}
multiply3(20)
//만약 parameter에 기본값이 있을때 지정해줄수있고 함수 사용시에 parameter를 적지않으면 기본값을 사용한다
func multiplyTwo(first : Int = 4, second : Int) {
    print("\(first * second)")
}
multiplyTwo(second: 12)
//물론 값을 적으면 기본값이 아닌 새로 입력한 값을 사용한다
multiplyTwo(first : 21,second: 5)

```
* 만약 함수를 이용하여 구한값을 또 다른곳에 사용하고싶다면?

```
//100배 곱한값을 구하는 함수 + 그 값을 출력하는것
func multiply2(num : Int) -> Int {
    // -> x x의 위치에 내가 이 함수로 얻고싶은 값의 형태를 적어준다 ex : String, Int 등등
    return num*100
}
//함수로 출력한 값을 특정 상수에 할당시킬수있다
let hundread = multiply2(num: 100)
print(hundread)
//함수로 출력한 값을 상수에 할당시키지않고 바로 출력할수있다
print(multiply2(num: 20))

func fullNameMaker (_ first : String,_ last : String) ->String {
    return "\(first)\(last)"
    //return 뒤의 값은 반드시 위 식에서 지정한 값의 형태로 적어야한다 ex : String 이면 "" 의 형태를 가진 String 으로
}

let myName = fullNameMaker("Kang","heesung")
print(myName)
```
### overload
*  함수의 이름은 같지만 parameter 를 다르게 하여 다양한유형의 호출에 응답이 가능하는것
*  같은이름을 가진다
*  하지만 다른 행동을 취한다.

```
func myBrand (brand : String, price : Int) {
print("\(brand)의 제품을 나는 \(date)가격에 샀어")
}
func mybrand (brand : String, price : Double) {
print("\(brand)의 제품을 나는 \(date)가격에 샀어")
}
```

### in - out parameter
* 함수의 밖에서  존재하는 변수를 가져올때 그 변수는 let 형태의 상수로 가져온다
*  그래서 함수내에선 그 변수의 값을 변경시키는게 불가능하다
*  하지만 그 변수를 var 형태로 사용하려면 inout 이라는 수식어를 parameter type 앞에 붙여주면된다.

```
var value = 1
func increasement(_ value : inout Int){
    value += 1
    print(value)
}
increasement(&value)
// 매개변수 앞에 & 을 붙여줘야한다
``` 

### function 을 함수의 parameter로 사용하는것

```
func add(_ a : Int , _ b : Int) -> Int {
    return a + b
}

func subtract(_ a : Int , _ b : Int) -> Int {
    return a - b
}

var function = add
function(4,2)
function = subtract
function(4,2)

//함수 이름을 계산기 라고 했을때 그 계산기에 덧셈밸셈 곱하기 나눗셈등의 함수를 정하고
 숫자를 받은다음 그 함수를 대입한것.
func printResult(_ function: (Int,Int) -> (Int), _ a : Int, _ b : Int){
// 매개변수로서 들어올수 있는 함수의 형태는 2개의 정수값을 받아서 
   1개의 정수값을 반환 하는 형태만 들어올수있다.
    let result = function(a,b)
    print(result)
}

printResult(add, 9, 3)
// 12
```

* 함수는 한가지 일만 할수있도록 코드를 짜는게 좋다
* 값을 구하는 함수와 그 값을 출력하는 함수를 하나로 합쳐서 만들지 말고 분리해서 만들자.
* 재사용성을 높이기 위함
* 가능한 한 10줄을넘지않게 만들자



## 10. array

* 각 elements 들을 순서에 따라서 배열해놓은것
*  배열 안에는 같은 type 만 존재할수있다.
*  `String` 끼리만, `Int` 끼리만.
*  index 라고 불리는 순서가 존재한다
*  1부터 시작하는게 아닌 0 부터 시작한다 (ex : 0,1,2,3,4...)
*  각 요소들의 순서가 중요하게 쓰일경우 사용한다.

### 배열에서 주로 사용하는 method 
* count  

```
// array 내의 elements 갯수를 알려준다
var array : Array<Int> = [2,4,6,8]
array.count
// 4
```

* isempty  
 
```
// array 가 현재 비어있는 상태인가 
array.isempty
// false
// Bool 값을 반환한다

```

* append

```
// array  에 elements 를 추가하는것
array.append(1)
array += [3,5]
even.append(contentsOf: [18,20])
// 3가지 방법이 있으며 전부다 추가하는것이다
```

* insert

```
array.insert(9, at : 3)
// 9 를 3번 index에 추가하는것
append 와 비슷하지만 index 를 지정해서 할수있다.
```


* swapAt

```
array.swapAt(2,4)
//2 번과 4번 index 에 위치한 elements를 자리바꿈한다.
```

* remove

```
array.remove(at : n)
// n 번째 index에 위치한 element 를 제거한다.
//3번 index 에 위치한것을제거한다면, 그뒤에 다른elements 의 index 는 한칸씩 당겨져온다


*removeall

array.removeAll()
// array안의 모든 elements 를 제거한다, 빈 array로 만들어버림
```

* dropFirst,Last

```
dropFirst(n)
앞에서부터 n 번째 까지의 elements 를 제거하는것

dropLast(n)
뒤에서 부터 n 번째 까지의 elements 를 제거하는것
```

* enumerated

```
// array 의 index 값과 요소의 값 2가지 모두에 접근하고 싶을때 사용
var array : Array<Int> = [1,2,3,4]
for (index,num) in array.enumerated() {
    print("\(index+1)번째 숫자는 \(num)입니다")
    //index,num 변수이름을 다른 어떤것으로 바꿔도 괜찮다.
}
/*
1번째 숫자는 1입니다
2번째 숫자는 2입니다
3번째 숫자는 3입니다
4번째 숫자는 4입니다
*/
```

* 특정 index 에 접근
	
```
array[2]
//2 번 index(2번째 가 아닌 0,1,2 즉 3번째) 에 접근하여 그값을 보여줌
```
* contains

```
array.contains(4)
array 가 4를 포함하고있는가?
// true
// isempty 와 같이 bool 값을 반환한다

```

* 등등 엄청많다




## 11. Dictionary

* array와 다르게 순서가 존재하지않는다.
* key 와 value 의 짝으로 구성된다
* array 는 순서 기반으로 값을 관리, dictionary 는 key 값을 기반으로관리(순서 상관 없음)

### Dictionary 만드는법
```
// 내가 가진 애플 제품을 key , 그 제품의 세대를 value 로 하는 dictionary 
var myApple : Dictionary<String,String> = [ "iphone": "xs", "ipad mini": "5" ]
var myApple : [String : String] = [ "iphone": "xs", "ipad mini": "5" ]
2가지모두 동일한 선언 방법이지만 1번은 array,set,dictionary 모두 통일된 방법이고 
2번은 좀더 간단한 방법이다 본인이 편한대로 하자.
```

* 만약 특정 key 값을 가진 value 가 존재하는지 모를때는 optional binding 을 이용한다

```
if let score = scoreDic["jason"] {
    score
} else {
    //...score 없음
}
```

### Dictionary 기본적 사용법

```
myApple["iphone"]
// xs 가 나오게 된다


//scoreDic=[:]
//이렇게 하면 빈 딕셔너리로만들기 가능

scoreDic["kim"] = 90
//해당하는 부분의 내용을 바꾸고싶을때 호출후에 숫자 넣어주면 변경 가능


scoreDic["Jack"] = 99
//없는 사람 추가하고싶으면 내용 변경과 동일하게.. 내가볼땐 위에 수정하는것도 그냥 추가같은개념으로 하는거같다

scoreDic["kim"] = nil
//이렇게 하면 제거할수있다


//for loop
for (name,score) in scoreDic{
    print("\(name),\(score)")
}
//위의 배열과 비슷하지만 enumerated가 없이도 2가지값을 뽑아온다,
 왜냐하면 key 값에 1가지 value가 연결되어있어서 
 한가지를 뽑으면 key 와 value 값이 딸려나오니까

for key in scoreDic.keys {
    print("\(key)")
}
//key 값만 나오게 뽑아낼수있다 keys 메소드는 dictionary 에서 key 값만 빼오는것

var myIndex : [String : String] = ["name" : "Kang" , "job" : "student" , "city" : "hwaseong"]
myIndex["city"] = "busan"
func printCityName(dic : [String : String]) {
    //값이 없을수도있으니 옵셔널 바인딩 해준다
    if let name = dic["name"] , let city = dic["city"]{
        print("\(city),\(name)")
    } else {
        print("없습니다")
    }
}

printCityName(dic: myIndex)
// busan 과 Kang 을 출력한다.
```

## 12. Set

* 순서가 없으며 중복된값이 없는 유일한 값만 가진다
* 만약 중복된 값이 있다면 1번만 표시한다. 

### Set 기본적사용법

```
set 생성 방법

var someSet : Set<Int> = [1,2,3,1]
// 초기값에 1이 2번들어가있지만 표시되는건 1,2,3 뿐이다
someSet
// [1,2,3]

//중복된 값이 있어도 그값은 1번만 표시된다, 그점이 array와 다른점
someSet.isEmpty
// false

someSet.count
// 4

someSet.contains(1)
// true

someSet.insert(6)
// [1,2,3,6]

someSet.remove(1)
// Set 에는 순서가없기때문에 1 의 값을 그냥 제거한다
```

## 13. closure
* 이름이 없는 method
* closure 에는 3가지 타입이 있다.

1. global : 우리가 아는 func 키워드를 사용하여 만드는 함수
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

## 14. struct
* 관계가 있는것들을묶어서 표현한것

* 사용 예시

```
//흩어진 아이들을 묶어서 표현
struct Lecture : CustomStringConvertible {
    //프로토콜
    //computed property : 직접 저장하지는 않고 가공시킨 값
    var description: String {
        return "Title: \(name), instructor: \(instructor) "
    }
    //아래 부분이 stored properties : 직접 저장된 값
    let name : String
    let instructor : String
    let numOfStudents : Int
    
    func printLectureName(from instructor : String, lectures : [Lecture]) {
        var lectureName = ""
        for lecture in lectures {
            if instructor == lecture.instructor {
                lectureName = lecture.name
            }
        }
        print("강사님 이름은! \(lectureName)")
    }

}
//아래 부분이 method


let lec1 = Lecture(name: "ios Basic", instructor: "Jason", numOfStudents: 9)
let lec2 = Lecture(name: "ios middle", instructor: "kang", numOfStudents: 9)
let lec3 = Lecture(name: "ios advanced", instructor: "kim", numOfStudents: 9)
let lectures = [lec1,lec2,lec3]

lec1.printLectureName(from: "kang", lectures: lectures)



print(lec1)

struct Person {
    var firstName : String {
        //didSet 은 stored propertyd 에서만 사용가능하며 값이 바뀔때 알기위함
        //값을 바꾸고 난 뒤에 이 값이 이렇게 바뀌었다고 알려줌
        didSet {
            print("didSet: \(oldValue)->\(firstName)")
        }
        //willSet은 값이 이렇게 바뀔것이다 라고 바뀌기 전에 알려준다
        willSet {
            print("willSet: \(firstName)->\(newValue)")
        }
    }
    var lastName : String
    //만약 let 으로 한다면 바꿀수없다, 위의 값은 stored property
    
    //lazy property 는 왜쓰는가?
    // 맨처음 사용전까진 불러올필요없는 친구들(부담스러운?) 은 이렇게 lazy var로 선언해놓는다, 코스트가 큰경우이거나, 모든사용자에게 사용되지않는경우에
    lazy var isPopular: Bool = {
        if fullName == "Jay Park"{
            return true
        }else{
            return false
        }
    }()
    
    //아래의 computed property 는 var 키워드만 가능, read only
    var fullName : String {
        //원래는 read only 이지만 get,set을 해주면 입력도 가능해진다
        get{
            return "\(firstName) \(lastName)"
        }
        set{
            if let firstName = newValue.components(separatedBy: " ").first {
                self.firstName = firstName
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
        
    }
    //type property
    static let isAlien : Bool = false
}
var person = Person(firstName: "jason", lastName: "lee")

person.firstName
person.firstName = "Kang"

person.lastName = "heesung"

person.fullName = "Kang heesu"
person.fullName
person.firstName
Person.isAlien

person.isPopular
//computed property , method

//property : 호출시 값을 하나 반환한다
//method : 계산이 많이 필요하거나 데이터베이스나 파일에 접근해야하면 메소드 사용


struct Math {
    static func abs(value: Int) -> Int {
        if value > 0 {
            return value
        }else {
            return -value
        }
    }
    var ageOfMath = 0
    mutating func increasing() {
        ageOfMath += 1
    }
    
}
extension Math {
    static func square(value: Int) -> Int {
        return value * value
    }
    static func half(value : Int) -> Int {
        return value/2
    }
}


//struct에 추가 메소드를 넣고싶을때 익스텐션을 이용하여 넣어준다
extension Int {
    func square() -> Int {
        return self * self
    }
}
```

## 15. class
* heap 이라는 공간에 생성

































