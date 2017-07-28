## Tagging View Controller
 * view controller 저장을 위해 restorationIdentifier 프로퍼티를 세팅해야 한다(디폴트 값은 nil)
    * 값을 세팅할때는 view controller 구조의 모든 부모 view controller들의 restorationIdentifier값도 할당해야 한다.

    * 부모의 restorationIdentifier을 세팅하지 않으면 자식 view controller의 restorationIdentifier 가 세팅되어 있어도 보존되지 않는다.

    * 모든 view controller의 restoration 경로는 유일해서, 만약 container view controller 가 2 개의 view controller 를 가지고 있다면 2개 다 restorationIdentifier 값을 가지고 있어야 한다.

## Preseving a View Controller's Views

 * view controller와 관계 없는 view의 상태(ex scroll view의 위치)를 보존하고 싶으면 view의 restorationIdentifier 프로퍼티에 값을 할당해야 한다. view controller가 scroll view 의 내용을 저장하고, view는 그 자신의 시각적 상태를 저장한다.

 * table view, collection view 들은 UIDataSourceModelAssociation 프로토콜을 채택하는 data source를 할당해야 한다.

## Restoring View Controller at Launch Time

실행타임에 UIKit은 app을 이전 상태로 복원하려고 시도 하고, 그 때 UIKit은 app에게 저장된 user interface로 구성된 view controller 객체를 생성 또를 위치시키라고 요청한다. UIKit은 아래의 흐름에 따라서 view controller를 위치 시킨다.

* view controller에 restoration class가 있으면, UIKit은 해당 클래스에 view controller를 제공하도록 요청한다.
  * UIKit 은 view controller를 찾기 위해 관련된 restoration class의 viewController(withRestorationIdentifierPath:coder:) 메서드를 호출한다. 이 메서드가 nil을 리턴하면 App 이 view controller를 다시 생성하고 싶지 않다를 것을 가정하고 UIKit은 탐색하는 과정을 멈춘다
* view controller에 restoration class가 없다면, UIKit은 app delegate 에 view controller를 제공하라고 요청한다.
  * UIKit 이 restoration class가 없는 view controller를 찾기 위해 app delegate의 application(_:viewControllerWithRestorationIdentifierPath:coder:) 메서드를 호출한다. 이 메서드가 nil을 리턴하면 UIKit을 암시적으로 찾으려고 노력한다.
* 알맞은 restoration 경로를 가진 view controller가 존재 한다면 UIKit은 이 객체를 사용한다.
  * 실행타임에 app이 view controller들을 생성하고, 그 view controller들이  restorationIdentifier를 가지면, UIKit은 그 view controller들의 restoration 경로를 기반으로 암시적으로 view controller를 찾는다.
* view controller가 스토리보드 파일로 부터 load 됐다면, UIKit은 저장된 스토리보드 정보를 사용해서 view controller를 생성하고 위치시킨다.
  * UIKit은 restoration archive안에 view controller의 스토리보드에 대한 정보를 저장한다. 복원될때, view controller가 찾아 지지 않는 다면 UIKit은 이 정보를 사용해서 동일한 스토리보드 파일을 찾고 스토리보드 파일은 해당하는 view controller를 인스턴트화 한다.

view controller에 restoration class를 할당하는 것은 UIKit이 암시적으로 그 view controller을 찾는거를 막는다. restoration class를 사용하면 실제로 view controller의 생성 여부를 제어할 수 있다. 예를 들어서 당신이 view controller를 재생산하고 싶지 않다면 viewController(withRestorationIdentifierPath:coder:) 메서드가 nil을 리턴하게 하면 된다.
