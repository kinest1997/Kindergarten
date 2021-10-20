# Date

## 뭔가? 
- 날짜를 String 이 아닌 Date 라는 새로운 타입으로 만든것

## 사용

### DatePicker 
- 날짜 선택을 용이하게 해주는 `UIControl` 을 상속받는 `UIDatePicker`

#### 몇가지 properties
1. `.preferredDatePickerStyle` 
 - `.compact`: default style 이며 공간을 적게 차지하고 깔끔함
 - `.inline`: compact 를 클릭해서 확대된 모습이 기본적인 형태인 style 
 - `.wheel`: 아주 예전부터 보던 원통형 자물쇠 style

2. `.datePickerMode`
 - `.dateAndTime`
 - `.date`
 - `.time`
 - `.countDownTimer`

3. `.locale`
 - 기본설정은 아이폰의 기본설정을 따라가서 굳이 해줄필요없다. 그래도 굳이 다른나라를 배척하겠다면 아래처럼
 - `Locale(identifier: "ko-KR")` 

4. `.minuteInterval`
 - 스크롤을 돌릴때 나타는 분단위의 시간을 정할수있다
 - 60의 약수 단위로 설정 가능, 뭐 보통 15분 30분 10분 5분 많이할듯? 아니면 그냥 1분단위 기본으로

5. `.date`
 - 맨처음 datepicker 가 켜졌을떄 선택되어있는 날짜 선택 가능
 - `Date(timeIntervalSinceNow: -3600 * 24 * 3)` 이러면 3일전으로 설정 가능하고 괄호안 내용 없애면 그냥 지금 시간이 나오겠지

6. minimum, maximum
 - 최대로 선택 가능한 날짜, 최소로 선택 가능한날짜 고를수있다.
 - 단순 알람앱인데 10년전 어느날을 선택할수있는건 말이안되니까? 
 - 혹은 10년후 어느날 선택같은건 좀 에반듯
```
var components = DateComponents()
components.day = 10
let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
components.day = -10
let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())

datePicker.maximumDate = maxDate
datePicker.minimumDate = minDate
```

- 사용 예시

```
let datePicker = UIDatePicker()
//선언 해주고

let someAction = UIAction { print("변경된값을 라벨에 전달하여 라벨에 표시되는 값을 변경하는 코드를 적고싶다")}

datePicker.addAction(someAction, for: .valueChanged)
//데픽의 값이 바뀔때 마다 특정 액션을 수행하게 할수있다, 혹은터치 될때마다? 근데 이건 에반듯

datePicker.preferredDatePickerStyle = .compact
datePicker.datePickerMode = .dateAndTime
datePicker.minuteInterval = 20
datePicker.date = Date()     //3시간전이라면 요렇게  Date(timeIntervalSinceNow: - 3600 * 3)

//아래부턴 최소 최대선택가능날짜
var components = DateComponents()
components.day = 10
let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
components.day = -10
let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())

datePicker.maximumDate = maxDate
datePicker.minimumDate = minDate
```

## 디코딩,인코딩

### 디코딩

- 우리가 Json 파일에서 날짜 데이터를 뽑아온다고 할떄, 그 데이터는 String 값일것이다.
- 그 String 형태로 온 데이터를 Date 형식으로 바꿔주기 위해선 아래의 과정이필요하다

```
let decoder = JSONDecoder()
//특정 디코더에 속성을 집어넣어주기위한과정
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy년 MM월 dd일"
//Json 파일에서 보내주는 String 의 형식에 맞게 입력해준다
//yyyy는 연도, MM은 월, dd일, mm은 분

decoder.dateDecodingStrategy = .formatted(dateFormatter)
//그래서 JsonDecoder에 디코딩 방법중 하나로 데이트 포맷이란걸 추가해주고, 일반적인 Json 파일을 디코딩 하듯이 디코딩하면 잘나온다.

let dateData = try! decoder.decode(DateData.self, from: data)

```

### 인코딩

- 인코딩 과정은 똑같다, 위에서 정해준 데이트 포맷을 그대로 사용할수있다. 

```
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .formatted(dateFormatter)    //또는 .iso8601로 찍어볼 것
//인코딩과정에서 사용한 포맷을 그대로 사용. 나머지는 동일

let jsonData = try! encoder.encode(dateData)
let jsonString = String(data: jsonData, encoding: .utf8
```