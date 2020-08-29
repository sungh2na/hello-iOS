# 11. 원피스 현상금 랭킹앱을 더 풍부하게

## CollentionView 개념
- 한 행 안에 여러개의 아이템을 보여주는 형식
- TableView는 한 행에 한 아이템만 넣을 수 있음
- 각 데이터의 나열을 수평방향, 수직방향 결정가능
- 각 데이터들은 collectionViewCell로 표현 가능
- UITableView에 비해 자유로움
- 자유로운 레이아웃 때문에 전문적으로 관리하는 객체가 필요함 -> UICollectionViewLayout 상속
- 기본적으로 애플에서 제공해주는 겍체 -> UICollectionViewFlowLayout
- Datasource&Delegate 프로토콜 이용해서 CollectionView 이옹하는데 필요한 코드 작성


## Animation 개념

- 시간에 따라, 뷰의 상태가 바뀌는 것
- = 시작, 끝, 시간
- Animation API

```Swift
UIView.animation(
    withDuration: 1.0,      // 에니메이션 진행되는 시간
    anmations: {            // 에니메이팅 시킬 것 넣어줌
        layoutIfNeeded()
    }
)
```

## Animation 실습

- **nameLabelCenterX**
- nameLabel의 센터 constraint를 bountyLabel outlet에 연결
- **bountyLabelCenterX**
- bountyLabel의 센터 constraint 연결


```Swift
    override func viewDidLoad() {                       // 뷰 로드
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {     // 뷰가 보여진 시점
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation() {                   // 시작 
        nameLabelCenterX.constant = view.bounds.width
        bountyLabelCenterX.constant = view.bounds.width
    }
    
    private func showAnimation() {                      // 끝
        nameLabelCenterX.constant = 0
        bountyLabelCenterX.constant = 0
        
        UIView.animate(withDuration: 0.3) {             // 시간
            self.view.layoutIfNeeded()
        }
    }
```

- 시작
    - **prepareAnimation()** 
    - 애니메이션 들어가기 직전 셋팅 값 설정 viwDidLoad()에서 실행
    - constant를 아주 큰 수로 설정하면 화면 밖으로 나가게됨 
    - 여기서는 화면사이즈인 view.bounds.width

- 끝
    - constant = 0 -> 센터에 위치, 원래대로

- 시간
    - 시간 0.3
    - 딜레이, 반동주기 등 설정가능
    - **layoutIfNeeded()** -> constant가 바뀌니까 다시 레이아웃 해줘야함

```Swift
    UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
```
- 이미지 뒤집기