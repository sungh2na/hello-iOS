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

let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200 ..< 300
    
    guard successRange.contains(statusCode) else {
        // handle response error
        return
    }
    
    guard let resultData = data else { return }
    let resultString = String(data: resultData, encoding: .utf8)
    
    print("---> result: \(resultData)")
    print("---> resultString : \(resultString)")    // postman에 requestURL보내서 확인
}

dataTask.resume()
