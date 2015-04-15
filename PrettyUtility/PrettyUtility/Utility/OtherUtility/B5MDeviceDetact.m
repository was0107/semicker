//
//  B5MDeviceDetact.m
//  PrettyUtility
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "B5MDeviceDetact.h"

BOOL isIpadDevice() {
	static BOOL hasCheckediPadStatus = NO;
	static BOOL isRunningOniPad = NO;
	if (!hasCheckediPadStatus)
	{
		if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
		{
			if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
			{
				isRunningOniPad = YES;
				hasCheckediPadStatus = YES;
				return isRunningOniPad;
			}
		}
		hasCheckediPadStatus = YES;
	}
	return isRunningOniPad;
}

BOOL isIphoneDevice()
{
    return !isIpadDevice();
}