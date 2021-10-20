# URL

## OSI 7 layer
- Open Systems Interconnection: 개방형 시스템 상호연결
- 우리는 주로 7단계인 application 층을 다룬다
![사진]()

## URL
- Uniform Resource Locator: 네크워크상에 어떠한 리소스가 어디에 있는지 알려주기위한 규약
- 어떤 자원은 반드시 url 을 가진다
- 아래 주소는 세분화 한것
`http://` `www.fastcampus.com` `:8080` `ios-lecture.html`
프로토콜, layer3: 네트워크계층, layer4: 전송계층, layer7: 응용계층

## `http://`  

### Request
- 특정 메소드 실행시에 우리가 보내는 요청
	- Method: 무언가를 해라, URL: 리소스에 대해, Header 와 Body: 구체적으로 어떻게
	- 여러가지 method 를 제공한다 리스트는 아래에, *get,post,put,delete* 제외 거의 사용할일 없음
	1. get: 식별된 데이터 가져오기
	2. post: 새 데이터를 추가
	3. put: 식별된 기존의 데이터 수정
	4. patch: put 과 동일하지만 데이터의 일부를 수정
	5. delete: 식별된 데이터 삭제
	6. head: get 과 동일하지만 메시지의 헤더만 변환
	7. connect: 프록시 기능 요청
	8. options: 웹서버에서 지원하는 메소드 확인
	9. trace: 원격 서버 테스트용 메시지 확인



### Parameter
- 일반적인 인터넷 주소가 있다 `https://api.odcloud.kr/api/15077756/v1/vaccine-stat?page=1&perPage=10&serviceKey=6JyBJbTYm3KNYHvbDV`
- 위 주소에서 `/` 로 구분된 주소들을 쭉 지나다 보면 `?` 가 나오는데 그 이후로 parameter 가 시작되며 `&` 은 파라미터 간의 구별을 위한 식별자, = 은 key, value 를 구별하기 위한 식별자이다. (= 으로 연결된 아이들은 한뭉치, 한 뭉치를 구별하는 건 &)

### Post
- 전달하는값을 parameter 에 넣어서 주지않고 body 에 넣어서 준다. parameter에 넣을수있는 데이터양은 200바이트내외이다.



### Response
- 내가 무언가 메소드를 행하고 그에대한 답변을 받은것
- 크게 4가지로 나눌수있다.
 1. Status Code: 3자리 숫자로 이루어지며 1번째 숫자에 따라 상태의 유형이 정해진다
  - 1xx: 정보전달 - 리퀘스트 수신, 진행중
  - 2xx: 성공 - 리퀘스트 성공적으로 수신, 해석, 승인
  - 3xx: 리디렉션
  - 4xx: 클라이언트 에러
  - 5xx: 서버 에러
 2. Message
 3. Header
 4. Body

 
## URLSession

- 애플에서 제공하는 객체, 네트워크 구축을 위해 필요한 친구
- URLSession.shared

### 관련 메소드
- URLSessionDataTask: 이친구를 가장많이 사용한다.
- URLSessionUploadTask
- URLSessionDownloadTask
- URLSessionStreamTask
- URLSessionSocketTask

## 외부 API 사용방법 

- 사용하고 싶은 OpenAPI를 찾는다.
- 찾은 API를 Postman 또는 사이트의 자체 테스트 툴을 활용하여 request와 response 형태를 확인한다.
- 확인한 response를 보고 실제 앱에 반영할 객체를 구상한다.
- 확인할때는 해당 사이트에서 테스트 해보거나, PostMan 이라는 프로그램으로 확인할수있다. 이것이 정상작동하는 URL 인지, parameter를 넣었을떄 제대로 값이 나오는지.

- 간단 순서: 객체생성 -> URLSession이 전달할 request 작성 -> request가 가지는 URL 작성 -> URL의 구성요소들을 하나씩 만들어서 합쳐준다 -> URLSession이 request 를 전달하고 받아오는 메소드 실행(ex: .dataTask) -> 받아온 Json형식 데이터를 디코딩하여 입맛대로 사용



