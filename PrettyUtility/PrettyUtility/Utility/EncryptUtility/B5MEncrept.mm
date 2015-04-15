//
//  B5MEncrept.m
//  micker
//
//  Created by allen.wang on 9/15/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "B5MEncrept.h"
#include "des.h"

#define kBarCodeKey @"75e0d6dc5bd6cbb9d94697620eb95b58137a3798df9d23b5"

static  B5MEncrept * sharedInstance = nil;
static 	unsigned char Key[] = {0xb5,0x23,0x9d,0xdf,0x98,0x37,0x7a,0x13,0x58,0x5b,0xb9,0x0e,0x62,0x97,0x46,0xd9,0xb9,0xcb,0xd6,0x5b,0xdc,0xd6,0xe0,0x75};

/**
 *	@brief	this function used to reverse the string to char array
 *  @info   please change the marco in the init function to get this function in use
 *	@param 	string 	kBarCodeKey
 */
void exchange(NSString *string)
{
    NSMutableString *result = [[[NSMutableString alloc] initWithCapacity:10] autorelease];
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger location = string.length - 2;
    NSRange range = NSMakeRange(location ,2);
    NSString *temp = [string substringWithRange:range];
    [result appendFormat:@"0x%@,",temp];
    while (temp && location >=2) {
        location -=2;
        range = NSMakeRange(location ,2);
        temp = [string substringWithRange:range];
        [array addObject:temp];
    }
    for (NSUInteger i = 0, total = [array count]; i< total; i++) {
        [result appendFormat:@"0x%@,",[array objectAtIndex:i]];
    }
    NSLog(@"kBarCodeKey reverse Key= [%@]",result);
}

@interface B5MEncrept()
{
    Des *_desEncript;
}

@end

@implementation B5MEncrept

- (id) init
{
    self = [super init];
    if (self) {
        _desEncript = new Des();
        
#if 0
        exchange(kBarCodeKey);
#endif
    }
    return self;
}

+ (id) instance
{
    static dispatch_once_t pred;
	dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
	return sharedInstance;
    return self;
}

+ (NSString*) base64Encode:(const NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    NSUInteger length = [data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length]; 
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = (const unsigned char *)[data bytes];
    ixtext = 0; 
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) 
            break;        
        for (i = 0; i < 3; i++) { 
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1: 
                ctcopy = 2; 
                break;
            case 2: 
                ctcopy = 3; 
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }     
    return result;
}

- (NSString *) encrypt:(NSString *) plainText
{
    if (!plainText || plainText.length <= 0) {
        return nil;
    }

    const char * cPlainText = [plainText UTF8String];
    NSUInteger cLen         = strlen((char*)cPlainText);
    char* cEncrpt     = 0;
	int   cEncrptLen  = 0;
	bool b = _desEncript->Encrypt(&cEncrpt, &cEncrptLen, (char* )cPlainText, (int)cLen, Key);
	if (true == b)
	{
        /*
         for (int i=0; i<cEncrptLen; i++)
		{
			int v = ( cEncrpt[i] & 0x000000FF );
			printf("%x ", v);
			//tmpStr = tmpStr +" "+ Integer.toHexString(FVout[i] & 0xFF );
		}
		printf("\n");
		// delete[] pOut;
         */
	}
    else {
        return nil;
    }
    /*
    unsigned char Fout[32] = {0};
    b = _desEncript->Run3Des(Fout, (unsigned char*)cEncrpt, cEncrptLen, Key, 24, Des::DECRYPT);
    if (true == b)
    {
        for (int i=0; i<cEncrptLen; i++)
        {
            int v = ( Fout[i] );
            printf("[%c] ", v);
            //tmpStr = tmpStr +" "+ Integer.toHexString(FVout[i] & 0xFF );
        }
        printf("\n");
    }

        
    DEBUGLOG(@"3DES result = %@", [NSString stringWithCString:cEncrpt encoding:NSASCIIStringEncoding]);
     */

    NSString *result = [[self class] base64Encode: [NSData dataWithBytes:cEncrpt length:cEncrptLen]];
//    DEBUGLOG(@"BASE result = %@", result);

    return result;
}

- (void) dealloc
{
    delete _desEncript;
    [super dealloc];
}
@end
