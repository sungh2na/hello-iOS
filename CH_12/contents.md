# 12. 애플뮤직st 음악앱
- AVFoundation 프레임워크 이용 - 카메라, 비디오, 음악앱
- AVPlayer - 미디어를 플레이 시켜줌
- Dark mode
- CollectionReusableView (섹션헤더뷰) -> 여러 아이템 표현할때 ?

## 홈화면 컬렉션뷰 추가
- 커스텀 셀 만들기

## 홈화면 컬렉션뷰 헤더 구현

```Swift
    // 헤더뷰 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let item = trackManager.todaysTrack else {
                return UICollectionReusableView()
            }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrackCollectionHeaderView", for: indexPath) as? TrackCollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            header.update(with: item)
            header.tapHandler = { item -> Void in
                // Player를 띄운다
                print("---> item title: \(item.convertToTrack()?.title)")
            }
            
            // TODO: 헤더 구성하기
            return header
        default:
            return UICollectionReusableView()
        }
    }
```

## 플레이어뷰 구현
- 싱글톤 객체 만들기
- 플레이어뷰를 여기저기서 쓸 수 있음

```Swift
static let shared = SimplePlayer()
'''