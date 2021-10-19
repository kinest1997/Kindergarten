# Notification Center

## 이것이 뭔가?
- 광역 방송국에 가까우며 만약 누군가 구독을 해놓았다면 방송국에서 방송을 할 경우 그 방송을 청취할수있는것과 비슷하다
- UserNotificationCenter 와 Notification Center 가 있으며 둘은 비슷하지만 범위가 완전 다르다. 
- NotificationCenter 는 앱 내에서 한정한 방송국이라면
- UserNotificationCenter 는 사용 기기 전체로 확대된 방송국 느낌


## Notifiation Center 
- Notification Center 에 관찰자를 추가하는 형식으로 사용한다.
- 일반적으로 키보드의 움직임을 관찰하는 것을 Notification Center 에 추가하고,  키보드의 활성화 상태에 따라 어떤 행동을 할지 정하는것으로 사용한다. 
- 일반적으로 키보드 관련한 Notification Center 만 사용하지만 custom으로 만들어서 delegate, closure와 같은 데이터 전달법으로 사용할수있다.


### KeyBoard notification

1. 제일먼저 활동을 관찰할 observer를 등록해준다. 
2. 어떤활동을 관찰하는가? `UIResponder.keyboardWillShowNotification` 라는 행동을 관찰
3. 행동을 관찰하고 어떤것을 할것인가? `keyboardNotificationHandler(_:)` 라는 행동을 한다.
4. object 는 필터역할, 내가 원하는 타입을 정해서 그 타입만 받아올수있다.
```swift
func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(
        	//self 인 이유는 키보드 관찰자가 ViewController 본인이기 때문이다.
        	keyboardNotificationHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        //아래는 곧키보드가 사라질때 를 관찰하는 것
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotificationHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
```

5. 내가만든 selector 함수는 뭔가?

```swift
   @objc func keyboardNotificationHandler(_ notification: Notification) {

   	//자동으로 selector 가 notification 을 UIResponder.keyboardWillShowNotification 으로 받아오기때문에 파라미터를 저렇게 설정.

        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            print("키보드가 보여질 것임")
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            //이렇게 키보드의 height 값을 알게된다

            self.view.frame.origin.y = 0 - keyboardSize.height
            //그리고 우리에게보여주는 frame 의 Y 좌표를 키보드 높이만큼 올려주어야하니까 0에서 빼준다(y값의 방향이 아래가 + )
        case UIResponder.keyboardWillHideNotification:
            self.view.frame.origin.y = 0
        default:
            return
        }
    }
```

6. 이렇게 하면 키보드의 높이로인해 내가 입력하는 창이 가려지는 불상사가 사라진다.

7. 그리고 항상 내가 현재 보고있는 뷰에서 나갈떄 observer 를 해제해줘야한다, 현재 뷰를 보고있지않는데 계속 관찰하고있을 필요가없으니까. 계속 활성화시켜두면 메모리를 잡아먹고 이건 자원낭비이다.

```swift
func unregisterKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //내가 등록한 옵저버는 2개니까 2개 다 제거해준다. 
    //관찰 하던 노티의 이름을 적어주고 함수를 viewdidload 의 deinit 시점에 넣어주면 된다 아래처럼하면됨

     deinit {
        unregisterKeyboardNotification()
    }
```

### CustomNotification

1. 관찰자를 추가하는것은 똑같다.
2. 하지만 Notification의 이름 내가 새롭게 만든 `Notification.Name.init(rawValue: "DarkMode")` 으로 설정해준다. 

```
func registerDarkModeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setDarkMode(_:)), name: Notification.Name.init(rawValue: "DarkMode"), object: nil)
    }
```

3. 이렇게 하면 notificationCenter 에서 받을 준비는 완료, notificationCenter로 방송을 보내줄 친구를 설정해주자

```swift
NotificationCenter.default.post(name: Notification.Name.init(rawValue: "DarkMode"), object: UIUserInterfaceStyle.dark)
```

4. 위 코드는 notification 의 이름이 `Notification.Name.init(rawValue: "DarkMode")` 이고 (방송의 이름이라는것), `object` 안에 내가 넣어서 보내주고싶은 정보를 담아서 보내주면 된다. 여기선 `UIUserInterfaceStyle.dark` 라는 정보를 담아서 준것.

```swift
func unregisterDarkModeNotification() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.init(rawValue: "DarkMode"), object: nil)
    }
```

5. 당연히 이친구도 관찰이 끝나면 똑같이 deinit 시점에 observer 를 해제해줘야한다. `viewdidload` 안에다가

```
    deinit {
        unregisterDarkModeNotification()
    }
```
