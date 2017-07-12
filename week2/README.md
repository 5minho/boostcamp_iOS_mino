### Start Developing iOS Apps (Swift) Sample App
- [x] 애플의 [MVC 문서](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html "애플 MVC") 읽어오기

* __궁금한 점__
  *  조원들과 MVC 패턴의 장점을 확실하게 느낄수 있는 구체적인 상황을 예를 들어 생각해보고 조별 과제에 추가 했으면 좋을거 같다
***


 - [x] Define Your Data Model 파트까지 읽어오기

* __궁금한 점__
  * addTarget 에서 selector로 함수를 넘기는데 클로저로 구현할 수 도 있을거 같은데 selector로 넘기는 이유
  * 유용한 XCTest 메서드와 실무에서 어떤식으로 UnitTest를 하는지

***
  - [x] Sign Up Page 구성하기

  constraint를 정의하기전에 superview의 addSubView메서드를 수행하자
* __질문__
  * View.bounds와 View.frame의 차이점, 관계
    * bounds는 자기 자신 좌표계에서 view의 크기를 나타낸다
    * frame은 superview의 좌표계에서 view의 크기와 위치를 나타낸다.
  * UIButton 을 프로그래밍으로 생성했을때 버튼 클릭시 버튼색이 부드럽게 바뀌는거는 애니메이션으로 구현해야 하는지
  * TextView의 스크롤을 올리고 내릴때 마다 끊김이 있음. 왜그럴까
  * 키보드의 유무에 따라 오토레이아웃을 달리하는 작업을 하는데 궁금점이 있었음 https://github.com/minomi/boostcamp_iOS_mino/commit/6e50bdfccd953124ed4e2b8e207ffb24a060078d 의 53라인, 221라인 코멘트

* __추가__
    * 키보드가 나올때 버튼의 autoLayout을 조정해서 텍스트 뷰에 입력 가능하게 함
***
