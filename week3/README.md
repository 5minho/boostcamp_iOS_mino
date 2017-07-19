- UIControl
  - 교재 333 페이지 다시 한번 보기
- ARC
  - strong, weak, unowned 이해하기!!

##### UIControl Actions
    UIControl은 추가된 모든 action/target 쌍을 기록한다. user가 control에서 event를 수행하거나 UIControl이 sendActionsForControlEvents 함수를 호출하면, 해당 control event와 관련된 작업이 등록된 target으로 보내진다.

##### User Events
    User event들은 applicaion event queue에 전송된다. 만약 touch가 아닌 user event라면, applicaion이 first responder에게 호출을 전달하고, first responder가 system을 처리하지 못하면 responder-chain을 따라 적절한 responder를 찾는다.

    touch event들의 경우, system이 화면에서 touch를 감지하면 이 touch를 applicaion에 보내고 applicaion은 _touchesEvent 내부 메소드에서 touche event를 받는다.

    그러면 applicaion은 sendEvent를 사용하여 이 event를 UIWindow에 전달한다. 이 event를 받으면 window 는 이 touch를 받은 view를 찾기 위해 view hit-test process를 시작한다.

    UIView의 hitTest::withEvent는 touch 상태의 view를 찾는데 사용되고, hit-test의 구현은 touch가 view범위 내에 있는지 확인한다. 각 view는 pointInside:withEvent를 호출한다.

    hitTest와 pointInside는 최상위 left view에 도달할 때까지 재귀적으로 호출된다. 이 view는 touch event의 first responder로 사용된다.

    그러면 UIWindow는 touch event를 이 view에 보낸다.


##### Thread
Main Thread 에서 event handling 을 위한 run loop도 실행되고, UI를 그리는 작업도 실행되는 것인가????

##### 책 내용 질문
__193 page__

```swift
@IBAction func toggleEditingMode (sender: AnyObject) {
  // 코드내용
}
```
sender를 AnyObject로 받으면 좋은점??? -> 여러종류의 컨트롤의 액션을 하나에 액션함수를 주기 위해서인가???

__201 page__

alertcontroller 에 action을 추가하는 함수, addAction에서 핸들러를 지정할 때 itemStore는 앞에 self를 안붙이면 error가 나고 tableView는 self를 안붙여도 제대로 컴파일이 된다?????
