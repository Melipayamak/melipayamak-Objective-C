//
//  RestResponse.h
//  mp_objC
//
//  Created by Amirhossein Mehrvarzi on 11/26/19.
//  Copyright © 2019 Amirhossein Mehrvarzi. All rights reserved.
//

#ifndef RestResponse_h
#define RestResponse_h


#endif /* RestResponse_h */


@interface RestResponse : NSObject

@property NSString *Value;
@property NSString *RetStatus;
@property NSString *StrRetStatus;

-(id)init:(NSData *)mutableData;

@end
