//
//  <%= @prefixed_module %>DemoViewModel.h
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

#import <Foundation/Foundation.h>

#import "<%= @prefixed_module %>ServiceProtocol.h"
@interface <%= @prefixed_module %>DemoViewModel : NSObject <<%= @prefixed_module %>ServiceProtocol>

@end
