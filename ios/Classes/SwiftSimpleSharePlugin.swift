import Flutter
import UIKit

public class SwiftSimpleSharePlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.juanito21.simpleShare/share", binaryMessenger: registrar.messenger())
        let instance = SwiftSimpleSharePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        if ("share" == call.method) {
            
            let args = call.arguments as? [String: Any?]
            
            let title = args!["title"] as? String
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

            if activityViewController.modalPresentationStyle == .popover {
                if let topController = UIApplication.shared.keyWindow?.rootViewController {
                    if let presentedView = topController.view {
                        activityViewController.popoverPresentationController?.sourceView = presentedView // so that iPads won't crash
                        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: presentedView.bounds.midX, y: presentedView.bounds.midY, width: 0, height: 0)
                    }
                }
            }
            
            if (title != nil && title != "") {
                activityViewController.setValue(title, forKeyPath: "subject");
            }
            
            UIApplication.shared.keyWindow?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            
            result(nil)
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
