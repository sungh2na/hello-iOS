# 14. 네트워킹
- Concurrency, GCD, HTTP, URLSession
## 네트워킹 오버뷰
- 넷플릭스 - 컨텐츠 리스트, 사용자 정보, 동영상 스트리밍
- 애플뮤직 - 컨텐츠 리스트, 사용자 정보, 음악 스트리밍
- 페이스북 = 뉴스피드 리스트, 사용자 친구정보, 새로운 노티 정보
- **URLSession** 통해 ios 네트워킹 구현
- Network is slow -> 앱의 반응성이 중요, Concurrency(동시성), 동시에 여러개 수행! 
- 동시성을 제공하기 위한 API -> **GCD** & Operations

## HTTP 개념
- 서버와 앱 간에 어떻게 데이터를 주고 받을까? HTTP, REST api, JSON data
- **HTTP**: HyperText Transfer Protocol
- 클라이언트(모바일 앱)과 서버간에 어떻게 메세지를 주고받을까에 대한 규칙
- 서버와 클라이언트간에 다큐먼트 전달을 목적으로 만들어진 통신규약
- HTTP 동작 방식: 서버는 클라이언트 요청에 대한 응답으로 데이터를 보내줌, 메세지 형식으로 의사소통
- HTTP Request method 
    1. POST : Create
    2. GET : Read
    3. UPDATE : Update
    4. DELETE : Delete
- **URL**: Uniform Resource Locator, 주소를 통해 서버에 요청을 보냄
- **Request** 메세지 - 헤더와 바디로 나눠짐 (웹페이지 요청 등)
- **Response** 메세지 - 헤더와 바디로 나눠짐, 헤더에 상태코드(요청이 성공적이었는지), 바디에 Content-Type
- **Content-Type**
    - text/html
    - application/jason
    - image/png
    - video/mpeg
- **HLS (HTTP Live Streaming)** - 대부분의 영상, 음원 스트리밍 서비스에서 사용됨
- **정리** - HTTP는 서버와 앱간에 통신하는 방법이고 사용하기 위해서는 적절한 HTTP method와 URL을 이용하면 된다.

## HTTP 실습

## Concurrency(동시성)
- 한번에 여러개 수행
- 앱이 하는 일 
    - 사용자 인터랙션 처리 (작업 1) 
    - 네트워킹 (작업 2) 
    - 백그라운드에서 파일 다운로드 (작업 3)
    - 파일 저장하고 읽기 (작업 4)
- 작업 = 스레드
- 앱에서 여러개의 스레드가 있고 각 스레드를 동시에 수행해줘야함
- 여러가지 작업(스레드)를 쪼개서 수행함
- 앱 밖에서는 동시에 수행하는 것처럼 보이게 함
- UI관련, 사용자 인터렉션 관련 처리는 메인 스레드에서 함
- 복잡한 계산이나 네트워킹 처리는 다른 스레드에서 함

## GCD 실습
- Grand Central Patch

```
GCD provides and manages FIFO queues to which your application can submit tasks in the form of block objects. Work submitted to dispatch queues are executed on a pool of threads fully managed by the system. No quarantee is made as to the thread on which a task executes.           - Apple document
```

- 해야할 일(코드 블럭)들을 만들어서 GCD를 넘기면 시스템에서 알아서 스레드 할당해서 안전하게 수행시켜 줌
- 스레드 위에 만들어진 녀석
- 큐를 이용해서 테스크 관리
- **Dispatch Queue**의 타입
    - 1. Main Queue : 메인 스레드에서 작동, UI관련 사용자 인터렉션 처리
    ```Swift
    // Main Queue
    DispatchQueue.main.asyns {
        // Do Any UI Update Here
    }
    ```
    - 2. Global Queue : 시스템에의해 관리되는 큐, Qos(Quality of Service)로 우선순위 표현
        - 1. userInteractive
        - 2. userInitiated
        - 3. default
        - 4. utility - 네트워킹, 파일 불러오기 등
        - 5. background - 당장 필요 없는 것, 영상 다운 등
    ```Swift
    // Global Queue
    DispatchQueue.global(qos: .background).async {
        Do Haevey Work Here
    }
    ```
    - 3. Custom Queue - 직접 큐 생성해서 관리

    ```Swift
    // Custom Queue
    let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
    let serialQueue = DispatchQueue(label: "serial", qos: .background)
    ```

    ```Swift
    // Custom Queue
    // 두개의 Queue 같이 쓰기 - 이미지 다운받고 그것을 업데이트 해주는 일처럼 작업간에 의존성 있을 경우
    DispatchQueue.global(qos: .background).async {
        let image = downloadImageFromServere()
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    ```
- sync & Async
```
DispatchQueue.global(qos: .background).async {
    for i in 0...5 {
        print("😈 \(i)")
    }
}
DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("😥 \(i)")
    }
}

/*
😥 0
😈 0
😥 1
😈 1
😥 2
😈 2
😥 3
😥 4
😥 5
😈 3
😈 4
😈 5
*/
```
    - 두번째 큐의 qos가 첫번째 큐보다 높기 떄문에 첫번째가 끝나기 전에 뒤에 작업이 시작
```
DispatchQueue.global(qos: .background).sync {
    for i in 0...5 {
        print("😈 \(i)")
    }
}
DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("😥 \(i)")
    }
}
/*
😈 0
😈 1
😈 2
😈 3
😈 4
😈 5
😥 0
😥 1
😥 2
😥 3
😥 4
😥 5
*/
```
    - 첫번째가 우선순위가 낮아도 앞에 작업이 다 끝나야지만 뒤에 작업이 사작함
    - 무거운 작업은 대부분 async로 진행

## URL Session 개념

## URL Session 실습
