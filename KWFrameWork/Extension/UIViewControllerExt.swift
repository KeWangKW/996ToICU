//
//  UIViewControllerExt.swift
//  BaseSwift
//
//  Created by 渴望 on 2020/5/25.
//  Copyright © 2020 渴望. All rights reserved.
//

import UIKit


extension UIViewController {
//MARK: 获取当前活动控制器
    /// 获取当前活动控制器
    @objc class func kw_currentController() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows
            for wind in windows {
                if wind.windowLevel == .normal {
                    window = wind
                    break
                }
            }
        }
        let controller = window?.rootViewController
        return UIViewController.getCurerentController(controller)
    }
    
    
    private static func getCurerentController(_ controller: UIViewController?) -> UIViewController? {
        guard controller != nil else { return nil }
        
        if let presentController = controller?.presentedViewController {
            return getCurerentController(presentController)
        }
        else if let tabBarController = controller as? UITabBarController {
            return getCurerentController(tabBarController.selectedViewController)
        }
        else if let navController = controller as? UINavigationController {
            return getCurerentController(navController.visibleViewController)
        }
        else {
            return controller
        }
    }
    
//MARK: 当前是否正在显示
    /// 当前是否正在显示
    @objc var isVisible: Bool {
        return (self.isViewLoaded && self.view.window != nil)
    }
    
//MARK: 返回控制器
    /// 返回控制器
    /// - Parameters:
    ///   - index: 第几个  返回上一个 传2 依次增加
    ///   - animated: 动画
    @objc func popViewController(index: Int, animated: Bool) {
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        guard viewControllers.count >= index else { return }
        let controller = viewControllers[viewControllers.count - index]
        self.navigationController?.popToViewController(controller, animated: animated)
    }
    
//MARK: 添加子控制器
    /// 添加子控制器
    /// - Parameter controllers: 控制器
    // @objc func addChild(controllers: UIViewController...) {
    @objc func addChild(controllers: [UIViewController]) {
        controllers.forEach {
            self.addChild($0)
            self.view.addSubview($0.view)
            $0.didMove(toParent: self)
        }
    }
    
//MARK: 弹出系统底部选择框
    /// 弹出系统底部选择框
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - cancel: 取消按钮文字
    ///   - buttonTitles: [按钮文字]
    ///   - completion: 点击回调
    /// - Returns: UIAlertController.actionSheet
    @discardableResult
    @objc func showSheet(_ title: String?, message: String?, cancel: String? = "取消", buttonTitles: [String]?, completion: ((Int) -> Void)? = nil) -> UIAlertController? {
        guard let buttons = buttonTitles, buttons.count > 0 else { return nil}
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for idx in 0..<buttons.count {
            let action = UIAlertAction(title: buttons[idx], style: .default) { (_) in
                completion?(idx)
            }
            sheet.addAction(action)
        }
        if let cancelTitle = cancel {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            sheet.addAction(cancelAction)
        }
        self.present(sheet, animated: true, completion: nil)
        return sheet
    }
    
}

