# 16. Firebase
- 서버 자체를 서비스로 제공
- 데이터 저장, 실시간 데이터 동기화, 사용자 인증, 데이터 분석, A/B Testing
- 앱을 빠르게 만들 수 있음

## firebase 소개
- Build better apps
    - 더 잘만들게 (개발속도 향상)
    - cloud Firestore
    - ML Kit 을 이용한 머신러닝 백앤드 서비스
    - cloud Functions
    - 사용자 인증
    - 호스팅
    - cloud Storage
    - Realtime Database

- Improve app quality
    - 앱 퀄리티 향상을 위한 기능 제공
    - 앱 크래쉬 관찰, 문제 발견
    - 앱 성능 모니터링
    - 테스트

- Grow your app
    - 비즈니스적 성장을 도와줌
    - 이벤트 로깅을 통한 분석
    - 예측
    - Firebase A/B 테스팅
    - 클라우드 메시징
    - 원격 구성
    - 동적 링크
    - 앱 색인 생성
    - 초대

## firebase 사용사례 소개
- Audiences - 주로 사용하는 나라, 성별 등
- Funnels - A 행동에서 B횅동으로 얼마나 가는지
- StreamView - 실시간 사용자
- A/B Testing - 실험을 해서 어떤 것이 더 퍼포먼스가 좋은지 알 수 있음.
- Crashlytics - 앱의 안전성 확인

## 외부라이브러리 관리 모듈 CocoaPods 소개
- Firebase ios SDK
- SDK? Software Development Kit , 개발도구
- firebase 기능들을 앱에 접목하기 위한 개발도구
- cocoapods - 루비 기반의 외부 개발도구 관리 모듈

## CocoaPods 설치
- terminal
- sudo gem install cocoapods -n /usr/local/bin
- pod --version

## Firebase iOS SDK 설치
- firebase.google.com
- cocoapods 설치 
- pod init 을 통해서 pod 파일 만들기
- pod 파일 안에 pod 'Firebase/Analytics' 
- pod install
- 앱 시작할때 FirebaseApp.configure() -> 실제 Firebase와 통신하는 것 확인 가능

## Realtime Database에서 데이터 가져오기
- 서버에 데이터 저장하거나 가져오거나 할 때 서버 공부하지 않고도 가능하게 해줌
- Firebase - 빌드 - Realtime Database - 데이터베이스 만들기 - 테스트모드
- https://firebase.google.com/docs/database/ios/start
- Podfile에 pod 'Firebase/Database' 입력하고 pod install
```Swift
import UIKit
import Firebase

class ViewController: UIViewController {
    
    var db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
```
- 빌드 실패하면 
    - Product - Clean Build Folder
- firebase 에서 데이터 추가
    - firstData - Hello Firebase!!!
- firstData 값 가져오기    
    ```Swift
    db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("---> \(snapshot)")
        }
    ```
    * 오류 * `[FIRApp configure];` (`FirebaseApp.configure()` in Swift) could not find a valid GoogleService-Info.plist in your project.
        -> GoogleService-Info.plist 삭제후 다시 추가해줌
    - snapshot에 값이 들어가게 됨
- 값 저장하기
    ```Swift
    let value = snapshot.value as? String ?? ""
    ```
