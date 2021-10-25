# Auth

## OAuth 란?
- 사용자 인증 방식에 대한 업계 표준
- ID/ PW 를 노출하지않고 OAuth 를 사용하는 업체의 API 접근 권한을 위임받음
 1. User: Service Provider 에 계정을 가지고있는 사용자 (ex: apple, google)
 2. Consumer: Service Provider 의 API(제공하는 기능)를 사용하려는 서비스(ex: 앱, 웹 등)
 3. Service Provider: OAuth 를 사용하여 API 를 제공하는 서비스
 4. Access Token: 인증 완료 후 Service Provider의 제공기능을 이용할수있는 권한을 위임받은 인증키

- 흐름도 
 1. User 가 google 에 로그인 요청
 2. 앱이 서버에 로그인 요청을 담은 request token 을 만들게한다
 3. 서버에서 request token을 google 에게 보낸다.
 4. google 에서 사용사에게 권한 위임확인 요청(접근권한) 을 보낸다
 5. 사용자가 권한 위임요청을 수락하면 google 에서 서버에 특정 서비스에 접근가능한 access token 을 보낸다
 6. 앱은 사용자에게 로그인 완료를 보여준다

## 사용방법
- 공통적으로 스위프트 패키지 매니저로 firebase.auth 를 설치해줘야한다. 


### 이메일, 패스워드 인증


1. 내가 인증 기능을 사용할 viewcontroller에 `import FirebaseAuth`를 선언해준다

2. 아이디와 비밀번호를 텍스트 필드에 입력후 버튼을 눌렀을때, 그 텍스트 필드에 입력된 내용을 기반으로 회원가입을 하는 과정

```
let email = emailTextfield.text ?? ""
let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            //만약 에러코드가 있다면 수행할 내용
            if let error = error {
                let code = (error as NSError).code
                switch code {
                  //코드 17007 의 경우 새 유저를 생성하려고하는데 이미 해당 아이디로 가입된 유저가 있다는것, 즉 회원가입이 아닌 로그인을 수행하면 해결된다

                case 17007:
                    self.loginUser(email: email, password: password)
                    //위의 코드는 그냥 날것으로 작성해도 되지만 가독성을 위해 함수로 따로 뺴서 작성.

                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
                // 에러코드가 존재하지않으면 아래의 내용으로 간다.
            }else {  self.showMainViewController() }
        }
```

3. 로그인을 하는 과정

```
    private func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self]_ , error in
          //signIn 메소드가
            guard let self = self else {return}
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
```

4. 이건 그냥 다음화면 넘어가는함수 
```
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
```

5. 만약 로그인된 상태에서 로그인한 회원의 아이디값에 접근하고 싶다면?

```
let email = Auth.auth().currentUser?.email ?? "고객"
```

- 이러면 email 값에 접근 가능.


### Google 로그인

1. 스위프트 패키지 매니저로 [GoogleSignIn](https://github.com/google/GoogleSignIn-iOS) 을 설치해준다. 

2. GoogleService- info 에 가서 REVERSED_CLIENT_ID 의 value 값을 복사한다.

3. 앱의 target -> info -> URLtypes 에서 + 를 눌러 추가하고 URL Schemes 에 내가 복사한 값을 넣어준다

4. Appdelegate 에 가서 GIDSignInDelegate 채택해주고, 아래 두 코드를 didfinishlaunch 함수안에 적어준다

```
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
```

5. 이함수도 AppDelegate 안에 작성 일단 보류 이부분은

```
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
```

6. 내가 로그인을 실행할 버튼이 상속받는 UIButton 을 구글에서 제공하는 버튼으로 변경해준다
```
@IBOutlet weak var googleLoginButton: GIDSignInButton!
```

7. 버튼을 눌렀을떄 로그인 화면을 띄울 뷰컨트롤러가 나라는것을 viewdidload 시점에 선언
```
GIDSignIn.sharedInstance()?.presentingViewController = self
```

8. 버튼을 눌렀을때 로그인 화면을 띄우는 액션을 선언해준다.
```
GIDSignIn.sharedInstance().signIn()
```

9. appdelegate 로 돌아가서  여기서 또 보류 

10. 로그아웃은 do,try,catch 안에 signout 함수 넣어주면됨


