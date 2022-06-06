//
//  InputAlert.swift
//  Ngondro Tracker
//
//  Created by Karol Moroz on 06/06/2022.
//

import UIKit

struct AlertHelpers {
  static func keyWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes
      .filter { $0.activationState == .foregroundActive }
      .compactMap { $0 as? UIWindowScene }
      .first?.windows.filter { $0.isKeyWindow }.first
  }

  static func topMostViewController() -> UIViewController? {
    guard let rootController = keyWindow()?.rootViewController else {
      return nil
    }
    return topMostViewController(for: rootController)
  }

  static func topMostViewController(for controller: UIViewController) -> UIViewController {
    if let presentedController = controller.presentedViewController {
      return topMostViewController(for: presentedController)
    } else if let navigationController = controller as? UINavigationController {
      guard let topController = navigationController.topViewController else {
        return navigationController
      }
      return topMostViewController(for: topController)
    } else if let tabController = controller as? UITabBarController {
      guard let topController = tabController.selectedViewController else {
        return tabController
      }
      return topMostViewController(for: topController)
    }
    return controller
  }
}
