# AutoLayOut

## 이게뭔가?
* 화면의 구성 요소들은 일정한 크기를 가지는데 만약 화면 크기가 다른 디바이스의 경우 구성요소들의 위치가 변경될수있다
* 그때 오토레이아웃이 화면크기에 관계없이 일정한 위치를 가질수있도록 해준다.

-

### Constraints
* 각 뷰의 거리, 길이, 위치 등을 표현하기 위한 제약
* 대상 View의 Attribute는 기준View의 Attribute X 비율 +간격이다.

### Attribute
* Size attributes

>> width : 가로  
>> height : 세로

* Location attributes

>> Leading : 앞전  
>> Trailing : 뒷전  
>> Top : 상단  
>> Bottom : 하단   
>> Vertical : 수직  
>> Horizontal : 수평  

-

###사용 방법
1.  스토리보드 왼쪽 상단 뷰 컨트롤러에서 새롭게 위치를 정해줘야하는 뷰를 `ctrl + click `한채로 기준이 될 뷰에 드래그한다.
2. 다양한 메뉴들이 나오는데 필요한 조건들을 거기서 맞춰준다.


 
## Snap Kit
* 뷰 레이아웃 constraints 를 쉽고 간단하게 설정하게 도와주는 라이브러리 이다
* 오토 레이아웃할때 기존의 true, false 방식보다 더 간단하고 직관적이다.

## 설치방법
* `file -> add package` 후 오른쪽 주소창에   `https://github.com/SnapKit/SnapKit.git` 를 넣어준후 add package 하면 끝!

## 사용법
* 제일먼저  이걸해준다
* left right 랑 leading, trailing 은 같지만 일부 아랍권 국가에서는 leading 이 오른쪽인 경우가 있기때문에 left right 사용하자

```swift
import SnapKit
```

나머지 사용법은 좀더 연습한후에 해보자..아직은 다 알지 못한다.

