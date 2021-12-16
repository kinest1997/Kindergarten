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

3. 객체의 속성중 하나를 프라이 머리 키로 지정해줄수있다, id 를 프라이머리 키로 저장해주면 이제 id 가 같은사람은 존재할수없다. 아래 코드를 class 안에 넣어주면 된다.

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

var buddyList: Results<Buddy>?
//근데 이 버디 리스트는 자동으로 업데이트 되지않는다. 내가 새로운친구를 추가해주면 매번 내 realm 저장소의 데이터를 이 buddyList에 넣어주는걸 해줘야한다. 그건 아래에서
//이 그지같은놈...

//realm 안에 생성된 객체들의 배열을 만들어준다.
```

5. 새로운 객체 넣는법, 제거하는법, 기존의 데이터 불러오는법

### 넣는법

```swift
func uploadToRealm(at index: Int) {
try! realm.write {
        let newBuddy = Buddy()
        newBuddy.id = index
        newBuddy.name = "강희성"
        newBuddy.type = "고등학교동창"
        realm.add(newBuddy)
        //마지막에 반드시 realm.add 이거 해줘야 추가가 된다 
}
}
```

### 제거하는법

- 특정 property 를 가진 객체를 제거하는 방법, 여러개를 지울수도있다
- filter 를 사용한다.

```swift
func removeFromRealm(at index: Int) {
try! realm.write {
            let removeBuddy = realm.objects(Buddy.self).filter { $0.id == index }
            realm.delete(removeBuddy)
        }
    }
```

### 기존데이터 불러오는법
- 단순 불러오는법이 아니였다. 
- realm 저장소에 데이터를 추가하면 내 코드안의 `var buddyList: Results<Buddy>?` 에는 자동으로 추가되는것이 아니다.
- 데이터를 추가하고난 뒤에 항상 내 realm 저장소와 code 안에서의 리스트를 동기화 시켜주는 아래 과정이 필요하다.

```swift
func loadFromRealm() {
        self.buddyList = realm.objects(Buddy.self)
    }
    //나의 버디 리스트가 realm에 저장된 버디 타입의 친구들로 채워진다.
```