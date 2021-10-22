# Thread

## 용어

### Task
- 프로그래밍에서 실행될 일
- Swift 에서는 closure 로 선언된다
- DispatchWorkItem 으로 캡슐화 된다

```
DispatchQueue.main.async {
    //Task: Closure로 선언되고 DispatchWorkItem으로 캡슐화
}
```

### Queue
- queue는 새로운 아이템을 뒤에 추가할 수 있고, 앞에 아이템을 제거가 가능한 리스트이다
- 그래서 처음 넣은(enqueue) 아이템을 처음 제거(dequeue)할 수 있다. FIFO(First in - First Out)형태이다
- 간단하게 선입선출. 먼저 넣은걸 먼저 내보낸다. 
- 3가지 종류가 있다.

#### 종류
1. Main Queue
- MainThread 에서 실행되는 serial Queue(직렬)
- UITask 를 실행시킬때 사용 -> 가장먼저 우선순위를 두어야 할일(사용자가 버튼을눌렀을떄 응답한다던지, 지체되어선안될일)

```
DispatchQueue.main.async {}
```

2. Global Queue
- Cocurrent (병렬)로 진행되는 Queue
- UI에 관련 없는 Task 에 사용하면 좋다 -> 백그라운드에서 작업하여도 되는일(ex: 없어도 앱사용에 문제는 없지만 추후에 다운로드 받아도 되는 리소스같은것)
- QOS 에서 활용하는 queue

```
DispatchQueue.global().async {}
```

3. Custom Queue
- 개발자가 임의로 만들수있는 queue
- Background 에서 순서대로 Task를 실행하고 싶을 때. 실행결과를 또 다시 사용해서 관리를 처리하고 싶을 때 사용하면좋다.

```
let customQueue = DispatchQueue(
    label: "com.kang.queue",    //보통 이런식으로 명명
    qos: .userInitiated,        //중요도 설정
    attributes: .initiallyInactive,  //직렬, 병렬, 사용자 설정
    autoreleaseFrequency: .inherit,  //queue의 autolease pool 설정
    target: nil
)
```

### QOS
- Quality Of Service
- Queue에 추가되는 Task 실행의 우선도를 QoS라고 부르며 순서는 아래와 같다
- userInteractive > userInitiated > default > utility > background > unspecified

|Qos Class|사용 예|소요시간|
|:---|:---|:---|
| userInteractive|Main Thread 에서 실행되는 UI 처리.  Animation  UI 업데이트 | 순식간|
|userInitiated|	사용자의 행동에 반응.  저장된 파일을 열거나 할때 사용. | 순식간 ~ 몇초 |
|default| 개발자가 작업을 분류하는 데 사용되지 않음.  QoS가 지정되지 않은 경우 기본값으로 취급된다.  Global Queue의 우선도. | - |
|utility| 어느정도 계산이 필요하고 즉각적인 결과가 필요하지는 않을 때.  처리 정도가 ProgressBar에 표시할 필요한 처리.  네트워크, 다운로드, 계산, 데이터를 가져오는 처리 등. | 몇초 몇분 |
|background| 에서 실행되어서 사용자에겐 보이지 않는 처리.  백업 등.  사용자가 iPhone에서 저전력모드를 설정해 두면  background 로 설정된Task는 일시중지되어 실행되지 않는다.| 몇분 ~ 몇시간 |
|unspecified| QoS 정보가 없음 | - |

### Thread
- 어떤 프로그램내에서 프로세스 내에서 실행되는 흐름의 단위
- queue 에서 쌓인 task 들이 thread 에서 실행되는것
 - Q: 그러면 thread 가 여러개면 task를 여러개 처리 가능한가?, A: 그래서 멀티 스레드, 다중코어의 프로세서들이 나오는것.
 - 모든 app은 기본적으로 main thread를 가지고 있다
 - 기본적인 UI 및 모든 행동은 main thread에서 실행된다

#### 왜 사용하는가?
1. Multi core process를 사용하기 위해
2. 동시에 작업이 필요한 경우
3. 중요한 작업에 방해를 받지 않기 위해(유튜브보는중인데 이후에나올 광고를 백그라운드에서 다운로드받으면되는데 영화를멈추고 다운로드 한다던지 그런 불상사..)

#### sync
- 앞의 task 가 끝날때 까지 기다린다.

#### async
- 앞의 task 가 끝날때까지 기다리지않고, 무조건 일단 실행시킨다(1,2,3,4,5 를 실행시켰다고 해서 순서가보장되진않는다.)
- `DispatchQueue.main.async` 의 async 

## autoleasepool
- autorlease 역시 메모리 할당 관련 용어인데 ARC에 익숙한 우리는 잘 쓰지 않음.
- 자동으로 메모리에 할당을 올리고 내리는 일을 하는 것.
- 매를 5천대 한번에 맞고 한번에 회복하느냐, 1천대 맞고 회복하고, 또 1천대맞고 회복하고 이걸 5번하는것 의 차이(한번에 5천대 맞을 내공(메모리)이 안되면 죽을수도있으니까)

```swift
func loadImage() {
    for _ in 0..<5000 {
        UIImage(contentsOfFile: "something")
    }
}
```
- 이렇게하면 5000번 이미지를 불러올 동안 5000개의 이미지가 메모리안에 존재하게 된다. 이 때 메모리가 부족하다면 App이 죽을 수도 있음

 ```
func loadImageWithAutoLease() {
    for _ in 0..<5 {
        autoreleasepool {
            for _ in 0..<1000 {
                UIImage(contentsOfFile: "something")
            }
        }
    }
}
```
이렇게 하면 5번에 걸쳐서 1000개를 올리고 autoleasePool이 비워진 후 다시 1000개를 올리는 식으로 조절