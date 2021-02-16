## iOS 관련
- iOS Application의 생명주기
    - Not Running: 아무것도 실행하지 않은 상태
    - InActive: 앱이 Foreground 상태로 돌아가지만, 이벤트는 받지 않는 상태, 앱의 상태 전환 과정에서 잠깐 머무는 단계
    - Active: 일반적으로 앱이 돌아가는 상태
    - Background: 앱이 Suspended(유예 상태) 상태로 진입하기 전 거치는 상태,
    - Suspended: 앱이 Background 상태에 있지만, 아무 코드도 실행하지 않는 상태, 시스템이 임의로 Background 상태의 앱을 Suspended 상태로 만듦

- 뷰컨트롤러 생명주기
    - init
    - Loadview
    - ViewDidLoad -> 뷰 컨트롤러가 메모리에 로드됐을 때 처음 한번만 실행, 초기화
    - ViewWillAppear -> 뷰 컨트롤러가 화면에 나타나기 직전 항상 실행
    - ViewDidAppear -> 뷰 컨트롤러가 화면에 나타난 직후 애니메이션 등
    - ViewWillDisappear -> 뷰 컨트롤러가 화면에서 사라지기 직전 호출
    - ViewDidDisappear -> 뷰 컨트롤러가 완전히 사라지고 나서 호출
    - ViewDidUnload
    -> 앱 실행중에는 ViewWillAppear 부터 ViewDidDisappear까지 순환

- 오토레이아웃이 적용되는시점
    - ViewWillAppear와 ViewDidAppear 사이에 viewWillLaydoutSubview() 메서드를 호출한다.
뷰 컨트롤러의 컨텐트 뷰가 layoutSubviews() 메서드 호출하고 레이아웃 정보의 변경사항을 반영한다.

- 제스처 종류
    - Tap - 누르기, 컨트롤 혹은 아이템을 누르거나 선택
    - Drag  - 끌기, 스크롤 혹은 이동
    - Flick - 튕기기, 빠른 스크롤 혹은 빠른 이동
    - Swipe  - 쓸기, 테이블 뷰에서 삭제버튼이 나타나게 하거나, 화면상단의 노티피케이션 센터를 나타나게 함. 네 손가락으로 멀티터치 swipe의 경우 아이패드에서 최근 App 실행목록에서 App을 전후로 스위칭을 함.
    - Double Tap - 두번 누르기, 확대한 후 컨텐츠나 이미지의 중앙을 맞춤. 이미 확대되어 있으면 축소
    - Pinch open - 두 손가락 벌리기, 확대
    - Pinch close - 두 손가락 오므리기, 축소
    - Touch and hold - 터치 후 유지, 편집 가능한 텍스트에서 커서가 가리키는 곳에 돋보기를 보여줌
    - shake - 흔들기, 앞으로 뒤로가기 액션이 가능함


- 두 개의 UILabel이 가로로 정렬돼있을 때 한개의 레이블의 컨텐츠를 무조건 표시해야하는 경우 어떻게 해야하는가 ?
    - Hugging priority, compression resistance priority 설정
    - - 뷰가 커졌을 때 hugging priority가 더 높은 것은 설정한 크기를 유지하고 낮은 것의 크기를 늘려서 뷰를 채움
    - 뷰가 작아졌을 때 compression priority 가 더 높은 것은 설정한 크기를 유지하고 낮은 것의 크기를 줄임

- A와 B의 비율이 3:2로 표현해야할 경우 오토레이아웃을 어떻게 설정해야 하는가 ?
    - width의 비율이 3:2 라면 A와 B를 선택해서 Equal width 해주고 multipier 2/3로 설정

- Layer에서의 AnchorPoint란 ?

- UIView와 CALayer의 차이점
    - UIview는 CAlayer 감싸고 user interaction을 담당 CAlayer 드로잉, 화면에 표시되는 것을 그림

- View 계층구조에서 같은 계층에 있는 뷰들끼리 앞 뒤 조절을 하기 위해서 어떻게 하겠는가 ?
    - View.layer.zindex 설정

