# ViewController Life Cycle

## UIViewController LifeCycle
![사진](https://t1.daumcdn.net/cfile/tistory/998D703359F037C907)

## viewDidLoad
- 뷰 컨트롤러의 모든 뷰들이 메모리에 로드됐을때 호출
- 메모리에 처음 로드될때 한번만 호출
- 보통 딱 한번 호출될 행위들을 이 메소드 안에 정의함
- 뷰와 관련된 추가적인 초기화 작업, 네트워크 호출
- 로드가 완료된것이지 아직 보이는건 아니다

## viewWillAppear
- 뷰가 뷰 계층에 추가되고 화면에화면에 보이기 직전에 매번 호출
- 다른뷰로 이동했다가 돌아오면 재호출
- 뷰와 관련된 추가적인 초기화 작업

## viewDidAppear
- 뷰 컨트롤러의 뷰가 뷰 계층이 추가된 후 호출된다
- 뷰를 나타낼때 필요한 추가 작업
- 애니메이션을 시작하는 작업

## viewWillDisappear
- 뷰 컨트롤러의 뷰가 뷰 계층에서 사라지기 전에 호출된다
- 뷰가 생성된뒤 작업한 내용을 되돌리는 작업
- 최종적으로 데이터를 저장하는 작업

## viewDidDisappear
- 뷰 컨트롤러의 뷰가 뷰 계층에서 사라진뒤에 호출
- 뷰가 사라지는것과 관련된 추가작업