### Bundle

Bundle은 macOS와 iOS에서 소프트웨어를 제공하는 편리한 기능이다. Bundle은 사용자에게 간단한 인터페이스를 공급하고, 개발을 지원해준다.

### Bundle & Package

Bundle과 Package는 가끔 서로 바꿔 쓸 수 있지만 실제로 매우 다른 개념을 나타낸다.
  - Package : finder가 마치 단일 파일인것 처럼 나타내는 디렉터리
  - Bundle : 실행 가능한 코드와 해당 코드에서 사용하는 리소스를 저장하는 표준화 된 계층 구조가있는 디렉터리.

Package는 macOS를 더 쉽게 사용하도록 하는 기본적인 추상화중의 하나이다. 컴퓨터에 응용프로그램이나 플러그인을 볼때 실제로 보이는 것은 디렉터리이다. Package 디렉터리 안쪽에는 응용프로그램과 플러그인이 실행할수 있게하는 코드와 리소스 파일들이 있다. 그러나 Package 디렉터리를 사용할 때 Finder는 디렉터리를 단일파일 처럼 취급한다. 이 행동은 사용자가 Package의 내용들에 악영향끼치는 변화를 만드는 것을 방지한다. 예를들어 사용자들이 리소스들을 삭제하고 바꾸고, 응용 프로그램이 정상적으로 실행되는것을 방해하는 모듈을 코딩하는 것을 방해한다.

Packages들이 사용자 경험을 향상시키는 요소가 있는 반면에 Bundle은 개발자들이 그들의 코드를 패키징하고, 그 코드를 os가 접근하는데 도움이 되는데 적합하도록 맞춰져있다. Bundle은 코드와 소프트웨어와 관련된 작업들를 관리하기 위한 기본 구조를 정의한다. 이 구조는 국제화 처럼 중요한 특성들을 가능하게 하고

### 출처
https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFBundles/AboutBundles/AboutBundles.html
