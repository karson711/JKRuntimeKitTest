//
//  TestClass+AssociatedObject.h
//  ObjCRuntimeDemo
//
//  Created by kunge on 2017/1/5.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "TestClass.h"
#import "JKRuntimeKit.h"
@interface TestClass (AssociatedObject)
@property (nonatomic, strong) NSString *dynamicAddProperty;
@end

