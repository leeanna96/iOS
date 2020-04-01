import UIKit
import UserNotifications
/*
 1. UNMutableNotificationContent // 알림에 필요한 메시지와 같은 기본적인 속성을 담는 알림 콘텐츠 역할, 속성을 설정할 때 사용
    UNNotificationcontent // 수정이 불가능하며 객체로부터 속성을 읽어 들일 수만 있는 특성을 가짐
 2. UNTimeIntervalNotificationTrigger // 알림 발송 조건 관리, 발생 시각과 반복 여부, 임력값의 단위는 초
 3. UNNotificationRequest // 알림 요청 객체와 알림 발송 조건 객체를 인자값으로 하여 이 클래스를 초기화하면 그 결과로 알림 요청 객체가 생성
 4, UNUserNotificationCenter // 실제 발송 담당하는 센터, 등록된 알림 내용을 확인하고 정해진 시각에 발송하는 역할, current()를 통해 참조 정보만 가져올 수 있음
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { // 앱이 처음 실행될 때 호출되는 메소드
        // Override point for customization after application launch.
        if #available(iOS 11.0, *){
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 사용자 동의 여부 창을 실행
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]){
                (didAllow, e) in}
            notiCenter.delegate = self // 사용자가 알림을 클릭했을 때 이를 감지할 수 있도록 할 때 추가된 부분
        } else {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 이를 애플리케이션에 저장
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(setting) // 알림 허용여부를 사용자에게 확인받고, 사용자의 선택을 애플리케이션에 등록하는 역할
            
            if let localNoti = launchOptions?[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification {
                // 알림으로 인해 앱이 실행된 경우. 이때에는 알림과 관련된 처리를 해 준다.
                print((localNoti.userInfo?["name"])!)
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 11.0, *){ // UserNotification 프레임워크를 이용한 로컬 알림(iOS 10 이상)
            // 알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings{
                settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    // 알림 콘텐츠 객체
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!"
                    nContent.body = "앗! 왜 나갔어요?? 어서 들어오세요!"
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name":"홍길동"]
                    
                    // 알림 발송 조건 객체
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    // 알림 요청 객체
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    // 노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request)
                } else { // UILocalNotification 객체를 이용한 로컬 알림(iOS 9 이하)
                    print("사용자가 동의하지 않음!")
                }
                /*
                 1. 사용자로부터 알림이 허용되어 있는지 체크
                 2. UIMutableNotificationContent 클래스를 사용하여 알림 콘텐츠 객체를 생성
                 3. 앱 아이콘에 표시될 배지의 값을 1로 표시
                 4. 타이틀과 서브 타이틀을 입력
                 5. 알림 메시지를 설정
                 6. 사운드 속성을 설정. UNNotificationSound 클래스의 default() 메소드를 호출하여 기본 사운드를 설정
                 7. UNTimeIntervalNotificationTrigger 클래스를 초기화하여 알림 발송 조건을 지정한 객체를 생성. 시간은 5초 뒤로 설정, 반복하지 않고 한 번만 발송
                 8. UNNotificationRequest 클래스를 초기화하여 알림 요청 객체를 생성. 알림 요청 객체의 아이디로 설정된 "wakeup"은 등록된 알림 요청을 취소하거나, 사용자가 어느 알림 메시지를 클릭했는지 식별할 때 사용. 나머지 인자값으로 알림 콘텐츠와 알림 발송 조건 객체가 사용
                 9. 생성된 알림 요청 객체를 노티피케이션 센터에 추가. 노티피케이션 센터는 iOS의 스케줄링 센터에 이 값을 등록, 정해진 시간에 발송되도록 처리
                 */
            }
        } else {
            // 알림 설정 확인
            let setting = application.currentUserNotificationSettings // 현재 설정된 알림 허용 여부 정보 읽어옴
            // 알림 설정이 되어 있지 않다면 로컬 알림을 보내도 받을 수 없으므로 종료
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }
            // 로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10) // 10초 후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent // 현재 위치에 따라 타임존 설정
            noti.alertBody = "얼른 다시 접속하세요!!" // 표시될 메시지
            noti.alertAction = "학습하기" // 잠금 상태일 때 표시될 액션
            noti.applicationIconBadgeNumber = 1 // 앱 아이콘 모서리에 표시될 배지
            noti.soundName = UILocalNotificationDefaultSoundName // 로컬 알람 도착시 사운드
            noti.userInfo = ["name":"홍길동"] // 알람 실행시 함께 전달하고 싶은 값, 화면에는 표시되지 않음
            
            // 생성된 알람 객체를 스케줄러에 등록
            application.scheduleLocalNotification(noti) // 생성된 알림 객체를 iOS의 스케줄러에 등록, 등록된 알림 객체는 fireDate 속성에 설정된 시간에 맞게 발송
            // .presentLocalNotificationNow(_:) 생성된 알림 객체의 fireDate 속성을 무시하고, 즉각 발송
            
        }
    }
    
    // 앱 실행 도중에 알림 메시지가 도착한 경우
    @available(iOS 11.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "wakeup"{
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        // 알림 배너 띄워주기
        completionHandler([.alert, .badge, .sound])
    }
    // 사용자가 알림 메시지를 클릭했을 경우
    @available(iOS 11.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup"{
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification){
        print((notification.userInfo?["name"])!)
        if application.applicationState == UIApplication.State.active {
            // 앱이 활성화 된 상태일 때 실행할 로직
        } else if application.applicationState == .inactive {
            // 앱이 비활성화된 상태일 때 실행할 로직
        }
    }
}

