- UIControl
  - 교재 333 페이지 다시 한번 보기
- ARC
  - strong, weak, unowned 이해하기!!
###### Thread
Main Thread 에서 event handling 을 위한 run loop도 실행되고, UI를 그리는 작업도 실행되는 것인가????

###### 책 내용 질문
__193 page__

```swift
@IBAction func toggleEditingMode (sender: AnyObject) {
  // 코드내용
}
```
sender를 AnyObject로 받으면 좋은점??? -> 여러종류의 컨트롤의 액션을 하나에 액션함수를 주기 위해서인가???

__201 page__

alertcontroller 에 action을 추가하는 함수, addAction에서 핸들러를 지정할 때 itemStore는 앞에 self를 안붙이면 error가 나고 tableView는 self를 안붙여도 제대로 컴파일이 된다?????
