//
//  <%= @prefixed_module %>Bundle.m
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//

#import "<%= @prefixed_module %>Bundle.h"

@implementation <%= @prefixed_module %>Bundle

+ (UINib *)bundlerNib:(NSString *)nibName {
    return  [UINib nibWithNibName:nibName bundle:[self currentBundle]];
}

+ (NSBundle *)currentBundle {
    NSString *bundleName = @"<%= @project %>";
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    if (!associateBundleURL) {
        NSBundle *subBundle = [NSBundle bundleForClass:self];
        associateBundleURL = [subBundle URLForResource:bundleName withExtension:@"bundle"];
    }
    NSBundle *bundle = [NSBundle bundleWithURL:associateBundleURL];
    return bundle;
}

@end