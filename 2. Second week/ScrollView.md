# ScrollView


## 이게 뭔가?
* 스크롤 뷰는 스크롤되는 뷰들을 담고 있는 Content Layout과 화면에 보여지는 Frame Layout으로 나눠진다
* Content layout에는 스크롤 되는 전체 content를 가지고 있다 
* Frame layout은 잘려서 보여지기 때문에 스크롤 해야 content layout의 다른 contents를 볼 수 있다

## 만드는 방법

1. UIScrollView 와 UIView 선언

```
let mainScrollView = UIScrollView()
    let mainView = UIView()
```

2. UIScrollView를 메인 View 에 추가해주고, UISCrollView 안에 새로만든 UIView 를 추가해준다.

```
self.view.addSubview(mainScrollView)
self.mainScrollView.addSubview(mainView)
```

3. UIScrollView의 오토레이아웃을 맞춰준다

```
mainScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
```

4. UIScrollView 에있는 ContentLayout 에 우리가 넣은 View의 레이아웃을 맞춰주고, 어느쪽으로 스크롤이 가능하게 할건지 FrameLayout으로 맞춰주자

```
mainView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView.contentLayoutGuide)
            //메인뷰가 스크롤 뷰에서 얼마나 보여주고싶은지 그 영역을 정하는것 만약 메인뷰가 contentLayoutGuide 보다 작다면 보여지는 화면이 뷰의 크기보다 작기때문에 4방향 스크롤이 가능할것임

            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            //폭을 고정하여 위아래로만 스크롤이 가능하게 한것

            $0.height.equalTo(2000)
            뷰의 높이를 2천으로 설정하여 
        }
```

5. 이제 내가 뷰에 구성하고싶은 모든것들을 넣고 즐기면됨


## 연습

```swift
class ViewController: UIViewController {
    let mainScrollView = UIScrollView()
    let mainView = UIView()
    let UIBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "네비게이션바"
        navigationController?.navigationBar.tintColor = .systemRed
      
        self.view.addSubview(mainScrollView)
        self.mainScrollView.addSubview(mainView)
        view.backgroundColor = .systemBackground
        
        mainView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView.contentLayoutGuide).inset(50)
            $0.width.equalTo(mainScrollView.frameLayoutGuide)
            $0.height.equalTo(2000)
        }
        
        mainScrollView.backgroundColor = .systemGray
        mainScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)        }
    }
}
```