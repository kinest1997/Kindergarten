# RxSwift

# 기본개념
every observable instance is just a sequence

## Observable
- Rx 코드의 기반
- T형태의 데이터 snapshot 을 전달할수있는 일련의 이벤트를 비동기적으로 생성하는 기능
- 하나이상의 observers가 실시간으로 어떤 이벤트에 반응
- 세가지 유형의 이벤트만 방출
```
enum Event<Element> {
	case next(Element)
	case error(Swift.error)
	case completed
}
```

- rx의 심장
- observable = observable sequence = sequencd
- 비동기적
- observable들은 일정 기간동안 계속해서 이벤트를 생성 (emit)
- marble diagram: 시간의 흐름에 따라서 값을 표시하는 방식


### 생성자?

1. `just`: 딱 하나를 그대로 내뱉음
2. `of`: 순서대로 다 내뱉음
3. `from`: 반드시 array 형태로 넣어줘야하며 array 안의 요소를 하나씩 방출
4. `range`: start 부터 count번째의 값까지 순차적으로 뱉어주는것

#### `.subscribe`

- `.Observable`은 그자체로는 아무것도 하지못한다. 
- `.subscribe를` 통해 구독을 해줘야 방출되는 이벤트를 핸들링 가능하다.

#### empty, never

- `empty()` 아무것도 방출하지않고 오로지 complete만 방출한다
- `never()` complete도 방출하지않아서 현재 구독중인지 확인하려면 `.debug` 를 통해서만 확인이 가능하다.

#### `dispose`
- subscribe 한뒤에는 항상 dispose를 통해 구독해제를 해주어 메모리 누수가 발생하지않도록 해줘야한다.
- lifeCycle 이라고 생각하라했음
- disposeBag에 미리 담아놓는것이 어떤의미를 가지는것인가. 나중에 같은 bag 에 담아놓은 아이들은 한번에 dispose 시켜줄수있게 묶어놓는건가? 아니면 그곳에 담아놓기만 해도 저절로 dispose 되는것인가 뭔지 모르겟네

#### create
- 좀 특이한 방식
- 전혀 모르겠음

#### defered
- 옵저버를 통해 옵저버를 만드는것. 뭐 함수안에 함수 그런느낌인건지 잘 모르겠다.


### Single, Maybe, Completable

- 보편적인 observable 에서 약간 다른형태를 가진것들?

#### Single

- success또는 error 이벤트를 한번만 방출하는 obsevable
- success는 Next 와 completed를 합친것과 같다.
- 이벤트 방출뒤에 완전히 종료된다.
- 네트워크상에서 json 파일을 받아올때는 성공과 실패밖에 없기때문에 자주 사용.

#### Maybe

- single 과 거의 같지만 complete 되더라도 아무런 값을 방출하지않는 형태의 complete 를 포함한다.
- observable에서는 onnext 로 표현하는것을 maybe 에서는 success로 표현한다는점이 다르다.

#### Completable

- complete 또는 error 만을 방출한다.
- 동기식 연산의 성공 여부를 확인할때 유용하게 쓰일수있다.
- 이미 생성된 observable을 변경시켜 만들수없고 처음부터 Completable 로 만들어야 한다.


## Operator

## Scheduler


## Subject

### 종류

1. PublishSubject
- 빈상태로 시작하여 새로운값만을 subscriber에 방출한다
- 구독된 순간 새로운 이벤트 수신을 알리고싶을때 유용하다. 
- 구독을 시작하기 직전에 나온 값은 받지못한다


2. BehaviorSubject
- 하나의 초기값을 가진상태로 시작하여 새로운 subscriber에게 초기값 또는 최신값을 방출한다
- 구독을 시작하기 직전에 나온값을 받을수있다 


3. RelaySubject
- 버퍼를 두고 초기화하며, 버퍼 사이즈만큼의 값들을 유지하면서 새로운 subscriber에게 방출한다.
- 내가 설정한 버퍼들은 메모리에 저장되므로 메모리를 크게 차지하는친구들은 버퍼로 가지게하는건 바람직하지않다.

버퍼? 대충 일정 간격? 느낌인데 잘모름 내일 물어보기









