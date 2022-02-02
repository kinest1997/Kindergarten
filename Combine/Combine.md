# Combine

- 비동기 처리를 수월하게 하기위해 이벤트 처리 연산자를 사용하는 프레임 워크
- RxSwift의 apple버전 기본 프레임워크

## Why?
- 비동기적인 인터페이스
- 시간이 지남에 따라 발생하는 값의 처리를 위해 통합된 선언적인 API

## 핵심요소
- Publisher
- Subscriber
- Operator

## AnyPublisher
- Rx에서의 observable
- Combine에서는 AnyPublisher 인것

### observable 과의 차이점

- AnyPublisher
1. ValueType: 값타입, 즉 struct다
2. Result 타입을 이용하지않아도 `AnyPublisher<String, Error>` 형태로 선언하여 에러타입을 정해줘야한다. 에러 대신 Never 을 넣어줄수도 있다

- Observable
1. ReferenceType: 참조타입, 즉 class다
2. swift5.0부터 생긴 Result 라는 타입을 이용하여 Error 이벤트를 핸들링 해줄수있다 `Observable<Result<String, Error>>`

## Operator

- try가 앞에 붙는 operator 가 존재한다
ex) tyrmap을 사용할경우 Result 타입을 받아줄수있다

merge는 rx 와 같이 합칠수있다

combinelatest는 rx와 다르게 4개까지만 가능하다

## Subject

- PassthroughSubject = PublishSubject

- CurrentValueSubject = BehaviorSubject

## Cancellable

```
let cancellables = Set<Cancellable>()

Just(1)
.sink {
	print($0)
}
.store(in: &cancellables)
```

위의 형식으로 store 함수와 inout 파라미터로 cancellable 이 rx에서 disposebag을 대체한다

## Subscribe

- subscribe 할 경우 upstream에 대해서만 작동한다, rx에서는 위치에 상관이 없었던것과는 반대























