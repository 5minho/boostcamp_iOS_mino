
## [iOS] thread

- thread는 concurrency를 지원하는 방법 중 상당히 low-level 한 방법이고 복잡한 방법
- thread를 사용할 때 제대로 설계하지 못한다면 동기화와 타이밍 문제가 생김
- thread를 굳이 써야할 정도의 task인지 확실하게 정의
- thread는 CPU와 메모리에 어마어마한 overhead를 부여하게 된다.

## [iOS] thread 대용품

- Operation objects
  - [NSOperaion & NSOperation Queue](http://maskkwon.tistory.com/206)
- Grand Central Dispatch(GCD)
  - [Grand Central Dispatch](http://maskkwon.tistory.com/159)
- Idle-tiem notifications
  -  NSNotificationQueue 에 Norification 을 넣고 idle-time옵션을 준다. 해당 NSNotificationQueue는 run loop가 idle 상태가 되었을 떄, notification을 전달하여 수행한다.
- Asynchronous functions
  - Cocoa API 중 함수 자체가 Asynchronous Excution을 하게 설계된 것들이 있음. 이들을 thread 대용으로 활용 가능
- Timers
  - NSTimer나 CFRunLoopTimer를 사용하면 thread를 사용하기에 너무 하찮은 작업들을 주기적으로 반복 동작 시킬 수 있다.
- Separate process

## Thread의 구현
- Cocoa thread
  - NSThread 클래스를 통하여 구현한다. 또는 NSObject 클래스에서 'performSelectorInBackgound:withObject'메소드를 사용하여 새로운 thread에 실행 로직을 부여할 수 있다.

- POSIX threads
  - POSIX thread 는 thread를 생성하기 위한 C기반의 인터페이스, Cocoa application을 구현하지 않는다면 POSIX thread가 thread를 사용할 수 있는 가장 손쉬운 방법

## Inter-thread Communication
- Direct messaging
  - 다른 thread에게 selector를 수행하게 만들 수 있다. 이 방식을 통하여 해당 thread에 메시지를 전달할 수 있다.
- Global variables, Shared memory & objects
  - thread 사이에 전역 변수, 공유 객체, 메모리 shard block을 이용하여 정보를 교환할 수 있다. 이 방법은 다른 통신 방법에 비해 단순하고 빠르지만 동기화 문제에 대한 무결성을 보장해야 한다. 이를 보장하지 못할 경우엔 race condition, 데이터 오류, crash 등의 문제를 발생시킬 수 있다.

- Conditions
  - condition을 thread가 코드의 일부분을 제어하기 위한 동기화 수단이다.

## 출처
http://maskkwon.tistory.com/
