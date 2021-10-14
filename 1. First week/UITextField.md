# UITextField


## 이게뭔가
* UIView -> UIControll -> UITextField 순서로 상속을 받는 아이
* 원하는대로 텍스트를 입력하고 그 텍스트 값을 활용 가능하다.
* 키보드를 띄울수있어 그 키보드로 텍스트를 입력한다.
* delegate 를 배우기 딱좋다
* 텍스트필드도 별개의 클래스로 데이터를 전달하고 전달받기 위해서 protocol 을 채택해줘야한다

## 사용법

```swift
class ChildViewController: UIViewController, UITextFieldDelegate {
// UITextFieldDelegate 라는 프로토콜을 상속받아야한다

let justTextField = UITextField()
// 텍스트필드를 생성해준다

justTextField.delegate = self
// 텍스트필드의 delegate 는 ChildViewController 즉 self 라고 선언해준다.
// 이로서 텍스트 필드의 존재가 완성
// 기타 layout이나 뷰에 추가하는것은 당연히 해줘야한다.
```


* 텍스트 필드의 값은 아래의 형태로 접근가능하다. 만약 이 값을 다른 라벨에 표시하고 싶다거나 할때 아래 형태로 적을수있다. 당연히 `String` 값이다  
`self.justText.text`

* 기본적인 UIVIew 에서의 속성은 다있다. 그대신 몇가지 새로운것 

* 텍스트 필드에 입력할때 표시되는 키보드의 타입을 고를수있다(ex: 9자리 자판, qwerty자판 등등)

```swift
justText.keyboardType = .default
					    .URL
					    .decimalPad
					    .emailAddress
					    .twitter
					    // 다양한데 심지어 트위터까지!			    
``` 
* 텍스트 필드 안에 예시나 가이드 라인 성격으로 뒷배경에 글자를 넣어줄수있다. 물론 그 글자는 아무기능도 하지않는다.
`justText.placeholder = "여기에 입력하시오"`

---

### 키보드 활성화/비활성화

* 키보드를 내리고싶을때 2가지 방법이있다
* 아래 두 함수를 class 안에 넣어주면 된다.
* 첫번째는 오른쪽 아래 return 키를눌러 키보드를 내리는 방법
 
 ```swift
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       //여기에 다양한 조건들을 추가해줄수있다, 키보드에 입력을 끝내면 그다음 텍스트 필드로 넘어가면서 자동을 키보드 띄우기
        justText.resignFirstResponder()
        return true
    }
 ```
* 두번째는 키보드를 제외한 화면 아무곳이나 누르는 방법

```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        justText.resignFirstResponder()
    }
```

* 세번째는 키보드에 입력을 끝냈을때 할 행동

```swift
func textFieldDidEndEditing(_ textField: UITextField) {
        //텍스트 필드의 입력을 끝낼때 마다 특정조건을 만족하는지 확인하고 만약 만족한다면 특정 메소드를 실행시키거나 상태값을 변경시켜 활성,비활성상태 만들수잇음
        doneButton.isEnabled = dataDiDFilled()
        //여기서 dataDidFilled 함수는 반환값으로 bool 값 뱉는 함수
    }

```

## 다른 ViewController 에 정보 넘기기

* 그냥 delegate 사용법이랑 똑같지만, 앞서 배운 delegate 의 기본  사용법을 따라가되 단지 이중으로 delegate 되어 넘겨준다는게 다를뿐. -> 이게 무슨말인가?
* TextField는 본인이 받은 값을 ChildViewController 에게 넘겨줬다, 그리고 그 넘겨받은 값을 또 MotherViewController 에게로 넘겨주는것
* 별거없다 똑같이 delegate 설정만 다해주고 `guard let txt = self?.textLabel.text else {return
            }` 이런식으로 텍스트 라벨 값만 꺼내오고 `txt` 로 정의된 값을 이제 마음대로 사용하면 끝이다
            





