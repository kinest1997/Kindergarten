# delegate


* 데이터를 주고받기 위한 방법론 중의 하나
* 1번 뷰에 적은 내용을 2번 뷰에 표시하고자 할때 1,2번 뷰 사이에 데이터를 주고 받기 위한 방법
* protocol 을 이용하여 데이터를 전달

## Protocol
* delegate 이전 프로토콜을 알아야한다
* 일종의 규칙, 밑바탕만 제시해주고 만드는건 프로토콜을 채택한 쪽에서 디테일하게 정한다.
* 프로토콜은 class 처럼 상속했다고 하지않고 *채택* 했다고 한다.
* 하나의 class 에서 여러개의 protocol 을 채택가능하다, 상속과 같은 방식으로 표시

```swift
class ViewController: UIViewController, TestDelegate, IntegerToString {
}
//위의 클래스는 UIViewController 를 상속받으며 뒤의 2가지는 전부 protocol 이다. 그냥 계속 , 콤마 찍으면서 적어주면 여러개 채택가능하다.
```

---


## 기본

* A 가 B 에있는특정 데이터를 사용하고싶을때

1. 프로토콜을 생성하여 원하는 형태로 데이터를 뱉거나 뭔가 수행하는 함수의 형태만 작성

```swift
protocol TestDelegate: AnyObject {
//프로토콜 타입을 anyobject 로 해야 어떤 변수의 타입으로 이 프로토콜을 정해줄수있다
    func hiMaker(data: String) -> String
    //위에건 return 이 있는 함수, 아래건 return 이 없는 함수
    func labelChange(data: String)
}
```

2. 데이터를 받을 MotherViewcontroller 에는 프로토콜을 채택해주고
프로토콜형식에 맞게 함수를 작성해준다.

```swift
class ViewController: UIViewController, TestDelegate, IntegerToString{
    func hiMaker(data: String) -> String {
        return "안녕 난 \(data)이야."
    }
    
    func labelChange(data: String) {
        topCenterLabel.text = data
    }
    
```

3. 데이터를 보내는 ChildViewController에는 `weak var 변수이름: protocolName?` 를 적어준다. 

```swift
   weak var delegate: TestDelegate?
   weak var delegate2: TestDelegate?
```

4. MotherViewController 가 ChildViewController 의 delegate(대리자) 라는것을 작성해줘야함

```swift
let CVC = ChildViewController()
        CVC.delegate = self
        CVC.delegate2 = self
```


이렇게 하면 delegate 의 기본 형태는 완성
원래는 b의 데이터로는 뭘해도 a에 있는 친구들에게 영향을 미칠수가없었는데 이방법을 통해 할수있게된다.



