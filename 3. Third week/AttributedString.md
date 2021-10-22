# AttributtedString

## 뭔가?
- 연속된 String 들이 있을때 그 개별의 String 에게 속성을 불어넣어주어 1개의 텍스트 안에서도 각기 다른 형상을 할수있게 해주는것
- ex: font, size, backgroundcolor 등의 여러가지 속성을 불어넣어줄수있다

## 사용방법
1. 내가 넣을 텍스트의 레이아웃을 확인한다(ex: size, color, emoji, font 등)

2. Font 추가의 경우 폰트 파일을 드래그하여 내 번들에 추가하고, plist에 `Fonts provided by application` 를 추가하고 그 하위에 폰트들을 추가해주는데, value 값으로 `NEXONLv1GothicOTFBold.otf` 같은 형식으로 확장자명까지 풀로 넣어주면된다. 이러면 폰트를 내 엑스코드 프로젝트에 등록한것!

3. color 의경우 Assets에 들어가서 좌측 하단 + 를 누르고 colorset 을 클릭하면 색을 추가할수있는데 appearance로 다크모드나 라이트모드에서의 색을 정해줄수있고, 색을 srgb 나 p3 에맞는 수치로 세밀하게 색을조절할수있다.


4. 내가 자유자재로 변경하고싶은 텍스트를 이제 변경가능한 string 이라고 정의한다. 즉 Label 등에 들어갈 한뭉텅이의 String

```
let firstLabelText = NSMutableAttributedString(string: "첫번째 라벨✍🏽")
```

5. 이 텍스트의 속성을 추가해주는데 텍스트의 폰트뿐만 아니라 별의별 이상한걸 다추가해줄수있다, 하지만 일단은 폰트만 변경하는걸로하면 아래와같음
- 폰트의경우 대부분 동일한걸 사용하기때문에, 내가 사용할 폰트는 따로 정의해놓자
- 애플이모티콘의 경우 폰트의 이름은 AppelColorEmoji 이다



```
let boldNexonFont = UIFont(name: "NEXONLv1GothicOTFBold.otf", size: 50)

let emojiTextFont = UIFont(name: "AppleColorEmoji", size: 60)

firstLabelText.addAttribute(.font, value: boldNexonFont, range: NSRange(location: 0, length: 3))

//.font 자리에 별의별 이상한것들이 다들어갈수있다, value 자리에 UIFont 타입이 틀어갈수있다, range 는 0번 index 부터의 갯수를 말함. 
```

6. 만약 범위내에 독특한 이모티콘같은게 들어갈경우 범위를 index 를 이용한 nsrange 로는 표현이 불가능하다 고로 아래의 방식을 사용

```
 firstLabelText.addAttribute(.font, value: smallTextFont, range: (firstLabelText.string as NSString).range(of: "✍🏽")
 //firstLabelText의 string 을 nsstring 으로 캐스팅 해주고(둘다 비슷하다는데 참 왜 매번왔다갔다 하는것인가) ✍🏽 이친구가 포함된 범위를 정해서 그범위 내의 String 에게 attribute 를 선사해주는것
```

7. 이렇게 한 텍스트 뭉텅이 `firstLabelText` 에 속성을 모두 불여넣어줬으면 이제 텍스트에 적용시킨다
- 그대신 여태까지 써오던 `someLabel.text = firstLabelText` 형식이 아닌 아래의 형식을 사용한다, 온갖속성이 들어간 텍스트니까

```
firstLabel.attributedText = firstLabelText
```

8. 전체 코드

```
let firstLabelText = NSMutableAttributedString(string: "첫번째 라벨")
//이뻐지려는 문자열을 할당

let boldNexonFont = UIFont(name: "NEXONLv1GothicOTFBold.otf", size: 50)
//내가 사용할폰트들을 할당

firstLabelText.addAttribute(.font, value: boldNexonFont, range: NSRange(location: 0, length: 6))
//특정 문자열에 속성을 넣어주기

firstLabelText.addAttribute(.font, value: emojiTextFont, range: (firstLabelText.string as NSString).range(of: "✍🏽")
//이모지는 따로 분리해서 넣어주기

firstLabel.attributedText = firstLabelText
//속성을넣은 텍스트를 attributedText 에 넣어주기
```