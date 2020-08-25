# 10. MVVM 디자인 패턴

- 목표를 잘 달성하기 위한 공부 패턴들의 모음
- 코딩을 잘 짜기 위한 패턴
- 목표: 기술부채 최소화, 재사용 및 지속 가능한 코드 만들기
- 코드 구조에 대한 전략
- 클린 아키텍쳐, 디자인 패턴

<br>

## Design Pattern

### MVC

<p align="center">

<image src="Resource/mvc.png" >

</p>

- MVVM 패턴이 나오기 전까지 MVC (Model- View - Controller) 패턴 오래 쓰임
- **Model** -> 앱 내에서 사용하는 데이터 (Struct, Class)
- **View** -> 화면에 보여지는 UI요소 (UIView)
- **Controller** -> Model과 View 사이 중재자 역할
- Massive View Controller -> View Controller 가 하는 역할이 너무 많음, 기술부채 발생

<br>
<br>

### MVVM 

<p align="center">

<image src="Resource/mvvm.png" >

</p>

- (Model - View - ViewModel)
- **Model** -> 앱 내에서 사용하는 데이터 (Struct)
- **View** -> 화면에 보여지는 UI요소 (UIView, UIViewController)
- **ViewModel** -> Model의 내용을 View에서 사용할 수 있게 전환 (ViewModel Class)

<br>
<br>

### MVC vs. MVVM

- ViewController가 Model에 직접 접근 못하고 ViewModel이라는 Class를 새로 갖음
- ViewController가 MVC패턴에서는 Controller 레이어에 있었는데 MVVM패턴에서는 View 레이어에 있음
- MVVM 개선점 : View Controller의 역할을 축소함
- 많은 일을 ViewModel로 위임했기 때문에 Class의 할일이 명확해짐

<br>
<br>

### MVVM 실제 구현

<p align="center">

<image src="Resource/mvvm2.jpeg" >

</p>

- View Controller는 View와 View Model을 가지고 있음
- View Model이 중개자 역할, View와 View Controller사이 communication
- View Model은 Model을 가지고 있음
- MVC 패턴에서 직접 Model에 접근 가능했던 것을 View Model이 막고있음
- Model은 ViewModel과만 소통

<br>
<br>

### MVVM 실전

- 디자인 패턴을 통해서 코드 수정
- **리팩터링** -> 기술부채를 줄이고 재사용 가능하면서 유지보수 비용을 줄이기 위해 코드를 수정하는 과정
- 중요한 원칙 - 중복 제거, 단일 책임 갖기
- **10, 200 rule** -> 메서드는 10줄 안에 클래스는 200줄 안에 짠다.
- **30, 400 rule** -> 이정도 지키려고 노력하기

<br>
<br>

## MVVM으로 리팩터링하기

### 1. 계획 세우기
- BountyViewController
```
    // MVVM
    
    // Model
    //  - BountyInfo
    
    // View
    //  - ListCell, 
    //  > 테이블 뷰 통해서 각각의 정보를 보여줌
    //  > ListCell 필요한 정보를 ViewModel한테서 받음
    //  > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기
    
    // ViewModel
    //  - BountyViewModel
    //  > BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    //  > Model 가지고 있기, BountyInfo 들
```


- DetailViewController

```
    // MVVM
    
    // Model
    //  - BountyInfo
    
    // View
    //  - imgView, nameLabel, bountylabel
    //  > view들은 viewModel을 통해서 구성
    
    // ViewModel
    //  - DetailViewModel
    //  > 뷰레이어에서 필요한 메서드 만들기
    //  > Model 가지고 있기, BountyInfo 들
```

- 리팩터링 후에 사용자에게 제공하는 서비스가 그대로 제공되어야함

<br>
<br>

### 2. Model

- BountyViewController
```Swift
struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int){
        self.name = name
        self.bounty = bounty
    }
}
```

<br>
<br>

### 3. ViewModel

- BountyViewController
```Swift
class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [                // Model을 가지고 있음
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    var numOfBountyInfoList: Int {                      // viewModel통해서만 접근 가능
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return bountyInfoList[index]
    }
}

```

<br>

- DetailViewController

```Swift
class DetailViewModel {
    var bountyInfo: BountyInfo?                         // Model을 가지고 있음
    func update(model: BountyInfo?) {                   // viewModel통해서만 접근 가능
        bountyInfo = model
    }
}
```

<br>
<br>

### 4. View

- BountyViewController
```Swift
class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}
```
