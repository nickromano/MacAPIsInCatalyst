//
//  MacBundle.h
//  MacBundle
//
//  Created by Nicholas Romano on 6/22/20.
//  Copyright © 2020 Ten Minute Wait. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MacBundle : NSObject

+ (NSDictionary *)runShell:(NSArray<NSString *> *)arguments workingDirectory:(NSURL *)workingDir;

@end

NS_ASSUME_NONNULL_END
