# 17. 넷플릭스st 확장앱

## 확장앱에서 배울 목록 소개
- 위아래 스크롤 안에 좌우 스크롤 되는 것 -> 네스티드 스크롤뷰
- 저장한 컨텐츠 목록 -> firebase 통해서 검색 히스토리 관리 

## 네스티드 스크롤뷰
- 테이블뷰와 컬렉션뷰도 스크롤뷰의 한 형태
- 스크롤뷰 안에 컨텐츠뷰가 있음
- 창문이 스크롤뷰, 창문을 통해 바라보는 풍경이 컨텐츠뷰에 대응
- 스크롤뷰 넣어서 뷰와 constraints 모두 설정해 줘도 빨간색 뜸
    - 안에 컨텐츠뷰 추가
        - 컨텐츠뷰 사이즈 정하기
        - 스크롤뷰 - Leading, top, trailing, bottom
        - 전체뷰 - equal widths, equal heights
        - Height -> Priority를 낮게 설정, 다른 외부 요인에 의해 늘어날 수 있음
    - Priority
        - Required (1000)
        - High (750)
        - Low (250)
    
## 스크롤뷰와 오토레이아웃 적용
- 이미지 뷰와 vertical stack view - view 넣어서 확인
- simulated Size - Freeform 설정하면 넘어가는 부분도 볼 수 있음

## containerView를 활용한 네스티드
- horizontal scroll view 만들기
- 스택뷰 안에 컨테이너뷰를 넣음 -> 컨테이너뷰 높이 지정
- 뷰컨트롤러 embeded 
- 뷰 안에 section Title, Collection View 넣어주고 오토레이아웃
- RecommendListViewController와 연결시켜줌.

## 네스티드 스크롤뷰 구현 마무리 및 정리
- UpComingViewController 만들어서 공개예정 뷰에 연결
- RecommendListViewController 세그웨이 연결
- 뷰 컨트롤러 안에 스크롤뷰, 그 안에 컨텐츠 뷰, 그 안에 이미지뷰와 스택뷰가 있고 스택뷰 안에 컨테이너뷰 두개
- 컨테이너뷰는 뷰 컨트롤러와 연결이 되어 있음 
- 뷰 컨트롤러에서 보여지는 것을 컨테이너뷰를 통해서 보여줌

## 파이어베이스 설정하기
- 백앤드에서 검색한 내용들을 서버에 다 올린 다음 가져와서 저장한 컨텐츠 목록 보여주기
- firebase의 realtime database 이용
- firebase 들어가서 프로젝트 만들기
- cocoapod 이용해서 firebase software development kit 다운
    - pod 'Firebase/Analytics'
    - pod 'Firebase/Database'
- swift package manager가 이미 깔려 있는 상태에서 cocoapod을 통해 또 외부 코드 가져올 때 문제 발생할 수 있음
    - swift package manager에 있는 것들을 다시 다운받으면 됨
    - Project - Swift Packages - Location - version ( exact -> Up to Next Major ) 다시 빌드
- realtime Database 만들기

## 검색어 서버에 저장하기
## 검색어 서버에 가져오기
## 검색 히스토리 표시하기
