# 11. 원피스 현상금 랭킹앱을 더 풍부하게

## CollentionView 개념
- 한 행 안에 여러개의 아이템을 보여주는 형식
- TableView는 한 행에 한 아이템만 넣을 수 있음
- 각 데이터의 나열을 수평방향, 수직방향 결정가능
- 각 데이터들은 collectionViewCell로 표현 가능
- UITableView에 비해 자유로움
- 자유로운 레이아웃 때문에 전문적으로 관리하는 객체가 필요함 -> UICollectionViewLayout 상속
- 기본적으로 애플에서 제공해주는 겍체 -> UICollectionViewFlowLayout
- Datasource&Delegate 프로토콜 이용해서 CollectionView 이옹하는데 필요한 코드 작성


## 
- Collection View 만들고 Bounty View Controller와 dataSource, delegate로 연결

