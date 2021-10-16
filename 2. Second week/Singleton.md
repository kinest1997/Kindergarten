# Singleton

## 싱글톤이란?

1. 앱 전역에 걸쳐서 하나의 클래스의 하나의 객체만을 생성하는것을 싱글톤 패턴 이라고 한다
2. 사용하는 이유 : 앱 내부에서 중복된값이 필요없는 단 하나의 값만을 저장하기 위해서(ex: Id, 게임진행정도 등등)
3. 클래스 메소드로 객체를 만들고 static 키워드를 이용해서 1개의 인스턴스만을 생성한다.
4. 앱전체에서 공유하며 접근가능한 객체를 생성할수있다

## 저장,접근방법
* 이미 기본적으로 있는 저장소에 접근이 가능하다
* 아래처럼 새로넣고 제거하기 가능

### 저장방법
* 앞의 값은 `Int,Float,Double,Bool,URL,Any,Object`등등 여러가지가 가능함
```swift
UserDefaults.standard.set("정보", forKey: "문자로")
```
이렇게 하면 내가 준 정보를 문자로 라는 key 를 주고 값을 저장한것

### 접근방법

```swift
UserDefaults.standard.string(forKey: "문자로")
//이러면 정보 라는 string 값이 나온다

UserDefaults.standard.removeObject(forKey: "문자로")
//이러면 데이터 삭제 가능
```


## 만드는 방법

```swift
class MySingleton {
	static var shared: MySingleton = MySingleton()
	private init() {}
//이렇게 적으면 싱글톤 객체 생성 완료
//내가 추가하고싶은 데이터를 이안에 넣어주면 된다.
//어떤형식이든 상관없다.

let iAmGay = false
let name = "name"
let myname = "강희성"
let myage = 6
}
```

## 접근방법

```
MySingleton.shared.name
//string 값 name 이 나온다

MySingleton.shared.myage
//Int 값 6 이 나온다

MySingleton.shared.iAmGay
//false 값이 나온다
```



