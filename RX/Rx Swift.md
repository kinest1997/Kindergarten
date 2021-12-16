# Rx Swift

## Observable
1. 특정한 내용이 흐르는 강
2. 내가 subscribe 라는 낚싯대를 던져서 강에서 흐르는 내용을 받을수있다.
3. 강에서 가져온 내용을 받아온 다음에 map 을 하는것과, 강에서 가져오기전 map 을 할수도있는가?
4. Observable<T> 형태를 가짐

### 생성
1. `just`: 넣어준 형태 그대로 하나만을 방출한다(array 형태이더라도)
2. `of`: 하나 이상의 이벤트를 넣을수있다. 쉼표로 구별하여 넣을수있음.(만약 array형태로 넣게되면 하나의 array를 내뿜는다.)
3. `from`: array형태만을 받으며 array 안의 element를 하나씩 꺼내서 방출해준다
4. `empty`: 아무런 이벤트를 발생시키지않는 이벤트(complete 만 방출하는 것), 타입을 정해주지않으면 아무것도 뱉지않는다.(void로 타입을 정해주면 complete를 방출한다.)
5. `never`: complete조차도 방출시키지않는것. debug 로만 확인이 가능함
6. `range`: 시작과 끝값을 주고 그 사이의 값들을 방출해주는것
7. `create`: escaping 클로저형태, observer가 방출하는 이벤트를 하나씩 다 정해줄수있음. 에러, 컴플리트, 온넥스트 등등. 안에 함수같은것을 작성해서 원하는대로 만들수있음

```
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
// 이경우 구독을 하여도 2는 방출되지않는다. completed 된이후이기 때문.
```

8. `deferred`: 다른 observabel이 구독 여부에 상관없이 이벤트를 방출하지만 deferred의 경우 구독을 시작하여야만 이벤트를 방출한다. (deferred: 미루다, 즉 구독할때까지 이벤트 방출을 미루는것)

### subscribe
1. .subscribe: 구독을 통해 observable에서 방출하는 데이터를 받아볼수있다.
2. 구독을 하지않으면 observable은 그저 아무도 모르게 계속 데이터를 방출하기만 하는것.
3. 아무런 parameter없이 그냥 사용하면 어떤 이벤트에 감싸져 나오는지, 종료되는지 까지 알수있다

```
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
/*
next(1)
next(2)
next(3)
completed
*/
```

#### onNext
* onNext이벤트에 감싸져서 나오는 데이터를 받아볼수있다.

```
Observable.of(1, 2, 3)
	.subscribe (onNext: {
		print($0)
	})
/*
1
2
3
*/
```

#### onComplete
* onComplete이벤트에 감싸져서 나오는 것을 받아볼수있다.
- 값은 따로 받지않음. 


#### onError
* onError이벤트에 감싸져서 나오는것을 받아볼수있다.

#### onDisposed
1. subscribe를 하고나서 그 구독을 취소하는것
2. `.dispose()` 로 구독을 취소할수있다.
3. 만약 이벤트가 무한히 발생한다면 반드시 dispose를 해줘야한다.


#### DisposeBag
1. observable을 할당 해제할때 모든 disposable 들을 메모리에서 할당 해제해준다.
2. 매번 observable을 명확한 시점에 dispose 해줄수없으니 disposebag에 넣어놓고 observable이 할당 해제될때 disposable들도 같이 할당 해제 해주는것?


## Single, Maybe, Completable

- 코드의 가독성을 위해 사용함
- 이벤트의 방출유형이 정해진 observable
- 네트워크 환경에서 사용

### Single
1. success 와 error 만 방출하는 observable
2. 네트워크 다운로드와 같은일을 할때 성공과 실패만있는 경우에 사용한다
3. success, error 둘중 한가지만 방출하고 종료된다.
4. single로 생성할수도있고, observable을 single 로 변환시킬수도있다
5. onNext 와 complete가 합해져서 success가 된것 


### Maybe
1. success, completed, error 3가지 상황을 방출
2. single로 생성할수도있고, observable을 single 로 변환시킬수도있다
3. 

