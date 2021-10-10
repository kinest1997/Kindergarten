# AutoLayout

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

### 사용 방법
1. 스토리보드 왼쪽 상단 뷰 컨트롤러에서 새롭게 위치를 정해줘야하는 뷰를 `ctrl + click `한채로 기준이 될 뷰에 드래그한다.
2. 다양한 메뉴들이 나오는데 필요한 조건들을 거기서 맞춰준다.
3. 난 스토리보드로 하는거 정말 별로다..


 
## Snap Kit
* 뷰 레이아웃 constraints 를 쉽고 간단하게 설정하게 도와주는 라이브러리 이다
* 오토 레이아웃할때 기존의 true, false 방식보다 더 간단하고 직관적이다.

## 설치방법
* `file -> add package` 후 오른쪽 주소창에   `https://github.com/SnapKit/SnapKit.git` 를 넣어준후 add package 하면 끝!

## 사용법
* 사용하기위해선 항상 `import Snapkit` 제일먼저 해준다
* left right 랑 leading, trailing 은 같지만 일부 아랍권 국가에서는 leading 이 오른쪽인 경우가 있기때문에 text 를 보여줄땐left,right 가 아닌 leading,trailing 사용하자. 이미지나 지도의 경우엔 그냥 left, right 로 하자

## offset 과 inset 의 차이점
### Offset
* 왼쪽 기준 원점을 잡아서 왼쪽으로 거리가 떨어지면 -, 오른쪽으로 떨어지면 + 
* 상단 기준 원점을 잡아서 아래로 내려가면 +, 위로 올라가면 - 
* 간단하게 생각하면 왼쪽 상단 (0, 0) 기준인거다
* 오토 레이아웃 공식에서 말하는 "간격" 이 offset 이다
    
### Inset
* inset 은 UIEdgeInsets 이며 상하좌우 모서리가 주어진 숫자 값만큼 거리를 두는것이다
* offset 과 inset 은 아예 다른개념 

```swift
import SnapKit
// 기본문법
// 위치를설정할 요소.snp.makeConstraints {

}
까지 적고 자동완성 시키면 아래의 형태가  나온다
make 가 2번 나오는걸로 보아 클로저 축약이 가능하다


	simpleLabel.snp.makeConstraints { make in
      make.center.equalTo(view.snp.center)
//	  equalToSuperView()
//	  equalTo(view)      
// equalTo 이후 부분은 3가지 모두 동일하다, superView 란 맨처음 가장 기본으로 나오는 view 를 의미함, 근데 마지막방법은 별로같기도
    }

//여러가지 조건을 한번에 다 연결시킬수도있다
simpleLabel.snp.makeContraints { make in 
  make.leading.top.trailing.bottom.equealToSuperView()
}

// 위 코드와 아래코드는 같은내용이지만 edge 를 이용하여 훨씬 짧게 작성가능

child.snp.makeConstraints { make in 
  make.edges.equalToSuperView()
}

//축약이 가능하다
$0.leading.equalTo(view.snp.leading).offset(10)
//위의 코드에서 view.snp. 부분은 앞에서 leading 이 나왔기때문에 생략해도 알아서 view 의 leading 으로 추론한다. 
//하지만 잘못설정하면 겹쳐서 나올수도있으니 조심

    simpleLabel.snp.makeConstraints {
    	$0.leading.equalTo(view.snp.leading).offset(10)
    	// simpleLabel의 leading 이 view 의 leading 에서 +10만큼 떨어져있다는것이다

    	$0.trailing.equalTo(view.snp.trailing).offset(-10)
    	// simpleLabel 의 trailing 이 view 의 trailing 에서 -10 만큼 떨어져있다는것

    	$0.width.equalTo(view.snp.width).multipiledBy(0.3)
    	//simpleLabel의 width 크기는 view 의 width에 0.3 을 곱한 만큼의 크기가 된다.

    }


    simpleLabel.snp.remakeConstraints()
    // 이렇게 하면 위의 조정사항은 무시하고 새롭게 설정한다, 만약 가로모드상태가 되면 이걸 실행 시켜라 이런느낌으로 하는가보다.

    simpleLabel.snp.updateConstraints()
    //  constant value 만 바꾸기때문에 remake처럼 코드를 작성시에는 오류가 난다. 어떻게 작성하는거지 나중에 물어보자 

    simpleLabel.snp.removeConstraints()
    // 제거하는것도있다

	//말고도 prepare 도 있던데 설명이 잘없다..


```

이것말고도 사용법이 많을텐데 차차 알아가자











