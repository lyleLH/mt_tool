//
//  <%= @prefixed_module %>RouterRegister.m
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

#import "<%= @prefixed_module %>RouterRegister.h"

#import <MTBaseKit/MTBaseKitHeader.h>
#import <MTCategoryComponent/MTCategoryComponentHeader.h>

#import "<%= @prefixed_module %>RouterDefine.h"

#import "<%= @prefixed_module %>DemoViewController.h"

#import <<%= @module %>/<%= @module %>-Swift.h>

@implementation <%= @prefixed_module %>RouterRegister

@MTRouterRegister() {

[[MTRouterComponent shareInstance] registerUrlPartterns:kDemoRouterString error:nil action:^(MTRouterUrlRequest * _Nonnull urlRequest, MTRouterUrlCompletion  _Nonnull completetion) {

        <%= @prefixed_module %>DemoViewController *vc = [[<%= @prefixed_module %>DemoViewController alloc] init];
        [[UIViewController mt_topViewController].navigationController pushViewController:vc animated:YES];

    }];

}

@end
