# TableView

## 넌뭐냐?
* 무한으로 셀을 만들어낼수있는 셀만드는 자동화기계
* 데이터만 무궁무진하다면 끝없는 새로운 셀을만들수있다.
* delegate 를 이용했는데 생각보다 직관적으로 된거같음


### 연습

* 제일먼저 내가 보여줄 데이터들을 정한다.(Struct든 enum이든 class, 그냥 int,string 암거나)
1. 일단 테이블뷰를 띄울 뷰 컨트롤러에 2가지 프로토콜을 채택해준다
2. 해당 클래스 내에 테이블 뷰를 선언해준다
3. 테이블뷰의 속성과 위치를 잡아주고 메인 뷰에 추가해준다
4. 테이블뷰의 datasource 와 delegate 가 현재 뷰컨트롤러라고 선언해준다
5. 프로토콜 2개를 채택했는데 그중 `UITableViewDataSource` 은 반드시 작성해야 하는 2가지 함수가있다 오류창 눌러보면 저절로 만들어준다.
6. 이제 이 함수를 작성해야하는데 `numberOfRowsInSection`이 있는 함수는 이 테이블 뷰에 몇개의 열을 표시할건지 알려준다. 내가 가진 데이터의 총 갯수로 하는게 좋겠지. 그데이터의 갯수로 적어주자
7. 테이블 뷰를 어떻게 보여줄것인가, 테이블뷰의 셀을어떻게보여줄건가, 이제 여기부터 혼란스럽다 이건또 스토리 보드로 하는게 나은데. 일단 커스텀 셀 만들기는 스토리보드로 하는게 편하다
8. 따로 만들어둔 tableViewcell 파일의 nib 파일을 테이블뷰에 등록해준다( key 는 같게)
9. 그러면 뭐 대충 잘 작동한다

근데 이 중구난방 코드를 mvvm 패턴을 이용하면 깔끔하게 할수있다는데 나중에 다시 해보자.

```swift


import UIKit
import SnapKit

struct View {
    let name : String
    let id : Int
}



class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//1 단계

    let list = [
        View(name: "View", id: 1),
        View(name: "Label", id: 2),
        View(name: "Button", id: 3),
        View(name: "TextField", id: 4),
        View(name: "TableView", id: 5),
        View(name: "ScrollView", id: 6)
    ]
//이부분이 0 단계

let firstTableView = UITableView()
//2단계

override func viewDidLoad() {
        super.viewDidLoad()

self.view.addSubview(firstTableView)
        firstTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
//3단계

    firstTableView.register(UINib(nibName: TableCiewCell, bundle: nil), forCellReuseIdentifier: "key")
    //여긴 8단계, nibName 스토리보드로만든 테이블뷰셀 파일의 이름으로
    
firstTableView.delegate = self
firstTableView.dataSource = self
//4단계
}


//5단계 아래 두 함수가 생겨나는 두가지
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        //여기가 6단계
    }
    
    //아래건 간단한 기본 셀 
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "key", for: indexPath)
         var content = cell.defaultContentConfiguration()
         //defaultContentConfiguration() 은 프로토콜이다
         //content 가 이제 셀의 기본 컨텐츠 컨피규레이션이고 content 에다가 셀의 속성을 정의해주면된다. 이미지, 문자열, 액세서리 뷰 3가지로 이루어진 형식
         content.text
         content.secondaryText
         content.image
         cell.contentConfiguration = content
         //마지막에 셀의 컨텐츠 컨피규레이션이 컨텐츠라고 해줘야함

        //여기서 셀에 접근해서 그 셀의 속성들을 조정해줄수있다.
        //만약 내가 직접 만든 셀을 사용하고싶다면 TableViewCell class로 파일을 nib 파일과 같이만들고 그 파일에 여러 메소드들을 집어넣어준다. 그렇게 그 메소드에 접근하고 셀에 표시할 정보들을 바꿔주면됨
        return cell
    }
}
//여기가 7단계

//아래는 내가만든 커스텀셀
//커스텀셀 사용할때는 꼭 다운캐스팅을 해줘야한다. 아직 UITableView로 되어있어서 내가만든 TableViewCell 로 안착시켜 줘야 그 셀을 이용가능,이거안하면 그냥 없던일이 되버린다.
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "key", for: indexPath) as? TableViewCell else { return UITableViewCell()}
    cell.setValue(list[indexPath.row])
        return cell
    }
}


//아래는 커스텀 tableviewcell 이다
//새로 파일을 만들때 cocoatouchclass 파일에서 TableViewCell로 만들고 xib파일도 같이 생성해줘야 스토리보드로 할수있음
//만들고 나서 xib 파일의 주인을 꼭 내가 만든 파일로 해줘야 둘이 연결이된다, 그리고 기타 다른 구성요소를 넣고나서 코드로 끌어올때 반드시 object 를 tableviewcell로 해줘야 한다.
//스토리보드로 오토레이아웃이랑 기본 셀 attribute은 설정했는데 테이블뷰 셀을 만들때는 이게 간단하고 편한거같음.
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    
    func setValue(_ data: View) {
        frontLabel.text = String(data.id)
        middleLabel.text = data.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
```