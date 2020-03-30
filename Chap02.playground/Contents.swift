/*
 엔트리 포인트(Entry Point, 시작 진입점)
 
 UIApplication 객체와 AppDelegate 객체가 연관되어 앱이 실행되는 전체 과정
 1. main() 함수가 실행
 2. main() 함수는 다시 UIApplicationMain() 함수를 호출
 3. UIApplicationMain() 함수는 앱의 본체에 해당하는 UIApllication 객체를 생성
 4. UIApplication 객체는 Info.plist 파일을 바탕으로 앱에 필요한 데이터와 객체를 로드
 5. AppDelegate 객체를 생성하고 UIApplication 객체와 연결
 6. 이벤트 루프를 만드는 등 실행에 필요한 준비를 진행
 7. 실행 완료 직전, 앱 델리게이트의 application(_: didFinishLaunchingWithOptions:)메소드를 호출
 
 앱이 실행 목적을 모두 완료하고 더이상 사용되지 않으면 시스템은 앱을 메모리에서 제거하기 위한 준비
 : 앱 시스템은 델리게이트 클래스의 applicationWillTerminate(_:)메소드를 호출
 
 iOS 앱의 객체 관계 : MVC 패턴(소스 코드 설계 기법)
 모델(Model) : 데이터를 담당
 뷰(View) : 데이터에 대하 화면 표현을 담당
 컨트롤러(Controller) : 모델과 뷰 사이에 위치하여 데이터를 가공하여 뷰로 전달하고, 뷰에서 발생하는 이벤트를 입력받아 처리하는 역할 담당
 
 * 앱의 상태 변화
 Not Running : 앱이 시작되지 않았거나 실행되었지만 시스템에 의해 종료된 상태
 Inactive : 앱이 전면에서 실행 중이지만, 아무런 이벤트를 받지 않고 있는 상태
 Active : 앱이 전면에서 실행 중이며, 이벤트를 받고 있는 상태
 Background : 앱이 백그라운드에 있지만 여전히 코드가 실행되고 있는 상태
                파일 다운로드나 업로드, 연산 처리 등 여분의 실행 시간이 필요한 앱일 경우 특정 시간 동안 이 상태로 남아 있음
 Suspended : 앱이 메모리에 유지되지만 실행되는 코드가 없는 상태, 메모리가 부족한 상황이 오면 Suspended 상태에 있는 앱들을 특별한 알림 없이 정리
 
 application(_:willFinishLaunchingWithOptions:)
 앱이 구동되어 필요한 초기 실행 과정이 완료되기 직전 호출
 
 application(_:didFinishLaunchingWithOptions:)
 앱이 사용자에게 화면으로 표시되기 직전 호출, 앱이 실행된 후에 진행할 커스터마이징이나 초기화를 위한 코드를 여기에 작성
 
 applicationDidBecomeActive(_:)
 실행된 앱이 포그라운드, 화면 전면에 표시될 때 호출, Inactive 상태에 들어가며 일시 중지된 작업이 있다면 이를 재시작하는 코드를 여기에 작성
 ex)타이머나 스톱워치 앱의 경우, 화면과 남은 시각 등을 갱신
 
 applicationDidEnterBackground(_:)
 앱이 백그라운드 상태에 진입했을 때 호출
 잃어서는 안 되는 사용자 데이터를 종료 전에 미리 저장하거나, 공유 자원을 점유하고 있었다면 이를 해제해 주어야 함
 종료된 앱이 다시 실행될 때 현재의 상태를 복구할 수 있도록 필요한 상태 정보도 이 메소드에서 저장 처리
 
 applicationWillTerminate(_:)
 앱이 종료되기 직전 호출, 사용자 데이터 등을 종료 전에 한 번 더 저장
 
 * 프레임워크
 애플리케이션 제작을 빠르고 편리하게 할 수 있도록 미리 뼈대를 이루는 각종 코드를 제작하여 모아둔 것
 
 import Foundation // 파운데이션 프레임워크, 네트워크나 날짜 연산 등의 기능 처리
 import WebKit // 웹킷 프레임워크, 웹과 관련된 기술 구현
 import AddressBookUI // 주소록 UI 프레임워크, 주소록 화면 관련 기능 구현
 import UserNotifications // 사용자 알림 프레임워크
 import CoreAnimation // 코어 애니메이션 프레임워크, 애니메이션 처리
 
 네이티브 앱 : iOS 시스템 프레임워크를 기반으로 하고 스위프트 또는 오브젝티브-C 언어로 개발되며 iOS를 통해 직접 실행되는 앱
 
 코코아 터치 프레임워크
 : 하드웨어와 앱 사이를 중계해주는 iOS 인터페이스
 : 애플 환경에서 터치 기반의 애플리케이션을 제작하기 위한 도구들의 모음
 
 Foundation Framework : 애플리케이션의 핵심 객체와 네트워크, 문자열 처리 등의 서비스 제공 // 내부적으로 돌아가는 기능
 UIKit Framework : 아이폰이나 아이패드, 애플 와치나 애플TV 등에서 실행되는 애플리케이션의 유저 인터페이스를 제공 // iOS 앱으로서의 특징적인 부분
 GameKit Framework : 게임 실행 시 게임 센터를 연동하거나 근거리 P2P 연결을 제공
 iAd Framework : 앱 내에 배너 형태 또는 팝업 형태의 광고를 삽입할 수 있도록 해 주는 광고 관련
 MapKit Framework : 위치 정보나 지도 관련 서비스를 이용
 Address Book UI Framework : 번들 애플리케이션으로 제공되는 주소록 앱의 인터페이스와 기능을 커스텀 앱 내에서도 그대로 사용
 EventKit UI Framework : 이벤트 처리에 필요한 유저 인터페이스를 제공
 Message UI Framework : 번들 애플리케이션으로 제공되는 메시지 앱의 인터페이스와 기능을 커스텀 앱 내에서도 그대로 사용
 UserNotifications Framework : 사용자 알림을 처리하기 위해 필요한 객체들을 제공
 WebKit Framework : 웹 관련 기능을 구현하기 위해 필요한 객체들을 제공
 
 코코아 프레임워크 : macOS
 코코아 터치 프레임워크 : iOS, watchOS, tvOS
 
 iOS에서의 프레임워크 계층 구조
 Cocoa Touch // 애플리케이션 프레임워크 계층
 Media // 그래픽 관련 서비스, 멀티미디어 관련 서비스
 Core Service // 문자열 처리, 데이터 집합 관리, 네트워크, 주소록 관리, 환경 설정 등, GPS, 나침반, 가속도 센서, 자이로스코프 센서
 Core OS // 커널, 파일 시스템, 네트워크, 보안, 전원 관리, 디바이스 드라이버 등이 포함
 
 Foundation Framework[NS]
 : NSDate, NSData, NSURL, NString, NSLog, NSArray, NSRange, NSSearchPathForDirectorieslnDomains, NSDictionary, NSException
 UIKit Framework[UI]
 : UIApplication, UIViewController, UIView, UIButton, UIBarButtonItem, UIImageView, UIControl, UIResponder
 UserNotifications Framework[UN]
 : UNNotification, UNNotificationContent, UNNotificationRequest, UNNotificationResponse, UNNotificationTrigger
 MapKit Framework[MK]
 : MKAnnotationView, MKCircle, MKDirections, MKLocalSearch, MKMapItem, MKMapShapshot, MKMapView, MKOverlayView
 Core Foundation[CF]
 : CFBundle, CFData, CFDate, CFError, CFBoolean, CFRunLoop, CFSocket, CFPlugIn, CFXMLParser, CFUUID, CFUserNotification
 Core Graphics[CG]
 : CGColor, CGContext, CGImage, CGGradient, CGLayer, CGPoint, CGRect, CGSize, CGAffineTransform, CGPattern, CGPath
 AVFoundation[AV]
 : AVAssetReader, AVAssetResourceLoadingRequest, AVAssetInputGroup, AVAudioConverter, AVAudioEngine, AVAudioBuffer, AVAudioUnit
 
 씬(Scene) : 스토리보드를 통해 편집하는 대부분의 뷰 컨트롤러들은 각자가 하나씩의 화면을 담당하여 콘텐츠를 표현하고 뷰를 관리
 콘텐츠 뷰 컨트롤러 : 씬을 담당하고 콘텐츠를 표시하는 뷰 컨트롤러
 컨테이너 뷰 컨트롤러 : 다른 뷰 컨트롤러의 연결 관계를 관리, 네비게이션 컨트롤러나 탭 바 컨트롤러, 페이지 컨트롤러 등
 
 뷰의 계층 구조
 슈퍼 뷰 : 뷰의 계층 구조 상에서 다른 뷰를 포함하는 뷰
 서브 뷰 : 슈퍼 뷰에 포함된 뷰
 
 View Controller : 앱의 데이터와 표시될 외형을 연결해서 하나의 동적인 화면을 만들어 내는 컨트롤러
 Navigation Controller : 앱의 화면 이동에 대한 관리와 그에 연관된 처리를 담당해주는 컨트롤러, 뷰를 포함하고 있지 않아 하나의 화면을 담당하지는 못하고 다른 컨트롤러와 결합하여 부분적으로 화면을 구성
 화면 이동을 처리, 현재의 페이지 위치에 대한 내비게이션 역할
 Table View Controller : 내부에 리스트 형식의 테이블 뷰를 포함하고 있어 여러 항목이나 데이터를 화면에 나열하기 위한 목적으로 사용되는 컨트롤러, 하나의 컨트롤러가 하나의 화면을 이룸
 Tab Bar Controller : 화면을 나타내는 여러 개의 탭이 있고, 탭을 터치하면 화면이 전환되는 형태의 앱을 만들고자 할 때 사용되는 컨트롤러, 직접 화면 전체를 나타내는 것이 아닌 복합적으로 화면을 구성
 Split View Controller : Master-Detail Application 템플릿을 선택하면 생성되는 기본 컨트롤러, 직접적인 화면을 구현하지 않음, 뷰 컨트롤러들을 화면의 크기에 따라 적절히 조합해주는 역할
 목록을 나열하는 마스터 페이지와 그 목록 각각에 대한 세부 내용을 보여주는 디테일 페이지로 구성
 
 * 뷰 컨트롤러 상태 변화
 Appearing : 뷰 컨트롤러가 스크린에 등장하기 시작한 순간부터 등장을 완료하기 직전까지의 상태, 퇴장 중인 다른 뷰 컨트롤러와 교차하기도 함. 퇴장 중인 다른 뷰 컨트롤러의 상태는 Disappearing
 Appeared : 뷰 컨트롤러가 스크린 전체에 완전히 등장한 상태
 Disappearing : 뷰 컨트롤러가 스크린에서 가려지기 시작해서 완전히 가려지기 직전까지의 상태, 또는 퇴장하기 시작해서 완전히 퇴장하기 직전까지의 상태, 등장 중인 다른 뷰 컨트롤러의 상태는 Appearing
 Disappeared : 뷰 컨트롤러가 스크린에서 완전히 가려졌거나 혹은 퇴장한 상태
 
 viewWillAppear(_:)
 화면이 처음 실행되거나 또는 퇴장한 상태에서 다시 등장하기 시작하는 상태로 바뀌는 동안 호출
 화면이 등장할 때마다 데이터를 갱신해 주고 싶다면, 이 메소드를 오버라이드하여 원하는 코드 작성
 
 viewDidAppear(_:)
 화면이 등장하기 시작한 단계를 넘어서 완전히 등장하고 나면 호출
 
 viewWillDisappear(_:)
 스크린에서 화면이 퇴장하는 상태 변화가 발생하면 호출
 
 viewDidDisappear(_:)
 스크린에서 화면이 퇴장하는 상태 변화가 완료 되었을 때 호출
 
 
 #생각해보기#
 1. 특정 화면에 진입했을 때 로그인이나 권한 여부를 체크하고 싶을 때
 2. 화면이 표시될 때마다 최신 데이터로 업데이트해주고 싶을 때
 3. 메모리 부족 시 가용 메모리를 확보하는 코드를 작성하고 싶을 때, 메모리 부족 체크?
 4. 화면이 완전히 표시되었는지 체크해서 알림창으로 공지를 띄워주고 싶을 때
 5. 사용자가 저장 버튼을 누르지 않아도 지금 화면 상태를 다음에도 유지하고 싶을 때?
 */
