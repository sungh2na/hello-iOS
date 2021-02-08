## iOS 관련
- iOS Application의 생명주기
    - Not Running: 아무것도 실행하지 않은 상태
    - InActive: 앱이 Foreground 상태로 돌아가지만, 이벤트는 받지 않는 상태, 앱의 상태 전환 과정에서 잠깐 머무는 단계
    - Active: 일반적으로 앱이 돌아가는 상태
    - Background: 앱이 Suspended(유예 상태) 상태로 진입하기 전 거치는 상태,
    - Suspended: 앱이 Background 상태에 있지만, 아무 코드도 실행하지 않는 상태, 시스템이 임의로 Background 상태의 앱을 Suspended 상태로 만듦

- 뷰컨트롤러 생명주기
    - Init
    - loadView
    - ViewDidLoad -> 뷰컨트롤러가 로드될 때 한번만 실행, 초기화
    - ViewWillAppear -> 뷰컨트롤러가 화면에 나타나기 직전 수행
    - ViewDidAppear -> 뷰컨트롤러가 화면에 나타난 직후 수행, 애니메이션 등
    - ViewDidDisappear -> 뷰가 완전히 사라지고 나서 수행
    - ViewDidUnload

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

- A와 B의 비율이 3:2로 표현해야할 경우 오토레이아웃을 어떻게 설정해야 하는가 ?
    - width의 비율이 3:2 라면 A와 B를 선택해서 Equal width 해주고 multipier 2/3로 설정

- Layer에서의 AnchorPoint란 ?

- UIView와 CALayer의 차이점
    - UIview는 CAlayer 감싸고 user interaction을 담당 CAlayer 드로잉, 화면에 표시되는 것을 그림

- View 계층구조에서 같은 계층에 있는 뷰들끼리 앞 뒤 조절을 하기 위해서 어떻게 하겠는가 ?
    - View.layer.zindex 설정

## 스위프트 관련 
- 클래스와 스트럭트의 차이
    - 클래스는 reference타입 참조해서 할당
    - 스트럭트는 value타입  값을 복사해서 할당
    - 클래스만 상속, 레퍼런스 카운팅, 디이니셜라이저, 타입캐스팅 가능

- compactMap, map 차이
    - map은 컨테이너의 요소에 매개변수로 받은 클로저 연산을 해서 다른 컨테이너로 반환, 데이터 타입 변환할 때 주로 쓰임
    - 옵셔널 컨테이너에서 map을 쓰면 옵셔널로 반환하고 compactMap 쓰면 옵셔널 내부의 값 추출하고 nil 없이 반환

- Lazy Property
    - 호출될때 값을 할당함.
    - 클래스의 저장 프로퍼티에 다른 클래스 인스턴스 넣을 때 사용

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
    - Array 같은 타입의 데이터를 순서대로 넣은 컬렉션
    - Set 같은 타입의 데이터의 묶음, 유일한 값이어야 함, hashable
    - Dictionary 키와 쌍으로 된 데이터를 순서 없이 저장, 키는 hashable

## 아키텍쳐
- MVC, MVVM MVC 사용자가 Controller를 조작하면 Controller는 Model을 통해서 데이터를 가져오고 
그 정보를 바탕으로 시각적인 표현을 담당하는 View를 제어해서 사용자에게 전달

- 상속과 POP의 차이점

## RxSwift
- RxSwift란 ?

- 앱 배포
  - 인증서, 프로비저닝 프로파일에 대하여 설명(코드사이닝 : "애플(Apple)만이 자신들의 하드웨어(iOS)에 어떤 소프트웨어(앱)가 동작하도록 할 수 있다.”