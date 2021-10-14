# UISegmentedControl.md

* `UIControl` 을 상속받음
* 일정 갯수의 선택지를 가지고 그 선택지중 하나를 고를수있는것
* 소주제를 정하거나 2가지 이상의 선택지에서 하나를 고를때 쓸듯
* 아래는 몇가지 간단 사용방법들


```swift
 let genderSegmentControl = UISegmentedControl()
 // 일단 선언

 genderSegmentControl.insertSegment(withTitle: "1번째", at: 0, animated: true)
 genderSegmentControl.insertSegment(withTitle: "2번째", at: 1, animated: true)
 // 이런식으로 세그먼트의 종류 를 늘린다. 이름은 1번째, 그리고 위치는 제일 앞

genderSegmentControl.addAction
//세그먼트에 액션을 추가해줄수있다. 내가 1번쨰를 눌렀을때 그 아래에 뭔가 뜨게 한다던지? 아니면 다른 텍스트 필드로 넘어간다던지.

genderSegmentControl.selectedSegmentIndex == 
//선택된 세그먼트의 index 즉 순번이 몇번인지 알려준다
//만약 제일 앞에것이면 0, 아무것도 선택하지 않았다면 -1 이다

genderSegmentControl.selectedSegmentTintColor = .systemCyan
//선택 되었을떄 색이 내가 설정한걸로 바뀜 이건좀 쓸지도?

```
// 그밖에 이미지설정도있고 그런데 과연 쓸런지...



