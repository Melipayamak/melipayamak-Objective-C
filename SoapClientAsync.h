//
//  SoapClientAsync.h
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 11/26/19.
//  Copyright © 2019 Amirhossein Mehrvarzi. All rights reserved.
//

#ifndef SoapClientAsync_h
#define SoapClientAsync_h


#endif /* SoapClientAsync_h */

@interface SoapClientAsync : NSObject

@property NSMutableData *mutableData;
@property NSString *response;
@property NSString *sendingElementName;
@property NSString *currentElementName;
@property NSString *expectedElementName;

@property NSString *_sendEndpoint;
@property NSString *_receiveEndpoint;
@property NSString *_usersEndpoint;
@property NSString *_contactsEndpoint;
@property NSString *_actionsEndpoint;
@property NSString *_scheduleEndpoint;

@property NSString *username;
@property NSString *password;

-(void)SendSimpleSMS2: (NSString *) to
                 from: (NSString *) from
                  msg: (NSString *) message
                flash: (BOOL) isFlash;

-(id)initCred: (NSString *) aUsername
     password: (NSString *) aPassword;

-(void)initAndSendRequest: (NSString *) endpoint
                      msg: (NSString *) message;

//place other methods which you are using here

@end
