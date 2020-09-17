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
