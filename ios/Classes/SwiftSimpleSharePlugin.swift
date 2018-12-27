import Flutter
import UIKit

public class SwiftSimpleSharePlugin: NSObject, FlutterPlugin {

    let controller : FlutterViewController = UIApplication.shared.keyWindow?.rootViewController as! FlutterViewController

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.juanito21.simpleShare/share", binaryMessenger: registrar.messenger())
        let instance = SwiftSimpleSharePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if ("share" == call.method) {
            
            let args = call.arguments as? [String: Any?]
            
            let title = args!["title"] as? String
            //let message = args!["message"] as? String
            let fileUrl = args!["uri"] as? String
            
            var sharedItems : Array<Any> = Array()
            
            //File url
            if let path = fileUrl, fileUrl != "" {
                do {
                    let URLString: String = path
                    let shareURL: URL = URL(fileURLWithPath: URLString)
                    //                    let shareData: NSData = try NSData(contentsOf: shareURL as URL)
                    let shareData = try Data(contentsOf: shareURL as URL)
                    sharedItems.append(shareData)
                } catch {
                    result(FlutterError(code: "ERROR",
                                        message: error.localizedDescription,
                                        details: nil))
                }
                
            }else if let msg = args!["msg"] as? String, !msg.isEmpty {
                sharedItems.append(msg)
            }else{
                result(FlutterError(code: "ERROR",
                                    message: "fileUrl is nil or empty",
                                    details: nil))
            }
            
            
            let activityViewController = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
            
            //            activityViewController.popoverPresentationController?.sourceView = self.viewController?.view // so that iPads won't crash
            
            if (title != nil && title != "") {
                activityViewController.setValue(title, forKeyPath: "subject");
            }
            
            controller.present(activityViewController, animated: true, completion: nil)
            
            result(nil)
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
