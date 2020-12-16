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
          searchBar.resignFirstResponder()    // 첫번째 응답을 그만두게 함.
        }
    
         func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // 검색 시작
        
            // 키보드가 올라와 있을 때, 내려가게 처리
                 dismissKeyboard()
        
            // 검색어가 있는지
                guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }

            // 네트워킹을 통한 검색
            print("---> 검색어: \(searchBar.text)")
      }
    }
    ```
