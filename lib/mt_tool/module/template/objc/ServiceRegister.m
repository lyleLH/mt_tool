//
//  <%= @prefixed_module %>ServiceRegister.m
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

#import "<%= @prefixed_module %>ServiceRegister.h"
#import <MTBaseKit/MTBaseKitHeader.h>

#import "<%= @prefixed_module %>ServiceProtocol.h"


#import "<%= @prefixed_module %>DemoViewModel.h"


@implementation <%= @prefixed_module %>ServiceRegister

@MTModuleServiceRegister(){
    MTModuleServiceRegisterExecute(<%= @prefixed_module %>DemoViewModel.class, @protocol(<%= @prefixed_module %>ServiceProtocol), nil);
}


@end