### Completable
1. completed, error 2가지 상황을 방출
2. 어떠한 값도 방출하지않는다.
3. completable을 이용하여야만 생성가능하다 다른 observable을 변환시켜서 만들순없다.
4. 데이터 통신을 완료한경우 그 완료했다는 사실만을 알고싶은경우등에 사용한다. 해당 값이 필요없을때.


## Subject
- Observable 이면서 동시에 Observer

### PublishSubject
1. 빈상태로 시작하여 새로운값만을 방출
2. completed 된 이후 subscribe 할경우 아무값도 받지못한다.


### BehaviorSubject
1. 하나의 초기값을 가진채로 시작하며 새로운 subscriber 에게 초기값 또는 최신값을방출한다.
2. 생성할때 반드시 초기값을 줘야한다.
3. `.value()` 를 사용하여 값 만을 빼주는 throw 함수 사용 가능 (거의 안씀)


### ReplaySubject
1. 버퍼를두고 초기화 하며 버퍼 사이즈 만큼의 값들을 유지하면서 새로운 subscriber 에게 방출한다
2. create를 통해서 생성해주며 버퍼 사이즈를 정해줘야한다.

```
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

```
3. 구독하는 시점에 버퍼 만큼의 값들을 바로 받아온다. 
4. dispose된 이후에 구독시에는 버퍼만큼 의 값들을 받아오지못한다


## Filtering Operators

### `.ignoreElements()`
- onNext로 나오는 이벤트는 무시한다. 
- complete, error 이벤트는 방출한다.

### `.element(at: 2)`
- 해당되는 하나의 index번째 순서의 이벤트에만 방출한다.

### `filter`
- 우리가 아는 그 필터와 같다

### `skip(3)`
- skip에 표현한 숫자만큼의 갯수만큼을 무시하고 이벤트를 방출

### `skip(while: )`
- 괄호안의 조건이 false 될때 까지 이벤트들을 무시한다.
- filter 와 반대됨.

### `.skip(until: someObservable)`
- 다른 observable이 이벤트를 방출할때 까지 현재 observable에서 방출하는 이벤트를 무시

### `.take(3)`
- skip의 반대개념
- 어떠한것을 취하고싶을때 표현한 숫자갯수 만큼만의 값을 받아온다.

### `.take(while: {})`
- 괄호안의 조건이 false 가 될때 더이상 받아오지않는다.

### `enumerated()`
- 우리가 아는 array의 enumerated와 비슷
- 방출된 이벤트의 index 를 알고싶을때 사용
- index 와 value 의 tuple 을 뱉어줌

### `.take(until: someObservable)`
- 다른 observable이 이벤트를 하기전까지 까지 현재 observable에서 방출한다.

### `.distinctUntilChanged()`
- 연달아 같은값이 중복되어 나올때 이벤트를 방출해주지않는것. 그전값과 다르다면 다시 방출해줌 


## Transforming Operator

### `.toArray()`
- Single로 변환되며 발생되는 이벤트를 전부 묶어 하나의 array로 방출해준다

### `.map`
- 일반적인 map과 같다


### `.flatMap`
- 중첩된 observable 같은 경우 array 안의 array같은 형태이다
- 그 내부의 정보를 꺼낼수 있게 해준다. 
- 2차원 배열을 한단계 내려서 1차원 배열로 만들어줌

### `.flatMapLatest`
- map 과 switchLatest의 조합이다.
- 가장 최근의 observable을 구독하고 그전에 구독하던 observable은 구독 취소한다.
- 네트워킹 조작에서 가장 흔하게 사용한다.

### `.compactMap`
- 1차원 배열에서 nil을 제거해주고 옵셔널 바인딩을 해준다.

### materialize() and dematerialize()

- materialize: 이벤트를 감싸서 내보내준다.
- dematerialize: 감싸서 내보내준 이벤트를 다시 원래 모양으로 복원시켜준다.


## Combining Operators

### `.startWith`
- 어떠한 이벤트를 방출할떄 초기값을 정해줄수있다.
- 초기값의 타입은 반드시 이벤트와 동일한 타입으로.
- 어디에 연산자가 붙는가에 상관없이 무조건 첫번째로 방출함

