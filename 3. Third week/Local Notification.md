# Local Notification

## UserNotification(LocalNotification)

- notification인건 같은데 좀더 위로 올라가서 앱 내부가 아닌 기기 내에서 noti를 주고받는것이라고 보면됨, 아무래도 기능이 좀더 대단함.
- UNNotificationCenter 에 UNNotificationRequest 라는것을 보내고 특정 trigger 를 발동시키면 UNNotificationCenter 에서 해당하는 request 를 실행시켜준다. 즉 미리 하고싶은걸 보내놓고 조건만족시 꺼내서 해주는것.

### Request의 3가지 필수요소
- Identifier: 고유한 이름, 식별자
- Content: 포함하는 내용, 알림의 제목, 소리, 뱃지에 표시될 내용 등등
- Trigger: 이 알람이 어떤 조건에서 발생될것인가?
 1. Calender: 우리가 흔히 설정하는 알람, 일정 시간이 되면 작동하는것, (ex: 2021년 9월 21일 13시 02분)
 2. Timeinterval: 타이머, 몇분뒤에 작동하는것, (ex: 5분뒤에 작동하는것, 21일 뒤에 작동하는것)
 3. Location: 특정위치에 도달시 작동하는것(ex: 일정 지역에 도달시, 일정 거리 이동시)

## 사용방법

1. 제일먼저 `import UserNotifications` 해주고 `appdelegate` 에 가서 `extension` 에 `UNUserNotificationCenter.current()` 의 `delegate` 가 나라고 선언해주고 본체 안에 델리게이트 선언을 해준다

```swift
let notificationCenter = UNUserNotificationCenter.current()
//살짝 쓸데없이 긴 감이있으니까 그냥 notificationCenter 로 고정시키고 쓰는게 나은듯

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notificationCenter.delegate = self
        return true
    }
//저 함수 안 선언해주라는것
```

2. 내가 보내고싶은 알람의 형태를 정해준다.
```swift
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .list, .sound])
        //이게 알람의 형태를 정의해주는것, badge, banner, list, sound 모두 사용하겠다는 의미.
        //아직 이거했다고 권한 승인요청을 받은게 아니고, 단지 위의 형식의 noti 를 보낼것이라는 의미
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    print("노티 받았음")
   response.something something
        completionHandler()
        //이친구는 아직 모름 어따쓰지
    }
}
```

3. 위의 코드만 작성했다고 알람이 오진않는다. 아직 우리에게 승인을 받지않았기때문인데, 아래에 승인받는 alert 를 띄우는법

```swift
//appdelegate에서 import UserNotifications 해준다

아래 함수는 꼭 viewdidLoad 나 다른 시점에라도 넣어줘야한다. 이것자체가 승인 요청을 하는거니까

func 권한승인요청() {
let userNotificationCenter = UNUserNotificationCenter?
userNotificationCenter.requestAuthorization(options: [.sound, .badge, .alert, .carPlay, .criticalAlert]) { success, error in 
 if let error = error {
 	print("error 발생")
 	} else if success {
 		print("권한승인완료")
 	} else {
 		//이곳은 이제 사용자가 권한 수락을 거절했을때 넣어줄수있는 행동들을적는다 
 	}
 }
}
```

4. 이제 특정 버튼을 눌렀을때 userNoti에 추가되게 하는법

```swift
@IBAction func buttonTapped(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        //이부분은 나중에 변경가능한걸로 해보자

        content.badge = 10
        content.sound = .default
        content.title = "당장"
        content.body = "멈춰"
        //컨텐츠의 설정 

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        //트리거 설정, date, time, location 중 time 을 선택했고 interval 은 몇초 뒤에 알람이 올것인가를  말하고, repeat 은 반복 유무를 묻는것

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        //이제 트리거와 컨텐츠를모두 설정해줬으니리 리퀘스트를 만들어준다.

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ERROR", error.localizedDescription)
            }
            //user noticenter 에 리퀘스트를 추가해준것.
        }
    }
```

5. userNotificationCenter 에 보낸 리퀘스트를 제거하는 방법

- 이미 보낸 리퀘스트를 제거하고싶을땐 여러가지 방법이있다, 앞에다 `UNUserNotificationCenter.current()` 추가 해주고	
 1. 모든 리퀘스트를 제거하는것: `.removeAllDeliveredNotifications()`
 2. 리퀘스트중 아직 작동하지않은 리퀘스트 제거: `.removeAllPendingNotificationRequests()`
 3. 특정 id 를 가진 리퀘스트를 제거하는것: `.removeDeliveredNotifications(withIdentifiers: ["0", "2"])`
  - 배열형태로 id 를 적는데 그러면 그 아이디들전부 제거하는건가?
 4. 리퀘스트중 아직 작동하지않았는데 특정 id 를 가진 리퀘스트 제거: `notificationCenter.removePendingNotificationRequests(withIdentifiers: ["0"])`





