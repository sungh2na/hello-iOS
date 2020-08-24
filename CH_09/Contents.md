9. 원피스 현상금 추천 앱 만들기

<image src="Resource/bountylist1.png" >
<image src="Resource/bountylist2.png" >

## 테이블 뷰 

- 여러 아이템을 리스트 형태로 보여주고 싶을 때 
- **UITableViewDataSource** -> 테이블뷰 셀 몇개, 어떻게 보여줄지
- **UITableViewDelegate** -> 테이블 뷰 클릭하면 어떻게 할지
- protocol: 테이블뷰 서비스를 쓰기 위해 해야 할 일

## 커스텀 테이블 뷰 셀

## 뷰컨트롤러 모달로 띄우기

- 셀을 선택 했을 때 detailViewController 뜨도록 함

<p align="center">

<image src="Resource/segue.png" >

</p>

```Swift
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
}
```

- 스토리 보드에서 viewController 두개를 연결
- 여러가지 segue 있을 수 있으니까 identifier 지정해주기

## 뷰컨트롤러간 데이터 전달하기

- segue로 연결된 두 뷰컨트롤러 간에 전환시 데이터 전달하는 방법

```Swift
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // DetailViewController에 데이터 전달
       if segue.identifier == "showDetail" {
          let vc = segue.destination as? DetailViewController
          if let index = sender as? Int {
               vc?.name = nameList[index]
               vc?.bounty = bountyList[index]
           }
        }
 }

 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
 }

``` 
- sender 파라미터에 정보를 넣어서 보냄
- segue 수행하기 직전에 준비하는 함수 **prepare** 작성 (sender 정보 이용)
- **updateUI()** -> segue 수행한 후에 넘어온 정보를 업데이트 시킴
