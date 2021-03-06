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

- 앱 동작 방식의 이해 