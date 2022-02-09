# Test

## 뭔가?
- mvvm 구조의 장점중 하나인 뷰모델과 모델을 테스트 하는것
- 테스트를 통해 내가 생각한대로 작동하는지를 확인할수있다

## Model
1. RxSwift를 사용하여 Model 부분이 따로 분리되어있다.
2. Model에는 순수 로직들이 있다
3. 입력값을 넣어줬을때, 출력값으로 우리가 예상하는값이 있다
4. 입력값에 따른 출력값이 우리가 예상하는 값과 같게 나온다면? 그 테스트는 성공적인것

### 모델 테스트

1. 제일먼저 `@testable import 프로젝트이름` 를 해주어 테스트에서 내가만든 프로젝트의 파일을 사용할수있게 해준다

2. `XCTestCase` 를 상속받는 클래스를 하나 만들어준다

3. 내가 이름붙이고 싶은대로 함수이름을 짓고 앞에 test를 적어준다
>  `func testLabelChange() {}`

4. 함수안에서 내가 테스트 하고싶은 로직함수를 실행한 값과 예상되는 결과값을 정해준다.

5. 테스트하고 싶은 로직의 결과값과 예상값이 같은지 확인한다!

#### 참고사항
- nimble이라는 라이브러리는 테스트코드 작성시에 가독성을 높이기 위한 라이브러리
- RxTest는 rx코드를 테스트하기위한 라이브러리
- XcTest는 테스트를 작동시키기 위한 프레임워크

- 아래는 예시코드

```
import Foundation
import XCTest
import Nimble
import RxTest
import RxSwift

@testable import CurrencyTest

class CurrencyViewModelTests: XCTestCase {
    let disposebag = DisposeBag()
    
    var model: Model!
    
    var outPuts = ViewModel.init()
    override func setUp() {
        
         model = Model()
    }

    func testLabelChange() {
        
        let scheduler = TestScheduler(initialClock: 0)
                   
        //임의의 현재 환율
        let currency = Currency(krw: 1213.121, jpy: 223, php: 192)
        
        let inputCurrencyEvent = scheduler.createHotObservable([.next(0, currency)])
        let inputCurrency = PublishSubject<Currency>()
        
        inputCurrencyEvent
            .subscribe(inputCurrency)
            .disposed(by: disposebag)
        
        //임의의 송금액
        let inputNumberEvent = scheduler.createHotObservable([.next(0, 1232)])
        let inputnumber =  PublishSubject<Int>()
        
        inputNumberEvent
            .subscribe(inputnumber)
            .disposed(by: disposebag)
        
        //임의의 국가
        let inputCountryEvent = scheduler.createHotObservable([.next(0, Country.krw)])
        
        let inputCountry = PublishSubject<Country>()
        
        inputCountryEvent
            .subscribe(inputCountry)
            .disposed(by: disposebag)
        
        //국가, 환율, 금액을 받아 수취금액 계산
       let resultTextEventObserver = Observable.combineLatest(inputCurrency, inputnumber, inputCountry) { currency, number, country in
            self.model.getCountryCurrency(country: country, currency: currency) * Double(number)
        }
        
        let currentText = scheduler.createObserver(String.self)
        
        resultTextEventObserver
            .map(model.makeResultText)
            .subscribe(currentText)
            .disposed(by: disposebag)
        
        scheduler.start()
        
        expect(currentText.events).to(equal([.next(0, "1,494,565.07")]))
    }
}
```

## ViewModel

1. RxSwift를 사용하여 ViewModel 부분이 따로 분리되어있다.
2. 뷰모델은 사용자의 입력에 따른 ui등의 변경사항을 내보내준다
3. 입력값을 넣어줬을때, 출력값으로 우리가 예상하는값이 있다
4. 입력값에 따른 출력값이 우리가 예상하는 값과 같게 나온다면? 그 테스트는 성공적인것
