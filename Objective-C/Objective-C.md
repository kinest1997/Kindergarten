# Objective-C

## 뭔가?
- c언어의 연장선상에 있는 애플에서 사들인 언어
- swift 이전의 언어이며 상당히 복잡하다
- O(Object) O(Oriented) C(Code) 즉  OOC 객체 지향 코드
- reflection: 런타임시에 내가 원하는 클래스의 메소드를 활용할수있는것? 명확하지않음

## 기본적인 구조 


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


### Semicolon
- 모든 선언문 종료시에는 `;` 을 붙여주어야 그 문장이 종료된다
- swift 에서는 단순한 엔터로 하거나 저절로 구별해주던것과 좀 다름


### Comment
- 주석 즉 컴파일러가 읽지 못하는 텍스트
- `/* someCode */` 형태로 작성한다


### Identifiers
- 식별자 즉 고유한 이름
- objective - C 에서 식별자는 변수, 함수등등 유저가 정의내린 것들을 구별하기위한 이름이다
- @,$,% 와 같은 구두점 문자는 사용할수없으며 대소문자를 구별한다. 

### keyWord

- 아래 키워드들은 몇몇 반전된 단어들이다. 

auto	else	long	switch
break	enum	register	typedef
case	extern	return	union
char	float	short	unsigned
const	for	signed	void
continue	goto	sizeof	volatile
default	if	static	while
do	int	struct	_Packed
double	protocol	interface	implementation
NSObject	NSInteger	NSNumber	CGFloat
property	nonatomic;	retain	strong
weak	unsafe_unretained;	readwrite	readonly



### White space
- 공백만있거나 주석과 함께 공백이있다면 컴파일러는 무시한다
- 공백은 탭, 줄바꿈문자 및 주석을 설명하는데 사용된다
- 특정한 이름과 타입을 구별하기 위해 붙이기도 함
- `int number` 이러한 경우 number변수가 int타입이라는것?

### Data Type
- 데이터의 타입으로서 여러가지가 있다
1. Basic
2. enum
3. void
4. Derived

### Variables


### @property


