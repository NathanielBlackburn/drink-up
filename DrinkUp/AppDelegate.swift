import UIKit
import Kingfisher

final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        configureKingsfisher()

        return true
    }

    private func configureKingsfisher() {
        let kingfisherCache = Kingfisher.ImageCache.default
        kingfisherCache.clearMemoryCache()
        kingfisherCache.clearDiskCache()
    }
}
