//
//  SoapClient.h
//  MeliPayamak
//
//  Created by Amirhossein Mehrvarzi on 4/24/18.
//  Copyright © 2018 MeliPayamak. All rights reserved.
//

#ifndef SoapClient_h
#define SoapClient_h


#endif /* SoapClient_h */

@interface SoapClient : NSObject

@property NSMutableData *responseData;
@property NSString *response;
@property NSString *currentElementName;

@property NSString *username;
@property NSString *password;

-(void)SendSimpleSMS2: (NSString *) to
               sender: (NSString *) from
                  msg: (NSString *) message
                flash: (BOOL) isFlash;

-(id)initCred:(NSString *)aUsername
     password:(NSString *)aPassword;

@end
