
//
//  <%= @prefixed_module %>RouterDefine.swift
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//


import Foundation

public struct <%= @prefixed_module %>RouterConstants {
    static let <%= @prefixed_module %>DemoPage = "k<%= @prefixed_module %>DemoPage"
   /// 添加你自己的路由字符串常量 here ...

}

@objcMembers open class <%= @prefixed_module %>_Swift_RouterDefine: NSObject {
    private override init() {}

   public class func demoPage() -> String {
       <%= @prefixed_module %>RouterConstants.<%= @prefixed_module %>DemoPage
   }

    /// 添加你自己的路由定义 here ...

 }
