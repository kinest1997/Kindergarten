# JSON,XML

## 이게무엇?

### JSON
* JavaScript Object Notation
 * 데이터를 전송하거나 저장할때 많이 사용되는 경량의 데이터 교환형식
 * 자바스크립트에서 객체를만들때 사용하는 표현식을 의미한다.
 * 서버와 클라이언트간의 교류에서 일반적으로 많이 사용된다.
 * JSON문서 형식은 자바 스크립트 객체의 형식을 기반으로만들어졌다
 * 자바 스크립트 문법과 굉장히 유사하지만 텍스트 형식일 뿐이다.
 * 자바스크립트에서 사용하지만 특정 언어에 종속되지않아 대부분의 프로그래밍언어에서 JSON포맷의 데이터를 다룰수있는 라이브러리를 제공해준다(ex: Swift 에서는 JSONDecoder 같은거)

- 예시

```
[
    {
        "id": 0,
        "name": "kang",
        "gay": false,
        "height": 170.3
    },
    {
        "id": 1,
        "name": "ksdas",
        "gay": false,
        "height": 170.3
    },
    {
        "id": 2,
        "name": "sdasasdasas",
        "gay": true,
        "height": 123131
    },
    {
        "id": 3,
        "name": "kdasdsdas",
        "gay": false,
        "height": 170.322
    },
    {
        "id": 4,
        "name": "dks",
        "gay": false,
        "height": 1902.1
    }
    

]
```
- 위 형태의 json 파일을 스위프트에서 디코딩할떄 받을 객체의 형태는 아래와 같다

```swift
struct User: Codable {
    var id: Int
    var name: String
    var gay: Bool
    var 키: Double

}
```

- 그리고 저 제이슨 파일의 목록을 내가 사용할때는 아래처럼 해놓으면 사용가능
```
let jsonList = [User]()
jsonList 는 array 이기때문에 array 메소드 전부 사용가능
```

- 만약 값이 있을수도있고 없을수도있으면 해당값에 ? 로 옵셔널선언을 해준다

### CodingKeys
- 만약 내가 변수의 이름과 json 파일에서 받아올 value key 값이 다를경우 아래처럼 정해줄수있다
- 이렇게 설정하면 알아서 잘 들어간다, 그대신 구조체에있는 모든 property들의 이름을 다적어줘야함.

```
enum CodingKeys: String, CodingKey {
case id, name, gay
case 키 = "height"
// 왼쪽은 내가 붙인 변수 이름, 오른쪽은 json 에서의 value 의 key값
    }
```






### XML 
* eXtensible Markup Language(왜 EML 이 아닌것인가 X 가 더멋지긴함)
 * 데이터의 값 양쪽으로 태그가 있다
 * 근본이 HTML 이기에 태그가 있는데 아무리 그 태그가 줄어들어도 지저분한건 매한가지
 * xcode 에선 plist 형식으로 볼수있다
 * 뭔지만 대충알기위해 아래 예시

- 뭔가 JSON 처럼 하나의 덩치 안에 부속품들이 들어있는 형상인데 사족이 너무길고 지저분해보임
<recipename>
<key>value</key>
</recipename>

```
<?xml version="1.0" encoding="UTF-8"?>
<recipe>
<recipename>Ice Cream Sundae</recipename>
<preptime>5 minutes</preptime>
</recipe>
```