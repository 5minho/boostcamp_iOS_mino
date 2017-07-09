### Start Developing iOS Apps (Swift) Sample App
- [x] 애플의 [MVC 문서](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html "애플 MVC") 읽어오기

MVC 패턴으로 디자인된 App의 객체는 model, view, controller 중 하나의 역할을 하는 객체이다. Cocoa 아키텍쳐도 MVC 기반이라서 개발자의 커스텀 객체들도 MVC 역할 중 하나의 역할을 수행하기 요구됨
* __MVC 패턴의 이점__
  * 애플리케이션 내 객체들의 재사용성이 높아지고, 인터페이스들도 잘 정의됨
  * 보다 쉽게 확장 가능함

* __Model__
  * 데이터를 캡슐화하고 그 데이터를 처리하는 로직을 정의
  * Model objects는 뷰 객체에 명시적으로 연결되어서는 안되고, UI 및 프레젠테이션 문제와 관련되지 않아야 한다.

* __View__
  * 유저가 볼 수 있고 유저의 액션을 받을 수 있는 객체들
  * Model 객체들을 화면에 보여주는 역할을 하지만 보통 Model 객체들과는 분리되어서 우리는 View 객체들을 여러 애플리케이션에서 재사용 가능하다.

* __Controller__
  * Model과 View의 중개자 역할
  * Controller는 Model의 변화를 View 객체에게 알려줘서 View 객체는 새로운 데이터를 화면에 표시할 수 있음
  * 초기설정, task 조정, 다른 객체의 life cycle도 관리한다.


* __궁금한 점__
  * MVC 패턴의 이점 부분을 읽으면서, 그냥 객체 지향 프로그래밍의 이점과 별 다를것이 없다고 느꼈다. 조원들과 MVC 패턴의 장점을 확실하게 느낄수 있는 구체적인 상황을 예를 들어 생각해보고 조별 과제에 추가 했으면 좋을거 같다
***


 - [x] Define Your Data Model 파트까지 읽어오기

* 궁금한 점
  * addTarget 에서 selector로 함수를 넘기는데 클로저로 구현할 수 도 있을거 같은데 selector로 넘기는 이유
  * 유용한 XCTest 메서드와 실무에서 어떤식으로 UnitTest를 하는지

***
  - [ ] Sign Up Page 구성하기
  constraint를 정의하기전에 superview의 addSubView메서드를 수행하자
* 궁금한 점
  * View.bounds와 View.frame의 차이점, 관계
    * bounds는 자기 자신 좌표계에서 view의 크기를 나타낸다
    * frame은 superview의 좌표계에서 view의 크기와 위치를 나타낸다.
***
