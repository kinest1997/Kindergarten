# UINAvigationcontroller

## 이친구는 뭔가
* 일반적으로 앱의 화면 제일 아래에 window 가 깔려있고, 그위에 ViewController 들이 올라가는 형태다
* 이경우 화면이 하나밖에없는 앱은 문제가없지만 화면전환을 해야하고 앱내에 여러개의 ViewController 들이 있다면 그걸 전부다 계속 위에 띄우고 띄우고 할수는 없는노릇
* 이때 window 위에 바로 ViewController 를 올리는게 아닌 UINAvigationcontroller 를 제일 먼저 올려 그친구가 다른 ViewController 들을 관리하도록 해주는것. 
* 원래 1번 뷰에서 2번뷰로 넘어갈때 원래는 1번뷰 위에 2번뷰가 겹쳐져서 2개가 존재하겠지만, 이친구 덕분에 1번뷰를 자동으로 없애고 2번뷰를 나타나게 해준다. 
- 이말인 즉슨 자원의 낭비를 줄여준다는 이야기.

## 사용법
- 아직 정확히는 잘 모르지만 일단 내가아는선

1. SceneDelegate 에 들어가보면 뭐가 잔뜩있는데 그중 func scene 이라는 함수아래에 아래친구가 보인다

```swift
guard let _ = (scene as? UIWindowScene) else { return } 
//보면 _ 로 표시된게 있는데 그게 UIscene 을 UIWindow 로 다운캐스팅 해주고 아래에서 쓸일이없어서 저렇게 둔건데 우린 써야하니 이름을 붙여준다.
```

2. 이름은 만만하게 windowScene 로 지어주자 이름은 크게 상관없으니
```
guard let windowScene = (scene as? UIWindowScene) else { return } 
```

3. SceneDelegate 가장 위에  var window: UIWindow? 가 선언되어있는데 이 window를 이제 만들어줄거다 

```
window = UIWindow(windowScene: windowScene)
//여기서 window 를 설정해준다 근데 위에서 받은 windowScene 를 받는걸로
//UIScene 랑 UIWindowScene는 서로 상속해주고받는 관계지만  UIWindow는 저둘과 전혀 연관이없다.
```

4. rootViewController 란 앱을 켰을때 가장 먼저 띄워줄 ViewController 를 말한다. (솔직히 맞나 모르겠지만 다른거 구성요소의 root를 생각하면 제일먼저 기반으로 띄우니까 맞는거같은데) 
window 위에 UINAvigationcontroller 올려야 하니까 적어주고,UINAvigationcontroller 자체는 빈화면이라 또 그 UINAvigationcontroller 가 제일먼저 보여줄 
ViewController를 정해줘야한다

```
window?.rootViewController = UINavigationController(rootViewController: ViewController())
```

5. 이렇게 하면 네비게이션 컨트롤러가 페이지를 알아서 잘 관리해준다. 이전화면으로 돌아가는 버튼도 자동으로 생성해주고.
 * 근데 만약 1번 뷰에서 2번뷰로 갔는데 2번뷰 안에 1번뷰로 돌아가는 버튼을 만들어버린다면? UINavigationController가 만들어준 상단버튼도 있는데 그러면 끝도없이 반복될수있으니 막자

6. 앱을 켰을때 시작 로그인 화면인데 만약 로그인을 한번 했다면 그이후로 자동으로 로그인페이지 말고 메인화면을 띄우고 싶다면?
 * 로그인 정보가 있을땐 메인화면으로 가게하고 로그인 정보가 없으면 로그인 화면으로 오게 할수있다
 * 그리고 만약에 메인화면이 띄워진다면 뒤로가기 버튼이 없어야할테니 네비게이션컨트롤러는 메인화면부터 적용되게 해야할것

7. 만약 아이디와 비밀번호에 해당하는 정보가 비어있다면 false 를 뱉는데아래 형식으로 함수를 만들고

```swift
func isNew() -> Bool {
       if UserDefaults.standard.string(forKey: "아이디") == nil,
        	  UserDefaults.standard.string(forKey: "비밀번호") == nil {
        	  	 return true
        	  	}
        	  	else {return false}
    }
//이건 가드보다 if 가 더 보기 편한듯 

func isNew() -> Bool {
        guard UserDefaults.standard.string(forKey: "아이디") == nil,
        	  UserDefaults.standard.string(forKey: "비밀번호") == nil
           else {
                  return false
              }
        return true
    }

```

8. 아래에서 간단하게 3항 연산자로 설정해주면 끝!

```swift
     let rootViewController = isNew() ? LoginViewController() : UINavigationController(rootViewController: WelcomeViewController())
        
        window?.rootViewController = rootViewController
```

9. 마지막에 이거 한줄까지 해줘야 화면이 보인다

```
window?.makeKeyAndVisible()
```


10. 전체코드

```swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = isNew() ? LoginViewController() : UINavigationController(rootViewController: WelcomeViewController())
        
        window?.rootViewController = rootViewController

        window?.makeKeyAndVisible()
    }

    func isNew() -> Bool {
       if UserDefaults.standard.string(forKey: "아이디") == nil,
        	  UserDefaults.standard.string(forKey: "비밀번호") == nil {
        	  	 return true
        	  	}
        	  	else {return false}
    }
}

```

11. 기타 팁
- show,dismiss 는 네비컨이 없을때
- push,pop 은 네비컨이 있을때

- `.pushViewController` 네비게이션 컨트롤러가 있을때 새 창을 띄우고싶을때 push 를 한다

- 만약 다른곳에서 현재 네비게이션 컨트롤러가 열고있는 창을 없애고 싶을때, 가장 위에 놓인 뷰를 없애고싶을때 사용가능
- 만약 현재 열린뷰가 하나라면 사용 불가능

```
self.navigationController?.popViewController(animated: true)
```

- 만약 내가 네비게이션컨트롤이 열어준 첫번쨰 뷰, 즉 메인뷰가 나인가? 라고 묻는것
`return navigationController?.viewControllers.first == self`