# Realm

## 무엇?
- Realm은 작업 속도가 빠른 모바일용 데이터베이스 라이브러리이며 오픈소스입니다. -> 라고한다
- SQLite 및 Core Data의 대안이다

## 사용법

1. 제일먼저 오픈소스 라이브러리니까 설치해준다. 
 - swift package manager 라는 좋은방법으로 https://github.com/realm/realm-cocoa.git 긁어와서 설치
2. 제일먼저 Model을 정의해준다, 우리가 아는 일반적인 모델, 항상 `import RealmSwift` 해주자,
 - 모델을 정의할땐 class 로만 하는건가? 왜 인터넷엔 전부다 class, 그리고 변수 선언은 죄다 `@objc dynamic` 이고 `@Persisted` 를 붙여서 선언하는 사람은 또뭐?

```swift
import RealmSwift

class Buddy: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
}
```

3. 프라이 머리 키를 지정해줄수있다, id 를 프라이머리 키로 저장해주면 이제 id 가 같은사람은 존재할수없다. 아래 코드를 class 안에 넣어주면 된다.

```
override static func primaryKey() -> String? {
      return "id"
    }
```

4. 이제 준비가 끝났고 이 데이터를 사용할 뷰컨으로 가서 realm 저장소를 만들어준다.

```swift
import RealmSwift

let realm = try! Realm()
//이러면 realm 저장소 생성

var 
```

5. 난관봉착