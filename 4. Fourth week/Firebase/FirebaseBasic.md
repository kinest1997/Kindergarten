# Firebase

## 뭔가?
- frontend 개발에 필요한 여러 서비스들을 제공해준다.
- 1인 개발자를 위한 모바일 및 웹 애플리캐이션 서비스 제공자.

## Platforms

- 아래 말고도 여러가지 플랫폼들이 있다

### 인증(Auth)

### Cloud Firestore

### 실시간 데이터베이스(Realtime Database)

### A/B 테스팅

### 클라우드 메시징

### 원격구성(Remote Config)

## 기본 등록
- AppDelegate 에서 이걸 추가해준다

```
import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
      [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
```
- 이후의 과정은 다른 파일에