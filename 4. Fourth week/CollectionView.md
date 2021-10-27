# CollectionView

## Top- level containment and management

### Content Management

#### Protocol

-  UICollectionViewDataSource
1. 필수요소
2. 컨텐츠 관리 및 표시에 필요한 view 생성

- UICollectionViewDelegate
1. 선택요소
2. 특정상황에서 view 동작 custom


#### Class

- UICollectionView
- UICollectionViewController 

1. 시각적인 요소 정의
2. UIScrollView 상속
3. layout 정보 기반 데이터 표시

### Presentation

- UICollectionViewReusableView
- UICollectionViewCell

1. header,footer...
2. 재사용가능

### Layout

- UICollectionViewLayout
- UICollectionViewLatoutAttributes
- UICollectionViewUpdateItem

1. 각 항목 배치등 시각적 스타일 담당
2. View를 직접 소유하지않는대신 Attributes 생성
3. 데이터 항목 수정시 UpdateItem 인스턴스 수신

### Flow Layout

- UICollectionFlowLayout
- UICollectionViewDelegateFlowLayout (protocol)
1. Grid, line-based layout 구현
2. 레이아웃 정보를 동적으로 Custom


## UICollectionViewCompositionalLayout

### 뭔가?
1. 복잡한 결과를 단순한것으로 구성하기
2. 이것만으로 모든 레이아웃을 작성 가능하게 하기
3. 프레임워크에서 자체성능 최적화 수행
4. ios 13인가에 나옴.

### 메인 구성요소


#### size
- 너비와 높이 값을 가짐

1. Absolute: point 값을 넣어서 정확한 치수 지명
2. Estimate: 추정값, 데이터가 로드될때 사이즈가 변경되면 시스템이 알아서 실제값을 반영함. 앱솔루트처럼 예상되는 포인트 값을 넣어주면됨
3. Fractional: 분수,비율이라는 의미. itemcontainer 의 크기를 기준으로 배율을 곱하여 정함. autolayout에서 multiply 와 같음


#### item
- 개별 컨텐츠의 크기, 정렬방법에 대한 청사진.


#### group
1. 아이템들이 서로 관련하여 배치되는 방식을 결정해서 결합하는 역할
2. 항목을 가로행 세로행, 또는 사용자 배열로 배치 가능
3. item의 하위 클래스, 다른 그룹을 포함할수있다. stackview 랑 비슷


#### section
1. group으로 이루어져있다.
2. 레이아웃을 각각의 영역으로 분리하는 방법제공
3. 각 섹션은 다른 컬렉션뷰의 섹션의 레이아웃과 다르거나 같을수있다.


#### layout
1. 섹션이 있어야하고 섹션은 그룹이있어야하고, 그룹엔 아이템이필요하고, 아이템과 그룹은 높이와 너비 dimension을 가지는 size를 가질수가있다
2. layout -> section -> group -> item