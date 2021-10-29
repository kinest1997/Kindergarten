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




## 사용 방법
1. 제일먼저 우리가 띄울 collectionView 를 생성해주고. collectionView에는 flowLayout이 필요하다. SceneDelegate로 가서 아래의 설정을 해준다.

```
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let layout = UICollectionViewFlowLayout()
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        let rootNavigationController = UINavigationController(rootViewController: homeViewController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
```

2. 섹션당 보여질 셀의 갯수, 섹션 갯수를 정해준다

```
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
		//첫번재 섹션의 경우 1개의 셀만을 보여준다.

        default:
            return contents[section].contentItem.count
            //나머지 섹션의 경우 내 컨텐츠의 섹션 안의 contentitem array 의 갯수만큼 보여준다는 의미
        }
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
        //섹션의 갯수를 정하는것.
    }
```

3. 이제 섹션안에 들어갈 cell을 만들어준다.
- `UICollectionViewCell` 클래스는 기본적으로 view 위에 contentView 라는것이 올라가있는 형태이므로 우리가 넣고싶고, 수정하고싶은 사항들은 전부다 contentView에다가 설정해줘야한다. self.view 가 아니다.
- `layoutSubviews` 함수를 오버라이딩 해서 사용하고 그 안에 내가 설정하고싶은 attributes 나 layout 을 넣어줘야한다.

```
class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    //셀은 단순하게 이미지만 들어가는 셀

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
```

4. 만들어준 cell을 메인 콜렉션 뷰에 등록 해줘야한다.
```
 collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "key")
 ```

5. 등록한 셀을 이제 콜렉션뷰에 넣어서 사용할수있게 설정해줘야한다

```
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectiontType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "key", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
```


6. 각 섹션에는 header 가 필요할것이다, 그 header 를 설정해주기위해 먼저 셀처럼 재사용 가능한 headerView 를 만들어주자
- header, footer 가 되기위해선 `UICollectionReusableView` class를 상속받아야만한다.
- 컬렉션뷰 셀을 만들때 처럼 `layoutSubviews` 함수를 오버라이딩 해서 그안에 설정들을 다 해준다.
```
class ContentCollectionViewHeader: UICollectionReusableView {
    
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        addSubview(sectionNameLabel)
        
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}

```

7. 만들어준 `UICollectionReusableView` 를 등록해줘야한다.
- 하지만 이건 cell 이 아니라 view 이기 때문에 혼동하여 cell 로 등록해서는 안된다.
- `forSupplementaryViewOfKind` 는 지금 넣는 이 뷰가 어떤 역할인지 적어줘야하는데, 우리가 만든건 header 니까 `UICollectionView.elementKindSectionHeader` 컬렉션뷰의 헤더이다 라고 적어주는것

```
collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "viewKey")
```


8. 이제 만든 헤더 뷰를 컬렉션뷰에 등록했으니, 등록한 뷰를 넣어서 사용할수있게, 셀처럼 비슷한 과정으로 설정해줘야한다.

```
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    	
    	//여기서 kind는 만약 헤더의 경우일수도, 풋터의 경우일수도있는데. 우리는 헤더만 쓰니까 헤더일 경우만 설정해준것

        if kind == UICollectionView.elementKindSectionHeader {
        	//만약 헤더일경우 라는뜻 

            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "viewKey", for: indexPath) as? ContentCollectionViewHeader else { fatalError() }

            //재사용 가능한 셀 과 거의 같은과정으로 재사용 가능한 뷰를 다운캐스팅 해주면서 우리가 등록한 셀을 사용하는 과정. 헤더의 경우 id가 viewKey인
            //뷰를 넣고 우리가 만들어둔 헤더 뷰 클래스로 다운캐스팅 하여 과정을 끝낸다.
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName

            //그리고 뭐 이제 그 헤더뷰에 들어갈 데이터는 알아서 설정해주고.

            return headerView
            // 헤더뷰 반환 해주고

        } else { return UICollectionReusableView() }
    }
```

9. 여기까지 하면 셀과 헤더의 데이터 설정이 끝난것이다. 이제 이 셀과 헤더가 모인 섹션들의 레이아웃을 설정해줘야한다. 어떤모습으로 보여줄것인지
- 하지만 레이아웃설정시에는 그전의 레이아웃 설정에서 addsubView 후에 그 subject의 위치를 조정했던것과 다르게, 진짜 가이드 라인만 만드는것이다. 
- `UICollectionViewCompositionalLayout` 은 하위 구성요소를 알지못한다는것.

### 섹션의 레이아웃 정하기
- 먼저 셀에 들어갈 아이템의 크기정하고 -> 그 아이템들이 들어갈 그룹의 크기를 정하고, 그룹안에 아이템 넣어주고 -> 그룹이 들어갈 섹션의 속성을 정의, 섹션안에 그룹 넣어주고 -> 만약 header, footer 가 있다면 섹션에 추가해준다. 

- 아래는 함수형태

```
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        //위의 함수는 아래에 적어놨다

        section.boundarySupplementaryItems = [sectionHeader]
        //header,footer 여러개가 들어갈수있으니 array 형태로 넣어주는듯
        //섹션에 속성을 추가해주고 그 섹션을 반환

        return section
    }
```

### 섹션에 들어갈 header layoout 정하기
- 헤더의 사이즈를 정해주고 -> 헤더의 속성들을 정의해준다(사이즈는 얼마인지, header인지 footer인지, 정렬은 어떻게 할것인지 등등) -> 그러면 헤더는 끝(맞나?)

```
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // 섹션 헤더의 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))

        //헤더의 레이아웃
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        return sectionHeader
    }
```







































