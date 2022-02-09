# CocoaPod

## 뭔가?
- CocoaPods는 Swift 및 Objective-C Cocoa 프로젝트의 종속성 관리자. 
- *즉, 프로젝트에 필요한 라이브러리를 CocoaPod을 통해 쉽게 관리하고 사용할 수 있습니다.*

## 설치방법
1. 아래 코드를 복사하여 터미널에 복사하여 실행시켜준다. 
`sudo gem install cocoapods `
2. pod을 설치하고싶은 폴더에 우클릭하여 `이폴더에서 터미널 열기`
3. `pod init` 입력하고 엔터
4. podfile 이라는것이 폴더안에 생기는데 들어가보자

- 아래는 예시
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'Cocktail' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Cocktail

//여기 아래처럼 쭉 설치하고싶은 라이브러리를 적어주면된다

pod 'SnapKit', '~> 5.0.0'
pod 'Kingfisher', '~> 7.0'
pod 'lottie-ios'
pod 'Siren'
pod 'Then'

pod 'Firebase/Analytics'
pod 'Firebase/Auth'
pod 'Firebase/Messaging'
pod 'Firebase/Storage'
pod 'Firebase/Database'

pod 'RxSwift', '6.2.0'
pod 'RxCocoa', '6.2.0'
pod 'RxAppState'
pod 'RxDataSources'

end
```

5. 이렇게 적고 저장해준다음 터미널에서 `pod install` 적어넣고 엔터눌러주면 끝!

