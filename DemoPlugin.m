//
//  DemoPlugin.m
//  Demo
//
//  Created by fernyb on 2/23/10.
//  Copyright 2010 Fernando Barajas. All rights reserved.
//

#import <Growl/GrowlApplicationBridge.h>
#import "JVChatMessage.h"
#import "JVChatWindowController.h"
#import "MVChatConnection.h"
#import "JVPreferencesController.h"

#import "DemoPlugin.h"


#define kAppName @"Colloquy"


@implementation DemoPlugin

- (id)initWithManager:(MVChatPluginManager *) manager
{
  //NSLog(@"Init With Manager");
  return self;  
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
  //NSLog(@"respondsToSelector: %@", NSStringFromSelector(aSelector));
  return [super respondsToSelector:aSelector];
}

- (void)processIncomingMessage:(JVMutableChatMessage *)message inView:(id <JVChatViewController>)view
{
  NSString * title = [message senderNickname];
  NSString * description = [message bodyAsPlainText];
  
  //
  // Notification Types are in the Colloquy Project:
  // Resources/notifications.plist
  // that will list all the notification types that can be used.
  // Otherwise sending an invalid notificationName will not display growl.
  //
  NSString * notificationName = @"JVPluginNotification";
  
  //
  // notificationIdentifier is the id for the growl notification message being displayed.
  // Using the same one for all messages will only show 1 growl window having all messages
  // sending multiple messages at one time will only display in that id. Using all unique ids
  // then a new growl window will be displayed for the messages
  //
  //NSString * notificationIdentifier = @"GrowlPluginIdentifier";
  NSDate * date = [[NSDate date] dateByAddingTimeInterval:3600];
  NSString * notificationIdentifier = [NSString stringWithFormat:@"GrowlPluginIndentifier-%d", date];
  
  NSImage * icon = [[NSApplication sharedApplication] applicationIconImage];  
  
  NSDictionary * notification = [NSDictionary dictionaryWithObjectsAndKeys:
                                kAppName, GROWL_APP_NAME,
                                notificationName, GROWL_NOTIFICATION_NAME,
                                title, GROWL_NOTIFICATION_TITLE,
                                description, GROWL_NOTIFICATION_DESCRIPTION,
                                notificationIdentifier, GROWL_NOTIFICATION_IDENTIFIER,
                                [icon TIFFRepresentation], GROWL_NOTIFICATION_ICON,
                                 
                                // this next key is not guaranteed to be non-nil
                                // make sure it stays last, unless you want to ensure it's non-nil
                                //YES, GROWL_NOTIFICATION_STICKY,
                                nil];
  
  [GrowlApplicationBridge notifyWithDictionary:notification];
}


- (void)processOutgoingMessage:(JVMutableChatMessage *)message inView:(id <JVChatViewController>)view
{
 // NSLog(@"*** Outgoing Message: %@", message);
}


- (void)connected:(MVChatConnection *)connection
{
  NSLog(@"Connected");
}

- (NSArray *)contextualMenuItemsForObject:(id/*JVChatRoomPanel*/)object inView:(id/*JVChatRoomPanel*/<JVChatViewController>)view
{
  NSLog(@"contextualMenuItemsForObject:");
  NSLog(@"className: %@", [object className]);
  NSLog(@"className: %@", [view performSelector:@selector(className)]);
  
  return [NSArray array];
}


- (void)setupPreferencesWithController:(JVPreferencesController *)controller
{
  NSLog(@"Setup Preferences With Controller");
  
}

- (void) performNotification:(NSString *) identifier withContextInfo:(NSDictionary *) context andPreferences:(NSDictionary *) preferences
{  
  NSLog(@"Perform Notification WithContextInfo andPreferences");
}


@end
