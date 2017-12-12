//
//  AppDelegate.h
//  DropViewDemo
//
//  Created by 浩哥哥 on 2017/12/12.
//  Copyright © 2017年 浩哥哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

