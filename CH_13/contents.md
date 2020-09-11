# 12. Todo 리스트 앱

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

## 태스크 관리뷰, 컬렉션뷰 구현하기
- TodoManager -> Todo 객체를 관리해줌
- TodoViewModel -> TodoManager에 접근함, Controller에서는 TodoViewModel에 접근

## 컬렉션뷰 구현하기
- 뷰 객체가 다른 모델이나 로직을 건들이지 않게 하기 위해 클로저 사용
- 외부에서 필요한 로직 구현
```Swift
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
```