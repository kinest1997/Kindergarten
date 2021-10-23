# CustomClass

## 나만의 클래스
- 자동완성 기능처럼 내가 미리 특정 attribute 들의 속성을 설정해놓고 그것을 불러와서 쓸수있게 하는것
- 버튼이 20가지정도 필요한데 4,6,3,3,4 개씩 버튼이 background, alignment, text 속성이 각각 같다면 새로운 클래스로 만들어주고 그걸 상속받게 하면 편할듯

## 연습

### Button
- 사용할때 이 MyButton 을 상속받기만 해도 기본 속성들은 다 정해져있고 그저 레이아웃만 정해져도 작동하는 버튼이 될수있다!

```
class MyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("다음", for: .normal)
        self.backgroundColor = self.state == .normal ? .blue : .red
        self.backgroundColor = self.state == .selected ? UIColor(named: "Mint") : .systemGray
        let printAction = UIAction { _ in
            print("23213123312")
        }
        self.addAction(printAction, for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

### ViewController
- viewdidload 시점을 사용할게 아니라면 이렇게 해놓고 상속받기만 하면 `layout`, `attributes` 함수만 오버라이딩해서 작성하기만 하면 더 깔끔하게 코드를 작성할수있다. 이걸 상속받은 뷰컨트롤러는 코드를 줄일수있는것

```
class MyView: UIViewController {
    //뷰컨트롤러는 init 을 하지않아서 override 를 쓰지않고 그냥 여기서 처음 init 하는거같다, 
    //init 시점에 뭔가 하고싶다면 initialized 를 오버라이딩해서 사용하면된다(상속받는 뷰컨에서)
    init() {
        super.init(nibName: nil, bundle: nil)
        initialized()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
    override func viewDidLoad() {
        super.viewDidLoad()
        attributes()
        layout() 
    }

    func initialized() {}

    func layout() {
        나중에 오버라이드 해서 레이아웃에 집어넣기만 하면 viewdidload 안에 안넣어도 알아서 잘 작동한다.
    }
    
    func attributes() {
        view.backgroundColor = .systemYellow
    }
}
```