# 테이블 뷰 
- 여러 아이템을 리스트 형태로 보여주고 싶을 때 

##  UITableViewDataSource
- 테이블뷰 셀 몇개?
- 테이블뷰 어떻게 보여줄지? 

## UITableViewDelegate
- 테이블 뷰 클릭하면 어떻게?

- protocol : 어떤 서비스를 이용하기 위해 해야할 일
- 테이블뷰 서비스를 쓰기 위해 해야 할 일

## 커스텀 테이블 뷰 셀

## 뷰컨트롤러 모달로 띄우기 
- 셀을 선택 했을 때 detailViewController 뜨도록 함
<p align="center">

<image src="segue.png" >

</p>

```Swift
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
}
```

* 스토리 보드에서 viewController 두개를 연결
* 여러가지 segue 있을 수 있으니까 identifier 지정해주기
