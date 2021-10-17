# Bundle

## 번들이란?
* 파일 시스템 내의 directory 를 말한다.
 - 자세히: 실행가능한 코드와 그 코드가 사용하는 자원들(info, plist, asset 파일 등) 을 포함하고있는 디렉토리
- path와 url 차이
 - path: The path component of the URL, 그 주소값으로 오기위한 경로
 - URL: URLs are the preferred way to refer to local files, 즉 주소값 
 - URL 안에 path 라는 요소가 들어있는것

### Main Bundle
- 앱이 실행되는코드가 있는 BundleDirectory 에 접근할수있게 도와주는 Bundle
```swift
Bundle.main.bundleURL.path
// 메인 번들의 url의 path 속성의 값을 보여준다

Bundle.main.bundleIdentifier
// 메인 번들의 식별자 보여줌

let mainBundle = Bundle.main
// 이렇게 해놓으면 편한듯?
```

## Plist
- Property List 의 준말
- Key, Value 의 Dictionary 구조로 데이터를 저장한다
- 단순 파일의 형태이다보니 외부 접근이 쉽고 보안이 취약하다
- bundle 에 저장된 Plist는 쓰여진 데이터만 사용할수있고 읽기만 가능하다. 
- 쓰고싶다면 bundle 이 아닌 Document 에 저장하면 읽고 쓸수있다.
- key 의 경우 무조건 String 값
- Value 는 `Dictionary, Array, String, Number, Bool, Date, Data` 값이 들어갈수있다.

## 번들의 plist 를 document 폴더로 복사하기

1. 번들의 경로를 확인

```swift
guard let bundleURL = Bundle.main.url(forResource: "내가만든이름", withExtension: "plist") else {
	//extension 은 확장자 명
            return
        }
```

2. 복사해서 넣어줄 document 의 주소를 확인

```swift
let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("내가만든이름.plist")
// 도큐멘트 디렉토리 안에 0번 인덱스 위치에 내가만든이름.plist 파일이 일단 생성된다, 진짜 아무것도없는 그냥 파일 자체
```

3. 두파일의 경로를 찾아냈다면 이제 document 에 파일이 없을때 번들에있는 plist 를 복사해주면된다.
```swift
if !FileManager.default.fileExists(atPath: documentURL.path) {
	//만약 path 안에 파일이 존재하지않는다면? 
            do {
                try FileManager.default.copyItem(at: bundleURL, to: documentURL)
               // 번들url 에 있는 파일을 도큐먼트 url 로 복사한다
            } catch let error {
                print("ERROR", error.localizedDescription)
            }
        }
```

4. 이제 폴더를 만들었으니 내가 받아올 데이터에 인코딩 디코딩 할수있는 타입의 객체를 만들어준다.
- 내가 받을 정보를 property 형태로 가지고있는 객체를 만들어준다
- 기왕이면 key 값과 property 의 이름이 완전히 같도록 

```swift
//만약 내가 받아올 정보가 key value 값으로 된 파일인데 1개 묶음당 4개의 정보가 담겨있다면, 근데 1,2 번값은 데이터에있을지 없을지 모른다면?

var friendList = [SomeStruct]()
// 이말인 즉슨 SomeStruct 의 타입을 가진 친구들의 array 를 생성한다는것

struct SomeStruct: Codable {
	let one: String?
	let two: Bool?
	let three: Int
	let four: Array
}

//받아올 파일의 생김새는 아마 이럴것

[
	{
		"one": "사랑행"
		"two": false
		"three": 6
		"four": [
				123,
				456,
				789
				]
	}
]

//아래 함수같은 형태를 내가 데이터를 쓰고싶은 곳에 extension 형태로 넣어주고 사용한다.
func loadFromJSON() {
        // 제이슨 파일의url 찾기
        guard let JSONURL = Bundle.main.url(forResource: "SomeStruct", withExtension: "JSON") else {
            print("ERROR: JSON 파일 없음")
            return
        }
        
        do {
            let data = try Data(contentsOf: JSONURL)
            let list = try JSONDecoder().decode([SomeStruct].self, from: data)
            self.friendList = list
            //위의 마법같은 3줄로 디코딩 완료 내 friendlist 가 json에서 준 정보로 대치됨
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }
```

5. 이러면 이제 document 에 plist 도 생기고 그곳에 정보를 넣을수도있고 그 정보를 가져올수도있다. 일단 가져오는법

```swift
do {
    self.friendList = try PropertyListDecoder().decode([Friend].self, from: data)
    //나의 friendlist라는 배열은 PListDecoder 에 의해서 [Friend] 배열 타입으로 데이터로부터 생성된다
} catch let error {
            print("ERROR", error.localizedDescription)
}
```

6. 데이터 가져오는법 전체코드다

```swift
///Bundle에 추가된 Custom Plist를 불러오기

    func loadFromBundle() {
        //1-1. 가지고 오고자 하는 Bundle의 경로를 확인
        //        let path = Bundle.main.path(forResource: "Friends", ofType: "plist")
        guard let bundleURL = Bundle.main.url(forResource: "Friends", withExtension: "plist") else {
            return
        }
        
        //1-2. 가지고 오고자 하는 Document의 경로를 확인
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Friends.plist")
        

        //1-3. 만약에 Document에 파일이 없다면 Bundle의 파일을 복사
        if !FileManager.default.fileExists(atPath: documentURL.path) {
            do {
                try FileManager.default.copyItem(at: bundleURL, to: documentURL)
            } catch let error {
                print("ERROR", error.localizedDescription)
            }
        }
        
        // 2. 해당 경로에 있는 데이터를 불러내기
        guard let data = FileManager.default.contents(atPath: documentURL.path) else {
            print("ERROR: 파일을 찾을 수 없음")
            return
        }
        
        // 3-1. 불러온 데이터를 Codable한 객체로 decoding
        do {
            self.friendList = try PropertyListDecoder().decode([Friend].self, from: data)
        } catch let error {
            print("ERROR", error.localizedDescription)
        }

        /* 3-2. 전통적인 방식으로 객체를 생성하여 넣어주기
         do {
         guard let array = try PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: Any]] else {
         return
         }
         
         array.forEach {[weak self] dictionary in
         guard let id = dictionary["id"] as? Int,
         let name = dictionary["name"] as? String,
         let typeRawValue = dictionary["type"] as? String,
         let type = FriendType(rawValue: typeRawValue) else {
         return
         }
         let friend = Friend(id: id, name: name, type: type)
         self?.friendList.append(friend)
         }
         } catch let error {
         print("Error", error.localizedDescription)
         }
         */
    }
```

7. 그리고 이제 데이터를 넣는법 

 1. 제일먼저 데이터를 넣을 경로를 찾는다(아마 도큐먼트 폴더 안에있는 plist 겠지)
 2. 그리고 내가 가진 객체의 정보를 plist 에 넣을수있는 정보의 형태로 인코딩 해준다
 3. 인코딩으로 생성된 데이터를 내가 원하는 URL 으로 넣어준다.

```swift
func upload(_ friendList: [Friend]) {
        //1. 쓰고자 하는 경로 가져오기
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Friends.plist")
        
        //2. 쓰고자 하는 Codable 객체 형태로 인코딩 하기
        do {
            let data = try PropertyListEncoder().encode(friendList)
            // 3. 생성된 데이터를 경로에 쓰기
            try data.write(to: documentURL)
        } catch let error {
            print("ERROR", error.localizedDescription)
        }
    }

```

8. 데이터를 읽고 쓰는 이 함수들은 전부 내가 쓰고자 하는 객체에 extension 형식으로 추가해서 적어준다음 그 객체에서 사용하면된다

