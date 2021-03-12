# 첫 앱 만들기

## 앱개발 준비단계
- 목표 및 할일 정리
    - 복잡한 기능을 작은 단위로 쪼개서 만들기
- 버튼과 액션
- 문제 해결
- 앱 동장 방식 이해
- ...

<image src="액자앱.png" >

- 뷰 구성 측면
    - 타이틀 텍스트
    - 이미지
    - 가격 텍스트
    - 리프레시 버튼
- 기능 구성 측면
    - 리프레시 버튼 클릭시, 금액이 변경

## Xcode로 프로젝트 생성하기
- Single View App
- product Name: MyAlbum
- Lanuage: Swift
- User Interface: Storyboard
    - SwiftUI는 iOS 13부터 적용

- 버튼 추가 해보기

## ViewController 개념
- 스크린 하나를 관리함
- 액자앱은 스크린이 하나니까 뷰컨트롤러도 하나
- 디자인파트와 코드 파트로 구성됨

## 첫 앱 만들기

- Xcode에서 ViewController 확인
- 버튼 눌렀을 때 hello 라고 출력하는 코드 작성해보기 
    - Connection - Action, Touch Up Inside

```Swift
@IBAction func hello(_ sender: Any) {
    print("hello")
}
```

- 콘솔창 말고 앱 내에 팝업으로 뜨도록 해보기 

```Swift
@IBAction func hello(_ sender: Any) {
    let alert = UIAlertController(title: "Hello", message: "My First App!!", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}
```

- Xcode에서 문제가 발생했을 때 해결 법
    - 자동완성 활용하기 -> 오타 줄일 수 있음
    - 대소문자 구분
    - 코드 바운더리 나가는 것 조심
    - 코드 커넥션 확인 -> 이름 바꿨으면 다시 연결해줘야 함
    - 워닝도 잠재적으로 버그를 발생시킬 수 있으니 해결하는게 좋음 -> let 대신 var 를 쓴 경우
- 도전과제
    - 스토리보드에서 할일
        - 새로운 버튼 추가하기
        - 뷰컨트롤러에 버튼 액션 연결하기
    - 코드에서 할일
        - 메소드 새로 추가하기 
- UIKit
    - View Component는 UIKit이라는 프레임워크 안에 들어있음
    - UI Component만들 때 필요한 것을 찾아 쓸 수 있는 공구함
    - Object Library에서 찾을 수 있음
- 뷰 구성할 때 필요한 지식
    - 뷰의 위치
        - 기준은 좌측 상단

        <image src="뷰의 위치.png" >

## 앱 동작 방식의 이해
- 앱은 여러개의 object로 이루어짐, UI버튼, UIlabel, 뷰컨트롤러
- iOS에서 제공해주는 것과 필요에따라 만들어 쓰는 것이 있음
- object들은 서로 메세지를 보내면서 커뮤니케이션
- 사용자가 버튼을 클릭했을 때 버튼은 뷰컨트롤러에게 클릭 되었음을 알림
뷰 컨트롤러는 Show alert 메서드 수행하고 UI alert controller 에게 메세지 보냄
- iOS 앱 자체는 이벤트 발생에 따라서 작동, 버튼 누르는 이벤트 등
- 앱은 이벤트를 계속 기다리고 있다는 뜻
- 요약
    - 앱은 오브젝트로 구성
    - 오브젝트 끼리 서로 메시지 보냄
    - 앱은 이벤트에 의해 프로세스 동작함

## Swift
- Object, Data, Method
- String and Variable
- Connecting Outlet
- Writing Method
- Local vs. Instance Variable
- Closure

1. Object, Data, Method
    - App은 Object로 구성됨
    - Object? 어떤 특정한 일을 하는 것
    - UIAlertController의 직무 - 앱을 사용하는 중간에 특정 목적 메시지를 표시 하는 것
    - View Controller는 화면을 구성하는 요소
    - Object의 요소는 
        - Method - Object에 속해서 기능을 수행하는 역할을 하는 것
        - Data
        - Object = Data + Method로 구성되고, Object가 의미있는 기능을 할 수 있게 데이터를 활용하는데 이 데이터를 보관하는 것이 변수
    - 쉽게 오브젝트 이해해보기 - 파티
        - 파티 호스트(Object): 파티 준비(Method), 파티 초대 목록을 가지고 있음(Data)
        - 파티 참석자(Object): 파티장 주소를 알 고 있음(Data), 주소지에 찾아 가는 것, 파티장에서 노는 것(Method)
2. String and Variable
    - String? 문자열의 나열
    - String Interpolation -> 문자열에 변수를 포함시켜 출력이 가능하게 해주는 것을 말함
    ```Swift
    var currentValue = 0
    let message = "가격은 \(currentValue)입니다."
    ```
        - currentValue는 Int형 변수이고, message는 String형 변수
        - message내부에 currentValue라는 Int형 변수의 값을 문자열의 형태로 포함시키는 역할을 String interpolation이라고 함

    - Variable? 어떤 값을 저장할 수 있는 공간
    - 컴퓨터 프로그래밍에서 변수 또는 스칼라는 아직 알려지지 않거나 어느정도까지만 알려져 있는 양이나 정보에 대한 상징적인 이름이다.
    - 컴퓨터 소스 코드에서의 변수 이름은 일반적으로 데이터 저장 위치와 그 안의 내용물과 관련되어 있으며 이러한 것들을 프로그램 실행 도중에 변경될 수 있다.
    - Object들은 여러 변수를 가지고 있음, 그리고 변수도 여러 타입을 가지고 있음 (정수형, 문자형 등)

3. 아웃렛 연결하기
    - Outlet? Storyboard상의 Object에 대한 Reference
    - 가격 label에 대한 Outlet을 연결하는 것을 통해 코드내부에 Storyboard상에 있는 Object(가격 레이블)의 값을 수정할 수 있음
    - 어떤 특정 Object의 Outlet을 연결하는 것을 통해 Object의 내용을 바꾸거나 값을 수정하는 등 동적으로 여러가지 작업들을 처리할 수 있음

    ```Swift
    @IBAction func showAlert(_ sender: Any) { 
        let message = "가격은 \(currentValue)입니다. " 
        let alert = UIAlertController(title: "hello", message: message , preferredStyle: .alert ) 
        let action = UIAlertAction(title: "OK", style: .default, handler: nil) alert.addAction(action) 
        let randomPrice = arc4random_uniform(10000) + 1 
        currentValue = Int(randomPrice) 
        alert.message = "￦\(currentValue)" 
        
        present(alert, animated: true, completion: nil ) 
        valueOutlet.text = "￦\(currentValue)" 
    }
    ```

4. 변수와 상수 이해하기
    - var -> variable, 변수가 초기화 된 이후에도 값을 변경할 수 있음, 변수
    - let -> 상수형 변수를 선언할 때 사용, 변수가 한번 초기화 된 이후에는 값을 변경할 수 없음, 상수

    - 앱의 안정성을 위해 상수를 많이 사용
    - 값을 수정해야할 필요가 있을 경우에만 var로 바꿔서 사용
    
