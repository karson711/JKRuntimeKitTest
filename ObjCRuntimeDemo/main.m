//
//  main.m
//  ObjCRuntimeDemo
//
//  Created by kunge on 2018/1/7.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import "TestClass+Category.h"
#import "TestClass+SwapMethod.h"

#import "TestClass+AssociatedObject.h"

#import "JKRuntimeKit.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *className = [JKRuntimeKit fetchClassName:[TestClass class]];
        NSLog(@"测试类的类名为：%@\n", className);
        
        NSArray *ivarList = [JKRuntimeKit fetchIvarList:[TestClass class]];
        NSLog(@"\n获取TestClass的成员变量列表:%@", ivarList);
        
        NSArray *propertyList = [JKRuntimeKit fetchPropertyList:[TestClass class]];
        NSLog(@"\n获取TestClass的属性列表:%@", propertyList);
        
        NSArray *methodList = [JKRuntimeKit fetchMethodList:[TestClass class]];
        NSLog(@"\n获取TestClass的方法列表：%@", methodList);
        
        NSArray *protocolList = [JKRuntimeKit fetchProtocolList:[TestClass class]];
        NSLog(@"\n获取TestClass的协议列表：%@", protocolList);
        TestClass *instance = [TestClass new];
        [instance publicTestMethod2];
        [instance performSelector:@selector(noThisMethod:) withObject:@"实例方法参数"];
        
        instance.dynamicAddProperty = @"我是动态添加的属性";
        NSLog(@"%@", instance.dynamicAddProperty);
        
        
        [instance swapMethod];
        [instance method1];
        
    }
    return 0;
}
