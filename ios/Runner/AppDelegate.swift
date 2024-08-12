import Flutter
import UIKit
import Photos

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        requestPhotoLibraryAccess()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            // Ruxsat berilgan
            break
        case .denied, .restricted:
            // Ruxsat berilmagan
            break
        case .notDetermined:
            // Ruxsat so'ralmoqda
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    // Ruxsat berildi
                    break
                case .denied, .restricted:
                    // Ruxsat berilmadi
                    break
                default:
                    break
                }
            }
        default:
            break
        }
    }
}
