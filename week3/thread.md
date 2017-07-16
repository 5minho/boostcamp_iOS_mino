## Thread
쓰레드는 운영체재의 스케쥴러에 의해서 독립적으로 스케쥴이 잡히는 프로세스의 하위 유닛이다. 가상으로 GCD와 NSOperationQueue의 모든 병렬 처리 API는 쓰레드 위해서 만들어 졌다.

하나 이상의 쓰레드는 싱글 CPU 코어에서도 실행될 수 있다. (최소한 느끼기에 동시에 실행되고 있다고 느끼게 해준다.) 운영체제는 각 쓰레드에게 짧은 시간을 할당해 주며 계산을 하는데, 사용자는 여러 쓰레드가 동시에 실행 되는 처럼 느낄 것이다. 만약 하나 이상의 CPU 코어가 탑재 되어 있다면 실제로 병렬 처리를 하여 특정 과업의 전체 시간을 줄여 줄 것이다.

멀티 CPU 코어에서 당신의 코드와 당신이 사용하고 있는 프레임워크 코드가 실행 스케쥴을 얼마나 잡는지 확인하고 싶다면, XCode의 Instruments의 CPU strategy를 사용하된다.

마음에 염두하고 있어야 할 것은 우리에게는 언제 어디서 작성한 코드가 스케쥴 잡힐지 모른다는 것이다. 그리고 또한 언제 얼마나 길게 할당을 위해 기달려야 자신의 차례가 오는지도 알 수 없다. 이런 종류의 쓰레드 스케쥴링은 매우 강력한 테크닉이다. 하지만 매우 난이도 높은 작업이다.

http://bartysways.net/?p=562

## (Multi) Thread의 필요성
앱이 가동되면 최초로 main thread가 생성되어 실행되는데,
main thread는 앱의 실행과 긴밀한 관련이 있기 때문에 이미지를 불러들인다거나, 서버에서 데이터를 받아올 때 main thread내에서 작업하면 해당 작업이 끝나기 전에 앱의 작동이 일시적으로 멈출수 있다.
이를 해결하기 위해 다른 thread를 생성해 오래 걸리는 작업을 처리한다.



## Foundation Framework에서 Thread를 다루는 방식
- POSIX threads

- Operation objects
  - [NSOperaion & NSOperation Queue](http://maskkwon.tistory.com/206)

- Grand Central Dispatch(GCD)
  - [Grand Central Dispatch](http://maskkwon.tistory.com/159)
  - [GCD 활용](https://outofbedlam.github.io/swift/2016/05/11/GCD/)

- Notification
  - NSNotificationQueue에 Notification을 넣고 idle-time 옵션을 준다.

- Timer
  - NSTimer나 CFRunLoopTimer을 사용하면 thread를 사용하기에 하찮은 작업들을 주시적으로 반복 시킬 수 있다.

## iOS에서의 thread 사용

  - Run loop (event handling, timer...)
  - memory management (autorelease)
  - NSURLConnection (인터넷에서 데이터를 받아오는 객체)

## 출처
http://maskkwon.tistory.com/

http://bartysways.net/?p=562

http://linkedlist.tistory.com/entry/iPhone-멀티스레딩-NSThread
