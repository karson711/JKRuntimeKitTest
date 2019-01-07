//
//  JKRuntimeKit.m
//  ObjCRuntimeDemo
//
//  Created by kunge on 2018/1/7.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "JKRuntimeKit.h"

@implementation JKRuntimeKit

/**
 获取类名

 @param class 相应类
 @return NSString：类名
 */
+ (NSString *)fetchClassName:(Class)class {
    //char类型的指针
    const char *className = class_getName(class);
    //转换成字符串
    return [NSString stringWithUTF8String:className];
}

/**
 获取成员变量
 
 @param class Class
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        ////获取成员变量名称
        const char *ivarName = ivar_getName(ivarList[i]);
        //获取成员变量类型
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String: ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String: ivarName];
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表, 包括私有和公有属性，以及定义在延展中的属性
 
 @param class Class
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class {
    unsigned int count = 0;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String: propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}


/**
 获取类的实例方法列表：getter, setter, 对象方法等。但不能获取类方法

 @param class class
 @return 实例方法名称数组
 */
+ (NSArray *)fetchMethodList:(Class)class {
    unsigned int count = 0;
    //获取类的实例方法列表
    Method *methodList = class_copyMethodList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        //获取每个方法的名称
        SEL methodName = method_getName(method);
        //转换成NSString类型
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取协议列表
 
 @param class class
 @return 协议名称数组
 */
+ (NSArray *)fetchProtocolList:(Class)class {
    unsigned int count = 0;
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        //获取协议的名称
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String: protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
    return nil;
}


/**
 往类上添加新的方法与其实现

 @param class 相应的类
 @param methodSel 方法的名
 @param methodSelImpl 对应方法实现的方法名
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl {
    Method method = class_getInstanceMethod(class, methodSelImpl);
    //IMP其实就是Implementation的方法缩写
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    //将IMP与SEL进行绑定
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 方法交换
 如果将MethodA与MethodB的方法实现进行交换的话，调用MethodA时就会执行MethodB的内容，反之亦然
 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}
@end
