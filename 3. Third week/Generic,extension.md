# Generic

## 이게뭔가?
- 어떤 타입에도 유연한 코드를 구현하기 위해 사용되는 기능
- 코드의 중복을 줄이고, 깔끔하고 추상적인 표현이 가능하다.
- 함수의 파라미터 타입에 관계없이 범용적으로사용할수있는 함수

- 이친구는 좀더 공부해야할듯, 아직 함수 작성하는게 익숙하지않다

- 일단 예시는 넣어놨음

```
let jsonDecoder = JSONDecoder()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = ""
jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

extension Date {
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> Date? {
        guard let dateString = try? values.decode(String.self, forKey: key),
              let date = from(dateString: dateString) else {
                  return nil
              }
        
        return date
    }
    
    static func from(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        
        return nil
    }
}

extension URL {
    static func parse<K: CodingKey>(_ values: KeyedDecodingContainer<K>, key: K) -> URL? {
        guard let urlString = try? values.decode(String.self, forKey: key),
              let url = URL(string: urlString) else {
                  return nil
              }
        
        return url
    }
}

struct Some: Decodable {
    let date: Date?
    let url: URL?
    
    enum CodingKeys: String, CodingKey {
        case date, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.date = Date.parse(container, key: .date)
        self.url = URL.parse(container, key: .url)
    }
}
```


# Extension

## 먼가?

- Extensions은 기존 클래스, 구조체, 열거형, 프로토콜 유형에 새로운 기능을 추가하는것

### 할수있는것
1. computed instance properties, computed type properties 를 추가하는것 (그냥 저장프로퍼티는 넣을수없다.)

```
extension Double {
	var km: Double { return self * 1_000.0 }
}
```

2. instance methods, type methods 를 정의하는것(함수작성)

```
extension UIFont {
    static func myFont(ofSize: CGFloat, weight: Weight = .regular) -> UIFont {
        switch weight {
        case .medium, .semibold, .bold, .heavy, .black:
            return UIFont(name: "NEXONLv1GothicOTFBold", size: ofSize) ?? .boldSystemFont(ofSize: ofSize)
        case .ultraLight, .thin, .light:
            return UIFont(name: "NEXONLv1GothicOTFLight", size: ofSize) ?? .boldSystemFont(ofSize: ofSize)
        default:
            return UIFont(name: "NEXONLv1GothicOTF", size: ofSize) ?? .systemFont(ofSize: ofSize)
        }
    }
    
}
```

3. 새로운 initializers 를 추가하는것


4. subscripts 를 정의하는것


5. new nested types 를 정의하거나 사용하는것


6. 프로토콜을 준수하게 해주는것 (프로토콜에서 필요한 필수 조건 작성) 

```
extension ViewController: UITableViewDataSource, UITableViewDelegate {

// 프토로콜에서 쓰라고 강요하는것들 작성

//이렇게 extenstion 으로 빼면 코드를 깔끔하게분배 가능하다
}
```


