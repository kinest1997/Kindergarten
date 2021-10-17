# JSON,XML

## JSON
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
- 위 형태의 JSON 파일을 스위프트에서 디코딩할떄 받을 객체의 형태는 아래와 같다

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
let JSONList = [User]()
JSONList 는 array 이기때문에 array 메소드 전부 사용가능
```

- 만약 값이 있을수도있고 없을수도있으면 해당값에 ? 로 옵셔널선언을 해준다

### CodingKeys
- 만약 내가 변수의 이름과 JSON 파일에서 받아올 value key 값이 다를경우 아래처럼 정해줄수있다
- 이렇게 설정하면 알아서 잘 들어간다, 그대신 구조체에있는 모든 property들의 이름을 다적어줘야함.

```
enum CodingKeys: String, CodingKey {
case id, name, gay
case 키 = "height"
// 왼쪽은 내가 붙인 변수 이름, 오른쪽은 JSON 에서의 value 의 key값
    }
```

### 사용방법
1. 제일먼저 일단 JSON 파일의 url 을 알아낸다

```swift
guard let jsonURL = Bundle.main.url(forResource: "JsonData", withExtension: "JSON") else {
            print("ERROR: JSON 파일 없음")
            return
        }
```

2. 찾아낸 제이슨 파일을 디코딩하여 우리가 쓸수있게 만들어준다

```swift
do {
            let data = try Data(contentsOf: jsonURL)
            let list = try JSONDecoder().decode([User].self, from: data)
            self.userList = list
        } catch {
            print(error)
        }
```

3. 이렇게 되면 우리가 만들어뒀던 userList 라는 배열의 모음안에 우리가 만들어놓은 객체형식대로 데이터가 들어가있다, 이제 그것에 접근해서 우리맘대로 사용하면끝
```swift
userList.count
//elements 의 갯수
userList[0]
userList.first
//제일 앞의 친구에게 접근
```

4. 만약 JSON 파일에 우리가 필요없는 값들이 있다면 굳이 struct 안에서 변수를 선언해줄필요없음, 반대로 struct 에서 JSON 에게서 받아와야할 값이있는데 JSON 에는 없다면 그 property 를 반드시 `var myRealName: String?` 이렇게 옵셔널 선언을 꼭 해주자


## XML 
* eXtensible Markup Language(왜 EML 이 아닌것인가 X 가 더멋지긴함)
 * 데이터의 값 양쪽으로 태그가 있다
 * 근본이 HTML 이기에 태그가 있는데 아무리 그 태그가 줄어들어도 지저분한건 매한가지
 * xcode 에선 plist 형식으로 볼수있다(그나마 다행)
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