//
//  TestClass.h
//  ObjCRuntimeDemo
//
//  Created by kunge on 2018/1/7.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject<NSCoding, NSCopying>
@property (nonatomic, strong) NSArray *publicProperty1;
@property (nonatomic, strong) NSString *publicProperty2;

+ (void)classMethod: (NSString *)value;
- (void)publicTestMethod1: (NSString *)value1 Second: (NSString *)value2;
- (void)publicTestMethod2;

- (void)method1;
@end
