# 13. Todo 리스트 앱

<image src="Resource/todolist1.png" >

## TodoList 앱 소개
    - Any.do st 앱
    - 테스크 관리(추가, 편집, 삭제)
    - 셋팅 관리
    - 테스크 페이지에서 데이터 저장하고 가져오는 방법
    - 인풋 텍스트 필드 이용해서 테스크 추가하는 방법
    - 키보드

### ios 앱에서 데이터 저장 방법
- **NSCoding** - 다뤄야 할 데이터가 적은 경우, Core Data 보다는 수월하지만 복잡
- **Property List** - 다뤄야 할 데이터가 적은 경우
- **Serialization**
- **Core Data** - 많고 복잡한 데이터 (수천개 이상), 구현 난이도, 관리 난이도 높음
- **Realm** - 많고 복잡한 데이터 (수천개 이상)

#### Codable (Swift 4)
- NSCoding 처럼 간단하고 적은 데이터로 관리하기 매우 적합한 기능
- JSON 형태를 쉽게 다룰 수 있게 해줌
- NSCoding 보다 덜 복잡하고 직관적임

<br>

## 탭바 컨트롤러 구성하기
- Editor - Embed In - Tab Bar Controller
- 설정 탭 추가 -> 테이블 뷰 컨트롤러 추가 - 탭바 컨트롤러와 연결 - view controllers
- 설정 아이콘 (gear)

## 스태틱 테이블뷰로 설정페이지 구현하기
- Table View - Content - Static Cells
- Table View Section에 헤더 넣을 수 있음

## 태스크 관리뷰, 뷰모델 구현
- TodoManager -> Todo 객체를 관리해줌
- TodoViewModel -> TodoManager에 접근함, Controller에서는 TodoViewModel에 접근

## 컬렉션뷰 구현하기
- 뷰 객체가 다른 모델이나 로직을 건들이지 않게 하기 위해 클로저 사용
- 외부에서 필요한 로직 구현
```Swift
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
```

## struct를 jason으로 인코딩 시켜서 disk에 저장

```Swift
func saveTodo() {
        Storage.store(todos, to: .documents, as: "todos.json")
    }
```
- 여러가지 형태로 데이터를 주고 받을 때 jason파일 주로 사용

```Swift
struct Todo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
}
```
- ***jason***은 중괄호 안에 키, 밸류 형태로 되어있음, 딕셔너리 형태
- 데이터를 파싱해서 (스위프트가 알아볼 수 있는 형태의 오브젝트로 만듦) 앱 내에서 사용
- ***Codable***이 jason의 파일을 스위프트가 알아 볼 수 있는 struct 형태로 바꿔줌
- struct가 codable 프로토콜을 따르면 아주 쉽게 jason 형태의 data로 만들 수 있고(Encodable)
반대로 jason형태의 데이터를 struct로 만들 수 있음(Decodable)
- 인코딩 된 jason 데이터를 **FileManager**가 스토리지에 저장해주고 반대로 불러와줌

<br>

```Swift
    override func viewDidLoad() {
        super.viewDidLoad()

        // *test* todo 객체 만들어서 스토리지에 쓰기
        let todo = TodoManager.shared.createTodo(detail: "👍🌈 Corona 난리", isToday: true)
        Storage.saveTodo(todo, fileName: "test.jason")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // *test* 확인
        let todo = Storage.restoreTodo("test.jason")
        print("---> restore from disk: \(todo)")
    }
```

```
// test.jason 파일
{
    "id" : 1,
    "detail" : "👍🌈 Corona 난리",
    "isDone" : false,
    "isToday" : true
}
```