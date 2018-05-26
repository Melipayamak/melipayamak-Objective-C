//

//  SoapClient.h

//  mp_objC

//

//  Created by Amirhossein Mehrvarzi on 4/24/18.

//  Copyright © 2018 Amirhossein Mehrvarzi. All rights reserved.

//


#ifndef SoapClient_h

#define SoapClient_h



#endif /* SoapClient_h */


@interface SoapClient : NSObject


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

               sender: (NSString *) from

                  msg: (NSString *) message

                flash: (BOOL) isFlash;


-(id)initCred: (NSString *) aUsername

     password: (NSString *) aPassword;


-(void)initAndSendRequest: (NSString *) endpoint

                      msg: (NSString *) message;


//place other methods which you are using here


@end
