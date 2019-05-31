//
//  JWAppUpdateTipKit.swift
//  JWAppUpdateTipKit
//
//  Created by jw10126121 on 2019年5月22日.
//  Copyright © 2019 JWAppUpdateTipKit. All rights reserved.
//

//@_exported
import UIKit


/// App更新提示渠道
public enum JWAppUpdateChannel {
    
    case fir(appId: String, token: String)
    
//    case appStore(appId: String)
    
    var requestApi: String {
        switch self {
        case let .fir(appId, token):
            return "http://api.fir.im/apps/latest/\(appId)?api_token=\(token)"
//        case let .appStore(appId: appId):
//            return "https://itunes.apple.com/cn/app/id\(appId)"
        }
    }
    
    
    
    
}

/// app更新提示管理类
public class JWAppCheckUpdateManager {
    
    /// 渠道
    private let channel: JWAppUpdateChannel
    
    public init(channel: JWAppUpdateChannel) { self.channel = channel }
    
    public func update() {
        
        switch channel {
        case .fir:
            firUpdate(requestApi: channel.requestApi)
            break
//        case .appStore:
//            appStoreUpdate(requestApi: channel.requestApi)
//            break
        }
        
    }
    
    /// MARK - fir更新通知
    private func firUpdate(requestApi: String) {
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let requestUrl = URL(string: requestApi) else {
            return
        }
        let request = URLRequest(url: requestUrl)
        session.dataTask(with: request) { (data, response, error) in
            
            if let temData = data,
                let result = try? JSONSerialization.jsonObject(with: temData, options: .mutableContainers) as? [String: Any],
                let versionShort = result["versionShort"] as? String,
                let bundleVersion = result["version"] as? String,
                let updateUrl = result["update_url"] as? String
            {
                
                /// 修改资料
                let changelog = result["changelog"] as? String ?? ""
                /// 本地版本号
                let localVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
                /// 本地编译版本号
                let localBundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                /// 版本号比较
                if (Int(localBundleVersion)! - Int(bundleVersion)! < 0 || localVersion.compare(versionShort) == ComparisonResult.orderedAscending) {
                    
                    let messageString = "新版本" + "\(versionShort)(\(bundleVersion))," + "是否更新?"
                    let alertController = UIAlertController(title: messageString, message: changelog, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: "更新", style: .default) { _ in
                        if let url = URL(string: updateUrl) {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            } else {
                                UIApplication.shared.openURL(url)
                            }
                        }
                    })
                    
            
                    if  let message = alertController.view.subviews[0]
                        .subviews[0]
                        .subviews[0]
                        .subviews[0]
                        .subviews[0]
                        .subviews[1] as? UILabel {
                        message.textAlignment = .left
                    }
                    guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
                        return
                    }
                    vc.present(alertController, animated: true, completion: nil)
                }
            }
            }.resume()
    }
    
    private func appStoreUpdate(requestApi: String) {
        
    }
    
    
    
}
