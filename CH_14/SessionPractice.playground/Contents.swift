import UIKit

// URL Session - 1
// URL
// URL Session을 만들기 전에 URL을 ios에서는 어떻게 만들까, 쿼리를 쉽게 넣을 수 있는 urlcomponent등

let urlString = "https://itunes.apple.com/search?media=music&entity=song&term=Gdragon"
let url = URL(string: urlString)

url?.absoluteString
url?.scheme
url?.host
url?.path
url?.query
url?.baseURL

let baseURL = URL(string: "https://itunes.apple.com")
let relativeURL = URL(string: "search?media=music&entity=song&term=Gdragon", relativeTo: baseURL)

relativeURL?.absoluteString
relativeURL?.scheme
relativeURL?.host
relativeURL?.path
relativeURL?.query
relativeURL?.baseURL

//// URLComponents
//// URL을 영어로 또는 서버가 최대한 이해할 수 있는 용어로 인코딩 해줘야 함
//
//var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")
//let mediaQuery = URLQueryItem(name: "media", value: "music")
//let entityQuery = URLQueryItem(name: "entity", value: "song")
//let termQuery = URLQueryItem(name: "term", value: "지드래곤")
//
//urlComponents?.queryItems?.append(mediaQuery)
//urlComponents?.queryItems?.append(entityQuery)
//urlComponents?.queryItems?.append(termQuery)
//
//urlComponents?.url
//urlComponents?.string       // 지드래곤이 url에서 넘겨줄 때 이해할 수 있는 용어로 변환됨
//urlComponents?.queryItems
//
//
//// URL을 한단계 위로 추상화, URL에 필요한 정보에 접근하고 싶으면 url에 접근한 후 가능
//urlComponents?.url?.scheme
//
//// 아이템들을 오브젝트로 접근하고 싶을 때, 마지막 쿼리 아이템의 value
//urlComponents?.queryItems?.last?.value







// URL Session - 2
// ios 네트워킹에 필요
// URLSession 이용해서 request보내고 response data 받아보고 볼수 있는 형태의 String 표시해 봄

// 1. URLSessionConfiguration
// 2. URLSession
// 3. URLSessionTask 를 이용해서 서버와 네트워킹

// URLSessionTask

// - dataTask
// - uploadTask
// - downloadTask

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// URL
// URL Components
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "지드래곤")

urlComponents.queryItems?.append(mediaQuery)
urlComponents.queryItems?.append(entityQuery)
urlComponents.queryItems?.append(termQuery)
let requestURL = urlComponents.url!

struct Response: Codable {  // Jason이라는 데이터를 원하는 오브젝트로 파싱하기 위해 Codable 준수
    let resultCount: Int
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case tracks = "results"
    }
}

struct Track: Codable {
    let title: String
    let artistName: String
    let thumbnailPath: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artistName
        case thumbnailPath = "artworkUrl30"
    }
    
    // trackName
    // artistName
    // artworkUrl30
}

let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200 ..< 300
    
    guard successRange.contains(statusCode) else {
        // handle response error
        return
    }
    
    guard let resultData = data else { return } // json파일의 데이터 형태
    let resultString = String(data: resultData, encoding: .utf8)
    
//    print("---> result: \(resultData)")
//    print("---> resultString : \(resultString)")    // postman에 requestURL보내서 확인


    // URL Session - 3
    
    // 목표: 트랙리스트 오브젝트로 가져오기
    
    // 하고 싶은 욕구 목록
    // - Data -> Track 목록으로 가져오고 싶다 {Track}
    // - Track 오브젝트로 만들어야겠다
    // - Data에서 struct로 파싱하고 싶다 -> Codable 이용해서 만들자
    //   - Jason 파일, 데이터 -> 오브젝트 (Codable 이용하겠다)
    //   - Response, Track 이렇게 두개 만들어야겠다
    
    // 해야할 일
    // - Response, Track struct
    // - struct의 프로퍼티 이름과 실제 데이터의 키와 맞추기 (Codable 디코딩하게 하기 위해서)
    // - 파싱하기 (Decoding)
    // - 트랙리스트 가져오기
    
    
    
    
    // 파싱 및 트랙 가져오기
    
    do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: resultData)
        let tracks = response.tracks
        
        print("---> tracks: \(tracks.count) - \(tracks.first?.title)- \(tracks.last?.thumbnailPath)")
    } catch let error {
        print("---> error: \(error.localizedDescription)")
    }
    
}

dataTask.resume()



