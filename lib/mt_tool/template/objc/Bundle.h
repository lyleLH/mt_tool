//
//  <%= @prefixed_module %>Bundle.h
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface <%= @prefixed_module %>Bundle : NSObject

+ (UINib *)bundlerNib:(NSString *)nibName ;
+ (NSBundle *)currentBundle;

@end

NS_ASSUME_NONNULL_END