+ NotificationCenter
    - register된 observer들에게 정보를 broadcast 할 수 있게 해주는 dispatch mechanism이다.
    - addObserver(_:selector:name:object:) 등 을 통해 Observer를 추가하고, 관찰을 시작한다.
    - event가 발생하면 Object는 Notification center에게 notifiction을 post(송신) 한다.
    - Notification center는 모든 registered Observer들에게 해당 내용을 Broadcast 한다.
    - Observer들은 발생한 event에 대한 처리를 한다.

## 스위프트 관련 
- 클래스와 스트럭트의 차이
    - 클래스는 reference타입 참조해서 할당
    - 스트럭트는 value타입  값을 복사해서 할당
    - 클래스만 상속, 레퍼런스 카운팅, 디이니셜라이저, 타입캐스팅 가능

- compactMap, map 차이
    - map은 컨테이너 각 요소에 매개변수로 받은 클로져 연산을 적용한 후 다른 컨테이너로 반환해주는 함수,
        다른 데이터 타입으로 변경할 때 주로 쓰임.
    - 옵셔널 컨테이너에서 map을 쓰면 옵셔널로 반환하고 compactMap 쓰면 옵셔널 내부의 값 추출하고 nil 없이 반환
    
    + flatmap은 중첩된 배열의 경우 단일 배열로 만들어줌.
    + filter 컨테이너 내부의 값을 걸러서 추출하여 새로운 컨테이너에 반환
    + reduce 컨테이너 내부의 콘텐츠를 하나로 합하는 기능을 가진 고차함수, 전달인자로 전달받은 클로저의 연산 결과로 합해줌.

- Lazy Property
    - 호출될때 값을 할당함.
    - 클래스의 저장 프로퍼티에 다른 클래스 인스턴스 넣을 때 사용
    - 지연 속성은 인스턴스의 초기화가 끝난 후에도 외부 인자에 의존하는 속성의 값을 알지 못할 때 유용함. 지연 속성은 또한 속성의 초기 값이 복잡하거나 필요할 때 까지 수행하지 않아도 되는 경우에 유용함.

- Access Level
    - Open 정의 모듈의 모든 소스파일 내에서 사용 가능, 외부 모듈에서 사용 가능, 상속 오버라이딩 가능
    - Public 정의 모듈의 모든 소스파일 내에서 사용 가능, 외부 모듈에서 사용 가능, 상속 오버라이딩 불가능
    - Internal 기본 설정, 정의 모듈의 모든 소스파일 내에서 사용가능, 다른 모듈에서 사용 불가능
    - File private 같은 파일 내에서만 사용가능
    - Private 클래스 내부에서만 사용 가능

- 클로져
    - 일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것
    - 익명함수, 함수매개변수나 반환값으로 사용가능

- nonescaping , escaping
    - 함수의 전달인자로 전달한 클로저가 종료후에도 호출될 때 @escaping 키워드를 사용하여 클로저를 탈출한다고 명시
    - 함수 종료후에 사용되지 않으면 nonescaping

- Array vs Set vs Dictionary
    - Array
        - 같은 타입의 데이터를 순서대로 넣은 컬렉션
        - 연결리스트 형태로 되어있음
        - 중복된 값이 들어갈 수 있음
        - 버퍼로 구현되어 있기 때문에 크기를 자유롭게 변경할 수 있음 (선언 시 배열의 크기지정 필요 x)
        - 원소에 순차적으로 접근해야 할 때 사용
    - Set
        - 같은 타입의 원소를 순서없이 하나의 묶음으로 저장하는 컬렉션
        - 중복된 값이 들어갈 수 없음
        - 집합의 원소는 hashable 프로토콜 준수함(그 자체로 유일하게 표현이 가능한 방법을 제공해야 함)
        - 원소의 순서가 중요하지 않을 때, 각 원소가 유일한 값이어야 할 때 사용
    - Dictionary 
        - 원소들이 순서 없이, 키와 쌍으로 구성되는 컬렉션 타입
        - 딕셔너리 안의 키는 유일하며, 값은 중복될 수 있음
        - 딕셔너리의 키 역시 Hashable 프로토콜을 준수함(딕셔너리의 키는 값을 대변하는 식별자가 됨)
        - 배열과 달리 딕셔너리에 없는 키에 접근해도 오류가 발생하지 않음 (단, nil 반환)
        - 식별 가능한 값과 특정 값의 쌍이 필요할 때 등 사용

