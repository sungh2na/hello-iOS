# 9. 원피스 현상금 추천 앱 만들기

<image src="Resource/bountylist1.png" >
<image src="Resource/bountylist2.png" >

## 테이블 뷰 

- 여러 아이템을 리스트 형태로 보여주고 싶을 때 
- **UITableViewDataSource** -> 테이블뷰 셀 몇개, 어떻게 보여줄지
```Swift
    // 몇개 보여줄지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }

    // 어떻게 표현할지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // 재사용된 셀을 구분해서 가져오고 그 셀에 필요한 정보 가져와서 셀 업데이트하고 그 셀을 넘겨줌
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell  else {// ListCell로 캐스팅
            return UITableViewCell()
        }

        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
        return cell
    }
 ```
    - dequeueReusableCell을 써서 기존 cell을 재사용해서 계속 뿌려줄 것임을 나타내 줌
    - cell을 불러와야되므로 스토리보드에서 테이블뷰 셀에 Identifier을 "cell"로 작성하고 dequeueReusableCell의 withIdentifier에 똑같이 "cell"을 써줌
    - 스토리 보드에서 tableView 와 뷰컨트롤러 control + 드래그로 dataSource와 delegate 연결해주기

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
    - 스토리보드에서 segue의 이름을 설정하고 설정한 이름으로 특정 segue에만 접근하게 할 수 있음
    segue가 여러개가 될 경우 이름이 있어야 함
    - showDetail이라고 이름을 추가해준다 
- segue 수행하기 직전에 준비하는 함수 **prepare** 작성 (sender 정보 이용)
    - performsegue가 실행되기 전에 segue가 실행되는 걸 준비하는 함수
    - prepare함수는 기존에 있는 걸 가져다 쓰므로 override를 붙여서 써줌
- **updateUI()** -> segue 수행한 후에 넘어온 정보를 업데이트 시킴
