# 15. 넷플릭스st 영상앱

## 넷플릭스앱 소개
- 네트워킹을 사용해서 서버에 있는 영화 검색, 컬렉션뷰로 보여줌
- 서버에 있는 영상 스트리밍하는 기능
- 영상 검색, 리스트로 보여주고 추천

## SearchBar 구현
- searchBar 연결 - delegate
- seach버튼 클릭했을 때 실행되는 메서드 구현
- 검색이 완료되면 키보드 내려가도록 처리
- 검색어가 없을 경우는 무시
    ```Swift
    extension SearchViewController: UISearchBarDelegate {

        private func dismissKeyboard() {
            searchBar.resignFirstResponder()    // 첫번째 응답을 그만두게 함
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // 검색 시작

            // 키보드가 올라와 있을 때, 내려가게 처리            
            dismissKeyboard()
        
            // 검색어가 있는지
            guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }

            // 네트워킹을 통한 검색
            print("---> 검색어: \(searchTerm)")
        }
    }
    ```

## SearchAPI 구현
- 목표: searchTerm을 가지고 네트워킹을 통해서 영화 검색
- 검색 API가 필요
- 결과를 받아올 모델 Movie, Response

## SearchAPI 결과 구현
- 결과를 받아와서, collectionView로 표현하기

    <image src="Resource/1.png" >

    - main Thread에서 불려야 할 UI API 가 다른 thread에서 불렸다.
    - 네트워킹 작업은 느리기 때문에 main Thread가 아닌 다른 thread에서 작업을 수행하고 결과 데이터를 UI로 업데이트 시켜야 할 경우에는 thread간에 데이터 넘겨줌
    - UI 업데이트는 main thread에서 수행시켜 줌

    ```Swift
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            dismissKeyboard()

            guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
            // 네트워킹을 통한 검색
            SearchAPI.search(searchTerm) { movies in
                // collectionView로 표현하기
                print("---> 몇 개 넘어왔어?? \(movies.count), 첫번째 꺼 제목: \(movies.first?.title)")
            
                 // 메인스레드로 조정
                DispatchQueue.main.async {
                    self.movies = movies
                    self.resultCollectionView.reloadData()
                }
            }
            print("---> 검색어: \(searchTerm)")
        }
    ```

    - imagePath 이용해서 네트워크 요청 후 받은 이미지 데이터를 UIImage에 넣어줘야 함
        - 외부코드 가져다 쓰기 (SPM, Cocoa Pod, Carthage 이용)
        - url to image ios swift open source 검색
        - kingfisher 사용
        - Xcode - File - Swift Packages - Add Package Dependency

        <image src="Resource/2.png" >
        <image src="Resource/3.png" >
        
        - import Kingfisher 추가

    ```Swift
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
                return UICollectionViewCell()
            }

            // imagePath(String) -> image
            // KingFisher 코드 가져다 쓰기 (Swift Package Manager 이용, SPM)

            let movie = movies[indexPath.item]
            let url = URL(string: movie.thumbnailPath)
            cell.movieThumbnail.kf.setImage(with: url)
        
            return cell
        }
    ```

## 플레이어뷰 가로모드 구현
- 영상을 갖고 있는 movie라는 객체
- 영상을 틀어줄 playerViewController가 있어야 함
- 이후 playerVC + movie 로 올려주고
- player vc를 통해 영상을 재생

    ```Swift
    extension SearchViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // movie
            // player vc
            // player vc + movie
            // presenting player vc

            let movie = movies[indexPath.item]
        
            let sb = UIStoryboard(name: "Player", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
            vc.modalPresentationStyle = .fullScreen // iphone10 이상 fullscreen 지원하기 위해

            present(vc, animated: false, completion: nil)
        }
    }
    ```
- play에 관련된 요소들은 PlayerViewController에서 관리
    - 가로모드 전환을 위해 (landscape/ Left/ Right)

    ```Swift
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    ```

## 플레이어뷰 UI구성
- https://developer.apple.com/documentation/avfoundation/avplayerlayer
- AVPlayer에서 내는 visual output에 대해 담당하는 것이 AVPlayerLayer
- 커스텀 클래스를 연결해줌
```Swift
import UIKit
import AVFoundation

class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
```

## 플레이어 구현
- 뷰 컨트롤러가 메모리에 올라올 때, playerView에 player 설정
- 뷰 컨트롤러가 보여지기 직전에 play() 호출, 클릭하자 마자 보여지도록
- toggle에서 play중이면 pause, 아니면 play
- PlayerViewController를 호출하는 곳에서 재생에 필요한 아이템을 설정해 줘야함
```Swift
let url = URL(string: movie.previewURL)!
let item = AVPlayerItem(url: url)
vc.player.replaceCurrentItem(with: item)
```

## 오늘의 영화 구현
- totoro 에 대한 정보를 검색API로 가져온다
- 거기서 totoro 객체 하나를 가져온다
- 그 객체를 이용해서 PlayerViewController를 띄운다
```Swift
@IBAction func playButtonTapped(_ sender: Any) { 
    SearchAPI.search("totoro") { movies in
        guard let totoro = movies.first else { return }
            
        DispatchQueue.main.async {
            let url = URL(string: totoro.previewURL)!
            let item = AVPlayerItem(url: url)
            let sb = UIStoryboard(name: "Player", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
            vc.player.replaceCurrentItem(with: item)
                
            vc.modalPresentationStyle = .fullScreen
            elf.present(vc, animated: false, completion: nil)
        }
    }
        
}
```
