# 18. FullScreen 카메라앱

## 카메라앱 소개
- AR, ML 기술
- 사용자들에 의해서 생산되는 컨텐츠 많음 -> 유튜브, 인스타, 틱톡 등
- 유로앱에서 높은순위 차지하고 있음

## 공짜 계정으로 앱 폰에 올리기
- 사이드로딩
- Xcode - Preference - Account - Apple ID 입력하고 추가 - Team을 Personal Team으로 바꿈
- ios 버전 맞춰주기
- Podfile 에서 use_frameworks! 대신 use_modular_headers! 로 바꾸기
- Swift Package Manager 제거
- pod 'Kingfisher', '~> 5.0'
- pod install 다시
- 아이폰 설정 - General - Device Management - Trust

## AVFoundation 카테고리 별로 탐구
- 카메라 앱 만들때 필요한 요소가 AVFoundation 있음
- 비디오, 오디오에 특화된 공구함
- Audiovisual Media, capturing, processing, synthesizing, controlling, importing, exporting...
- playback and Editing 
    - 미디어 재생과 편집 기능
    - 미디어 파일 접근할때 코딩할 수 있는 추상화된 객체를 가지고 있음
- Media Capture
    - 카메라나 마이크를 통해 들어오는 데이터를 저장할 수 있게 하는 기능
- Audio
    - 오디오 특화된 기능
    - 믹싱 등
- Speech
    - 목소리를 텍스트로 변환해주는 기능
- 앱개발 할 때 거의 필수적으로 가져와야하는 프레임워크

## 미디어 캡처링에서 알아야 하는 구조 및 주요 구성요소
## 사용자 권한 요청에 대한 이해
## 풀스크린카메라앱 소개 및 디바이스 권한 요청
## 캡쳐세션 주요 요소 추가
## 캡쳐세션 구성하고 시작하기
## 카메라 바꾸기 구현 1
## 카메라 바꾸기 구현 2
## 사진 찍고 저장하기