- 프롵토콜
    - 특정 기능을 실행하기 위해 필요한 요구사항을 정의한 것 

- Hashable
    - integer hash value를 생성하는 hasher로 hash될 수 있는 타입
    - hashable 프로토콜을 상속 받은 hash 될 수 있는 타입
    ```Swift
    protocol Hashable: Equatable {
        var hashValue: Int { get }
        func hash(into hasher: inout Hasher)
    }
    ```
    - hash 값을 찾을 수 있는 key 인 hashValue
    ```Swift
    protocol Equatable {
        static func == (lhs: Self, rhs: Self) -> Bool
    }
    ```
    - hashValue는 고유값이어야 하기 때문에 Equatable 프로토콜 상속 받음
    - hashable 구현해주기 위해서는 
        1. Equatable에 있는 == 함수 구현
        2. HashValue를 만듦

- 위임을 위한 프로토콜 (Delegation)
    - 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 디자인 패턴
    - 책무를 위임하기 위해 정의한 프로토콜을 준수하는 타입은 자신에게 위임될 일정 책무를 할 수 있다는 것을 보장
    - 위임은 사용자 특정 행동에 반응하기 위해 사용되기도 하며, 비동기 처리에도 많이 사용됨
    - 위임패턴은 애플의 프레임워크에서 사용하는 주요한 패턴 중 하나
    - 예를들어 UITableView타입의 인스턴스가 해야하는 일을 위임받아 처리하는 인스턴스는 UITableViewDelegate 프로토콜 준수하면 됨
    - 위임받은 인스턴스, 즉 UITableViewDelegate프로토콜을 준수하는 인스턴스는 UITableView의 인스턴스가 해야하는 일을 대신 처리해줄 수 있음

- delegate 패턴
    - 델리게이트는 어떤 객체가 해야 하는 일을 부분적으로 확장해서 대신 처리
    - 대신 처리해줄 객체와 대친 처리하라고 시키는 객체

## 아키텍쳐
- MVC
    - Model -> 앱 내애서 사용하는 데이터와 데이터 처리부 (Struct, class)
    - View -> 사용자 인터페이스, 화면에 보여지는 UI요소 (UIView)
    - Controller -> Model과 View 사이 중재자 역할, 사용자 입력처리 및 모델변화를 감지하여 화면 갱신

- MVVM
    - Model -> 앱 내애서 사용하는 데이터 (Struct)
    - View -> 화면에 보여지는 UI요소 (UIView, UIViewController)
    - ViewModel -> Model의 내용을 View에서 사용할 수 있게 데이터 처리 (ViewModel Class)
    - 특징 Command 패턴과 Data Binding을 사용하여 View와 ViewModel사이의 의존성을 제거함
    - View를 통해 입력이 들어오면 커맨드 패턴을 통해서 ViewModel에 명령을 내리게 되고, 데이터 바인딩을 통해
    viewModel의 값이 변화하면 View의 정보가 바뀌게 됨.


- 상속과 POP의 차이점
    - 상속에서는 오직 하나의 슈퍼클래스만 가질 수 있다. 레퍼런스 타입, 수직적인 구조
프로토콜은 다수의 프로토콜을 따르는 것이 가능한 수평적인 확장 구조 structure, enum등 value 타입에도 적용 가능하다.

## RxSwift
- RxSwift란 ?
    - 이벤트가 발생하였을 때 그것을 관찰하고 비동기식으로 프로그램을 만들 수 있게 도와주는 라이브러리
- 앱 배포
  - 인증서, 프로비저닝 프로파일에 대하여 설명(코드사이닝 : "애플(Apple)만이 자신들의 하드웨어(iOS)에 어떤 소프트웨어(앱)가 동작하도록 할 수 있다.”

    - 개발자는 애플로부터 iOS 기기에 앱을 설치할 수 있는 권한을 얻으려면 애플에서 인증을 받아야 하는데 애플은 인증서를 통해 개발자를 식별함
    - 프로비저닝 프로파일은 app id, certificate, device정보를 가지고 있어, ios기기 애플 인증서를 연결해주는 역할
