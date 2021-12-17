# RxCocoa

## Binder<value>
- 데이터를 생산하는 obseevable 에서 수신자인 binder 에게 묶어주는것.
- 오로지 수신만 한다
- error 를 받지않는다
- UIevent에 사용함(만약 앱 실행중에 error 이벤트를 내뱉었다고 종료되어버리면 안되니까)
- mainthread에서 실행되는것을 보장한다.(mainScheduler같은 설정을 안해줘도된다)

## Driver, Signal

- 에러를 방출하지않는 특별한 observable
- 모든 과정은 mainThread에서 이루어진다
- 스트림의 공유가 가능하다. 여러명이 구독하더라도 모두 같은 observable의 이벤트를 전달받는다
- driver: 초기값 혹은 최신값을 반복한다
- signal: 구독한 이후에 발생하는 값을 전달받는다.

## Rx Extension
- 만약 rx 코드 뒤에 내가 원하는 property가 없다면 내가 직접 rx extension을 사용하여 추가해줄수있다

- 아래는 예시

```
extension Reactive where Base: T {}

extension Reactive where Base: UIView {
	var sizeToFit: Binder<Void> {
		return Binder(base) {
			base, _ in
			base.sizeToFit()
		}
	}
}

```
- 