- 예시: 내가 받아올 데이터는 날씨 현황이다.

0. 먼저 api 를 확인하여 json파일이 어떻게 데이터를 넘겨주는지 보면 알수있듯이 list 안에 정보들이 담겨져있다. 그걸 참고하여 구조체를 짜자
```
{
    "count": 187,
    "list": [
        {
            "unitName": "죽전휴게소",
            "unitCode": "002 ",
            "routeName": "경부선",
            "routeNo": "0010",
            "stdHour": "16",
            "updownTypeCode": "E",
            "xValue": "127.104165",
            "yValue": "37.332651",
            "sdate": "20211010",
            "snowValue": "-999.000000",
            "addr": "경기도 용인시 수지구 풍덕천동 42-1",
            "tmxValue": "209231.370200",
            "tmyValue": "525935.874890",
            "measurement": "연천",
            "addrCode": "119",
            "addrName": "수원",
            "weatherContents": "약한비계속(매시3mm이하)",
        }
```


1. 객체 구성
- Json파일 안에 시작부터 배열이 있는것이 아닌 몇가지 정보들이 있고 그중 list 안에 우리가 필요한 정보가 있다, 이걸 디코딩 하려면 구조체 안에 구조체를 넣는 형식으로 만들어야함

```struct
struct WeatherAPIResponse: Codable {
    let list: [WeatherData]
}
//우리가 제일먼저 받은 파일은 아직 사용이 불가능 하니까 이름을 그냥 response 로 지어주자

struct WeatherData: Codable {
    let unitName: String
    let sdate: Date
    let addr: String
    let weatherContents: String
}
//우리가 실질적으로 필요한 정보만 빼서 구조체에 만들어준다.
//우리가 사용할 데이터는 response 가 아닌 weatherData 니까 정보의 목록을 아래처럼 만들어주자

var myList = [WeatherData]()
//이러면 weatherData 의 배열 생성, 이 데이터에 접근해서 뭐하는건 알아서 생각
```

2. 우리가 구성한 객체형식으로 받거나 전달 가능한 네트워킹 객체인 `URLSession` 을 사용한다. `URLSession` 관련 메소드중 `urlSession.shared.dataTask` 를 사용한다
`.dataTask` 메소드는 `URLRequest` 가 필요하고 `URLRequest` 는 `URL`이 필요하고 `URL`은 `components` 들이 필요하다
즉 `components` 부터 차근차근

```swift



var urlComponents = URLComponents()
// urlComponents를 선언해주고, 그친구에 속성들을 불어넣어준다



//quertItem: parameter들, 일종의 필터 역할을 해주는것들을 적는곳

urlComponents.scheme = "http"                               //scheme: http, ftp, mailto 같은 프로토콜 영역
urlComponents.host = "data.ex.co.kr"                        //host: root, baseURL 등의 / 슬래쉬 이전의 주소값
urlComponents.path = "/openapi/restinfo/restWeatherList"    //path: 상세 경로 첫번째 / 이후 ? 이전의 모든주소값
urlComponents.queryItems = [                                ////quertItem: parameter들, 일종의 필터 역할을 해주는것들을 적는곳.이후에는 key=value 형태로 작성될거고, 각 key별 구분은 &로 표현한다.
    URLQueryItem(name: "key", value: "test"),
    URLQueryItem(name: "type", value: "json"),
    URLQueryItem(name: "sdate", value: "20211018"),
    URLQueryItem(name: "stdHour", value: "10")
]

guard let completeURL = urlComponents.url else { return }
//이렇게 하면 하나의 URL 이 완성되었다
```

3. URL을 request 에 넣기

```
var urlRequest = URLRequest(url: completeURL)
//URL request 의 URL 은 방금 만들어준 completeURL 이다

urlRequest.httpMethod = "GET"
//기본값은 GET이라 안적어줘도 되는거지만 명시적으로 표기하는게 그래도 좋겠지
```

3. -1 번외

