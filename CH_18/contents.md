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
- 카메라 앱 제작을 위해 Media Capture 기능 가져옴
- 카메라 앱 개발하는 목적
    - 기본적인 카메라 외에 커스텀 UI를 추가하고 싶은 경우
    - 직접적인 컨트롤 제공해주고 싶을 때. 포커스, 노출정도 등
    - 결과물 커스텀 하고 싶을 때. 워터마크, 자막, 필터 등
    - 들어오는 영상물에 AR 오브젝트 넣고 싶을 때.
- UIImagePickerController 를 통해 시스템카메라 가져올 수 있음
- 미디어 캡처링 구성요소 세가지
<image src="Resource/MediaCapture.png" >
    - AVCaptureSession
        - 카메라나 마이크같은 인풋에서 들어오늘 비디오, 오디오 데이터를 아웃풋으로 연결
    - AVCaptureDeviceInput
        - 미디어 소스를 제공해주는 카메라, 마이크 등
    - AVCaptureOutput
        - 인풋에서 들어온 데이터를 디스크에 쓰던지 프로세싱할 때 쓰임

## 사용자 권한 요청에 대한 이해
- 사용자에 대한 데이터가 들어올 수 있는 마이크, 카메라 등을 사용하려면 사용자에게 허락을 받아야 함
- Info.plist
    - camera, mic usage description
    - 사진찍기 전 permission 요청
    - 사진 저장전 Photo Library Permission 요청

## 풀스크린카메라앱 소개 및 디바이스 권한 요청
- 풀스크린 앱, 가운데 캡쳐버튼, 왼쪽에 앨범 버튼, 오른쪽 상단에 카메라 전환버튼
- 사용자 권한 받기 
    - Info.plist
    - Privacy - Camera Usage Description 추가
    - Privacy - Photo Library Usage Description 추가
    - 사용자에게 보여줄 메세지 추가

## 캡쳐세션 주요 요소 추가, setup UI
- captureSession: 인풋 디바이스에서 오디오, 비디오 데이터 가져옴
- AVCaptureDeviceInput
- AVCapturePhotoOutput
- Queue 커스텀큐만들어서 비디오 관련 프로세싱 여기서 수행
- AVCaptureDevice DiscoverySession 디바이스에서 카메라를 찾아오는 기능
- AVCam 과 관련된 Apple Document 소스코드 다운받아서 PreviewView 만들기
- view로드 될 때 previewView session과 cature session 연결
- session의 인풋과 아웃풋 구성해주고
- session 시작하면 디바이스 인풋에 있는 미디어 데이터가 들어오고 preview에 보여줌
- setup UI

## 캡쳐세션 구성하고 시작하기
- presetSetting 하기 -> 포토, 해상도 등
- beginConfiguration
- Add Video Input -> 디바이스 인풋과 캡쳐세션 연결하기
- Add Photo Output -> 아웃풋과 캡쳐세션 연결하기
- commitConfiguration

- beginConfiguration과 commitConfiguration 사이에 디바이스 인풋과 데이터 아웃풋 연결
    - 디바이스 인풋

```Swift
// 디바이스 인풋은 핸드폰에 있는 카메라를 찾을때 조건
let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInWideAngleCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)

        // 그중에서 제일 먼저 발견된 것을 가져와서 실제 디바이스 인풋을 구성
        var defaultVideoDevice: AVCaptureDevice?
        guard let camera = videoDeviceDiscoverySession.devices.first else {
            captureSession.commitConfiguration()
            return
        }
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: camera)
            
            if captureSession.canAddInput(videoDeviceInput) {
                captureSession.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            } else {
                captureSession.commitConfiguration()
                return
            }
        } catch let error {
            captureSession.commitConfiguration()
            return
        }
```

    - 포토아웃풋
    - 어떤 세팅으로 사진 저장할 것인지 선언 -> jpeg타입을 저장
    - 포토아웃풋을 세션에 넣음

```Swift
let photoOutput = AVCapturePhotoOutput()

    photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            captureSession.commitConfiguration()
            return
        }
        captureSession.commitConfiguration()

```

    - 메인 스레드가 아닌 특정 스레드에서 작업을 수행 세션 큐 만들어서 수행

## 카메라 바꾸기 구현 1
- 토글버튼 구현하기
    - 반대 카메라 찾고
    - 해당하는 포지션을 가지고 있는 새로운 디바이스로 세션을 업데이트
        - 기존에 있던 디바이스 인풋을 제거하고 새로운 것을 넣음

## 카메라 바꾸기 구현 2
- 카메라 토글 버튼 업데이트
    - UI작업은 세션큐가 아닌 메인큐에서 해야함

## 사진 찍고 저장하기

