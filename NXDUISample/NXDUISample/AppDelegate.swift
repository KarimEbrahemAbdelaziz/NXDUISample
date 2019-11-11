//
//  Copyright © 2019 N26. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let wrapper = ViewModelWrapper(viewClosure: DemoView.init)
        let presetner = DemoPresenter(view: wrapper)
        let viewController = NXDUIHostingController(
            wrapper: wrapper,
            lifecycleObserver: presetner
        )
        
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()
        return true
    }
}