```
urlRequest.setValue("어떠한 인증키 값", forHTTPHeaderField: "Authorization")   //Header에 값을 넣어야 할 때
/*  Body에 값을 넣어야 할 때
let bodyJson = """
{"a": "b"}
"""
let jsonData = bodyJson.data(using: .utf8)
urlRequest.httpBody = jsonData

```

4. URLSession 을 위한 request 가 완성되었고 메소드를 사용해서 데이터를 받아오고, 그 받아온 데이터를 밖으로 꺼내주는 escapingClosure 를 사용한 함수를 작성해보자

```
func getWeathers(with: URLRequest, completionBlock: @escaping ([WeatherData]) -> Void) {

    //   dataTask 함수의 형태는 크게 2가지. request를 URL로 보내거나 URLRequest로 보내는 것.
    //   따라서 필요에 따라 URL을 구성할지 URLRequest를 구성할지 선택. 리퀘와 url의 차이점이 헷갈림 나중에 질문

    let task = urlSession.dataTask(with: urlRequest) { data, response, error in
    	// data는 우리가 json 형식으로 받아온 data 를 지칭하고
    	// Response 는 거기서 응답해준 내용을 말한다.
      
        //우리가 여기서 핸들링 하는 것은 Response 중에서도 HTTPURLResponse 이므로 설정해 줌
        guard let response = response as? HTTPURLResponse,
              let data = data else {
                  return
              }
        //보통 statuscode 사용하니까 만약 정상 범위내의 statuscode를 받았을때 파일을 제대로 받았다는것이니 그때 파일 디코딩을 하면된다.
        //response의 statusCode 숫자에 따라 해야할 행동을 정해준다.
        switch response.statusCode {
        case 200..<300:

        //여기서부터 디코딩 과정인데 우리 객체에는 date 라는 타입을 가진 변수가있었다, 근데 Json에선 String 형태로 넘겨줬으니 그걸 디코딩하는 포맷을 정해줘야한다.
            let jsonDecoder = JSONDecoder()

        //Jsondecoder에 날짜 디코딩 방법을 우리가 정해준 방식으로 설정해준다. 
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            
        //이제 JsonDecoder에게 디코딩 하라고 시키면된다, 우리가 위에서만든 객체의 타입으로, data 는 외부 api 에서 받아온 데이터로
            guard let weatherResponse = try? jsonDecoder.decode(WeatherAPIResponse.self, from: data) else {
                URLError(.cannotDecodeRawData)
                fatalError()
            }
            
        //함수에 escapingClosure로 [WeatherData]형식의 데이터를가져올수있게 설정해놨으니 completionBlock에 우리가 가지고 나오고 싶은 [WeatherData]형식의 데이터인 weatherResponse.list 를 넣어준다. 이러면 이제 데이터가 밖으로 나갈수있다.
            completionBlock(weatherResponse.list)

        case 400..<500:
            print("ERROR", URLError(.clientCertificateRejected).localizedDescription)
        case 500..<600:
            print("ERROR", URLError(.badServerResponse).localizedDescription)
        default:
            fatalError()
        }
        //error는 말그대로 에러가 발생했을때 인데 만약 에러에 따른 처리를 할게없다면 그냥 언더바로 놓아도 괜찮지만 그래도 에러가 어디서 발생했는지는 알려주게하자
         if let error = error {
            print("ERROR", error.localizedDescription)
        }
    }
    task.resume()   //6-3. 반드시 resume()을 통해 만들어준 URLSessionDataTask를 실행시켜주어야 한다.

    //제일처음에 task 라는 상수에 urlSession.dataTask를 할당 해주었으니 그 할당해준 task를 실행시켜줘야한다. 근데 이렇게 적을꺼면 그냥 애초에 let 선언 빼고 하면 똑같이 실행되는거 아닌가? resume 도 안적어도 되는것이고. 이건좀 의문
}
```

5. 실제 실행 모습

```
getWeathers(with: urlRequest) { list in  
    myList = list
}
//정말 초 심플 간단하다, 이함수를 실행시키면? 내 리스트가 외부에서 받아온 리스트로 변경되는것이다. 클로저가 내부 정보값을 들고 밖으로 뛰쳐나와서 수행되기 떄문에.
```