### `.concat`
- concat([A, B...]) 형태로 합쳐줄수있고, A.concat(B) 이형태로도 합쳐줄수있다
- 앞에있는 observable이 먼저 방출되고 초기값의 역할을 한다. 

### `.concatMap`
- flatMap 과 다르게순서를 보장하며 두개의 observable 을 합쳐준다. 
- concat 과 map 이 합쳐진것
- 먼저 방출되는 observable이 방출을 끝마치고 나서 다음순서가 방출됨


### `.merge`
- 단순히 여러개의 observable을 합쳐주는것. 순서를 보장해주지않는다. 
- `.merge(maxConcurrent: 1)` 동시에 몇개의 observable에게서 이벤트를 받을것인지 제한하는것. 1로 설정하면 1개만 받는것, 쓸일이 많지는 않다고함

### `.combineLatest`
- 여러가지의 observable들을 하나로 합쳐주는데, 대신 가장 최근에 들어온값을 기준으로 합쳐준다. 
- 여러개의 이벤트들이 전부 각각 1개이상의 값을 초기에 방출하기전까진 아무것도 방출하지않음.
- 전부 초기값을 가지고 난 뒤에는 1개만 최신값이 발행되더라도 다른것들과 조합된 새로운 값을 방출한다.
- trailingClosure로 resultSelector에 원하는 형식으로 변환 가능.
- 8개까지 source를 받을수있다.

### `.zip`
- 여러가지의 observable들을 하나로 합쳐주는데, combineLatest와 다르게 각각의 observable이 하나라도 같은 index 값을 가진 이벤트를 방출하지않으면 이벤트를 방출하지않는다.
- 1:1 로 매칭되면 이벤트를 방출하고, 매칭실패하면 아무것도 방출하지않는것. 

### `.withLatestFrom(someObservable)`
- 이벤트가 발생시에 someObservable에서 가장 최근에 발행한 이벤트1개를 방출해준다

### `.sample(someObservable)`
- withLatestfrom에 `.distinctUntilChanged()`를 붙인것과 같다 
- 중복된값을 방출하지않는다. 

### `.amb(someObservable)`
- 2개의 observable 중 먼저 이벤트를 방출한 observable의 이벤트만 방출하고 나머지는 방출하지않는다.

### `.switchLatest()`
- observable에서 발행하는 observable 이벤트를 다른 observable로 변경하여 이벤트를 방출하도록 함
- 여러개의 observable중 선택한 observable의 이벤트만 방출

### `.reduce`
- 기존에 사용하던 reduce와 같다.
- sequence내 요소를 하나의 이벤트로 합쳐주는것

### `.scan`
- 매번 값이 들어올때 마다 reduce 처럼 값을 합치지만 모두를 하나로 합치지않고 매번 새로운 이벤트를 방출해준다.


## TimeBasedOperators

### `replay(1)`
- replay 관련 연산자를사용할때는 반드시 `connect()` 를 해줘야한다
- 과거의 이벤트를 괄호안의 버퍼의 갯수만큼 받아볼수있다.

### `replayAll`
- `connect()` 를 해줘야한다
- 구독시점 이전에 발생한 모든 이벤트들을 받아올수있다.

### `.buffer`

- 아래와 같이 사용한다. 
```
    .buffer(
        timeSpan: .seconds(2),
        count: 2,
        scheduler: MainScheduler.instance
    )
```
- Array형태로 정해진 시간마다 방출하거나, 최대 갯수로 정해진 갯수가 채워지면 방출한다
- 만약 정해진 시간동안 아무 이벤트도 방출하지않으면 빈 array를 방출한다.

### `.window`
- buffer 와 같지만 observable을 방출한다는것이 다르다.

### `delaySubscription`
- 지정한 시간동안 구독을 지연 시켜주는것

### `delay`
- 전체 sequence를 미루는것.

### `interval`
- 일정 간격으로 정해준 타입에 따라 이벤트를 방출해준다.

### `timer`
- 구독을 시작하는 delay 시간을 줄수있고, 간격도 줄수있다. 

### `timeout`
- 구독 시작후에 정해진 시간 내에 아무런 이벤트도 발생하지않으면 error를 발생시킨다












