# Kingfisher

## 뭔가
- imageURL 을 이용하여 바로 사진으로 쓸수있게 해주는 오픈소스

## 사용법

1. 패키지 매니저나 pod 을 이용하여 설치 
2. `import Kingfisher`
3. 내가 이미지를 가져올 이미지의 주소를 URL 형식으로 생성
```
let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
```

4. 내가 설정하고싶은 이미지에 `.`문법으로 접근후 내가 설정하고싶은 이미지의 URL 을 넣어준다.
```
cell.cardImageView.kf.setImage(with: imageURL)
```

5. placeholder 나 completionhandler 도 제공하고 completionhandler 에 에러처리도 할수있음.