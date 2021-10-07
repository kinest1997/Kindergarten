# UIBase

## 좌표계
* view 기준 좌측상단이 (0,0) 이다
* 뷰의 위치는 상대적으로 상위 뷰를 기준으로 위치를 잡는다
* root뷰 위에 a,b 뷰가 있을때  a 뷰가 b 뷰 위에 위치할경우 a 뷰의 좌표계는 root 뷰가 아닌 b 뷰 기준으로 정해짐

## UI Code
### Framework
 * 애플리케이션 프레임워크(Application Framework)는 프로그래밍에서 특정 운영 체제를 위한 응용 프로그램 표준 구조를 구현 하는 클래스와 라이브러리 모임이다. 간단하게 프레임워크라고도 부른다.
* 재사용할 수 있는 수많은 코드를 프레임워크로 통합 함으로써 개발자가 새로운 애플리케이션을 위한 표준 코드를 다시 작성하지 않아도 사용된다.

---

### UIKit Framework
* Cocoa Touch Framework에 추가된 UI관련 기능의 클래스가 모여있는 Framework

---

### UIView

* 가장 기본이 되는 View
* UIResponder 를 그대로 상속받음
* UIComponent들의 조합으로 화면이 구성되며 UIView를 상속받았다. 즉 iOS 화면구성은 UIView의 집합으로 
되어 있다 
* 스토리보드에서 화면을 열자마자 기본으로 흰색의 root view 가 깔려있는것이다.

* 예제

```swift
let view = UIView(frame: CGRect(x: 80, y: 100, width: 200, height: 200))
	// 위치,크기 를 정해준다
	
        view.backgroundColor = .red
        //뒷 배경색
        
        view.alpha = 0.4
        //투명도
        
        self.view.addSubview(view)
        //이렇게 해야 비로소 view위에 view가 추가된다
        
        view.isHidden = false
        //view 가 보일지 말지 결정, 디폴트 값은 false
```

---

### UILabel
* UIView 를 상속받는다
* 다른 상호작용 없이 단순 정보제공


```swift
let label = UILabel(frame: CGRect(x: 300, y: 100, width: 100, height: 100))

        label.text = "저는 라벨입니다"
        // 라벨에 들어갈 텍스트
        
        label.textColor = .brown
        // 라벨에 들어간 텍스트의 색

        label.font = UIFont.systemFont(ofSize: 20, 
        weight: .semibold)
     	// 라벨의 텍스트 스타일

 	label.textAlignment = .center
      	// 라벨의 텍스트 정렬 방식

        label.numberOfLines = 2
        //라벨에 몇줄의 텍스트를 넣을지
        
        self.view.addSubview(label)
        //이렇게 해야 view 위에 라벨이 추가된다
```

---

### UIImageView
* UIView 를 상속받는다
* assets 에 추가된 이미지를 넣을수있다

```swift
let imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 200 , height: 200))

        imageView.image = UIImage(named: "pepe")
        // 이미지를 이미지 뷰에 할당해주는것, named 는 assets 에존재하는 파일명을 넣어주면된다.
        
        // imageView.image = #imageLiteral(resourceName: "pepe")
        // 이렇게 해놓으면 작은 이미지 볼수있음
        
        imageView.contentMode = .scaleAspectFit
        // 이미지가 이미지 뷰안에 들어갈때 어떻게 비율을 맞추는가에 대한것(ex : 화면비율에 맞춰 늘이거나 줄이기, 그냥 확대해버리기) 
        // scaleAspectFill : 비율을 유지한채로 사진을 확대하여 사진의 일부가 이미지 뷰를 벗어나도 전부다 가득찰때까지 확대한다.(사진의 일부가 이미지 뷰에 나오지않는다.)
        // scaleAspectFit :비율을 유지한채로 사진을 확대하다가 좌우나 상하가 맞는다면 거기까지만 확대한다(이미지뷰에 빈공간이 생긴다)
        // scaleToFill : 비율따위 무시하고 그냥 이미지뷰에 맞춰 마구마구늘려버리기
        
        self.view.addSubview(imageView)
        // 이걸 해줘야 view 에 추가된당
```

---

## Assets
* 효율적인 리소스 관리를 위해 사용
* 각 다른 디바이스에 따라 다른 리소스를 매칭해두고 실행시 적절한 리소스가 선택되어 표시된다  (ex : 화면의 디스플레이 화질에 따라 1x, 2x, 3x 로 나뉘어 선택, 거의 3x사용하며 가끔 2x 사용, 1x 는 사실상 쓸일이있을까? ) 

## UIControl
* UIComponent 에 사용자 상호작용에 의한 응답에 대해 특별한 액션을 줄수있게 설정하는 클래스

---

### UIButton
* 사용자의 이벤트를 받아 처리해주는 UI
* 버튼의 구조 : Title, Image, backgroundImage
* ViewController파일에 btnAction 메소드가 존재해야한다.

```swift
let addButton = UIButton(frame: CGRect(x: 100 , y: 400, width: 200, height: 200))
// 버튼의 기본 위치 설정

        addButton.setTitle("플러스", for: .normal)
        // 버튼에 표시될 텍스트,for 뒤는 버튼이 정상인 상태일때 저 텍스트를 표시한다는 뜻 노말 말고도 여러가지있다 나중에 쳐보자
        
        addButton.setTitleColor(.blue, for: .normal)
        // 버튼에 표시된 텍스트의 색
        
        addButton.addTarget(self, action:#selector(ViewController.btnAddAction(sender:)),  for: .touchUpInside)
                     // 여기서 버튼이 행할것, #Selector뷰컨트롤러에서 buttonAddAction 메소드를 한다는것까진 알겠는데 아직 헷갈림 내일 물어보기

        self.view.addSubview(addButton)
        // 항상 만든 버튼을 view 에 추가하는걸 잊지말자

```

## 주요 단축키 
| 이름 | 단축키 |
| --- | --- |
| Quick Help | `command + shift + O` |
| apple dev document | `command + shift + 0` |
| 자동완성 켜기 | `esc` |



