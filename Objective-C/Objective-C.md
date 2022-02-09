# Objective-C

## 뭔가?
- c언어의 연장선상에 있는 애플에서 사들인 언어
- swift 이전의 언어이며 상당히 복잡하다
- O(Object) O(Oriented) C(Code) 즉  OOC 객체 지향 코드
- reflection: 런타임시에 내가 원하는 클래스의 메소드를 활용할수있는것? 명확하지않음


## swift와의 차이점들

1. 파일 생성시 차이점
- swift: some.swift 형식으로 파일이 생성
- objc: some.h(헤더), some.m(메인) 형식으로 파일이 생성

2. String 문자열 사용시
- swift: 그냥 "문자열"
- objc: @"at이붙은 문자열"

### 헤더와 메인의 역할


2. viewController에서의 차이점

- swift: 기존 알던 방식
- objc: 



```
// ViewController.h
// 헤더파일의 경우
#import<UIKit/UIKit.h>
@interface Viewcontroller: UIViewController
@end
```

- 인터페이스로 시작시 반드시 End해줘야한다

```
// ViewController.m
// 메인파일의 경우
# import "ViewController.h"
//헤더파일을 import해준다

@implementation ViewController
- (void)viewdidLoad {
[super viewDidLoad];

}


```
- 한문장이 끝날때마다 `;`세미콜론을 반드시 해줘야한다 

### main.m
- c언어에서 왔기때문에 main함수가 반드시 있어야한다.


### @property


