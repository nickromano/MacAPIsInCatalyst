//
//  MacBundle.m
//  MacBundle
//
//  Created by Nicholas Romano on 6/22/20.
//  Copyright © 2020 Ten Minute Wait. All rights reserved.
//

#import "MacBundle.h"

@implementation MacBundle

+ (NSDictionary *)runShell:(NSArray<NSString *> *)arguments workingDirectory:(NSURL *)workingDir {
  NSTask *task = [[NSTask alloc] init];
  task.launchPath = @"/usr/bin/env";

  [task setCurrentDirectoryPath:workingDir.path];

  NSPipe * output = [NSPipe pipe];
  [task setStandardOutput:output];

  task.arguments = arguments;
  [task launch];
  [task waitUntilExit];

  NSFileHandle * read = [output fileHandleForReading];
  NSData * dataRead = [read readDataToEndOfFile];
  NSString * stringRead = [[NSString alloc] initWithData:dataRead encoding:NSUTF8StringEncoding];

  return @{
    @"output": stringRead,
    @"code": @(task.terminationStatus)
  };
}

@end
