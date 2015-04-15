//
//  EnumDefines.h
// sejieios
//
//  Created by allen.wang on 12/26/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#ifndef b5mappsejieios_EnumDefines_h
#define b5mappsejieios_EnumDefines_h

enum eGenderType {
    eGenderMale = 0,
    eGenderFemale = 1
};

enum eContentType {
    eContentCommodityType = 0,
    eContentTuanType = 1
};

enum eSheJieType {
    eSheJieNormal = 1,
    eSheJieExplorFirst ,
    eSheJieExplorSecond ,
    eSheJieExplorThird ,
    eSheJieSearch,
    eSheJieVoice,
    eSheJieUserCenter,
    eSheJieCustomAccount,
    eSheJieOtherAccount,
    eSheJieLogout,
    eSheJieAbout
};

enum eTipType {
    eTipTypeNormal = 0,
    eTipTypeCustom ,
    eTipTypeOther
    };

enum eCustomShare {
    eCustomAccountShare = 0,
    eCustomAccountLike,
    eOtherAccountShare,
    eOtherAccountLike
};

enum eRecordAction {
    eRecordActionLike = 1,
    eRecordActionShare,
    eRecordActionComment,
    eRecordActionStart,
    eRecordActionUpload,
    eRecordActionIcon,
    eRecordActionCover
};

enum {
    eWepActionsNone             = 0,
    eWebActionsOpenInSafari     = 1 << 0,
    eWebActionsWeiBo            = 1 << 1,
    eWebCopyLink                = 1 << 2
};

typedef NSUInteger eWebActions;

enum eSNSType {
    eSNSTypeWeibo = 1,
    eSNSTypeWeixin,
    eSNSTypeQQ
};

// section index marco
enum eTableViewSectionIndex {
    eSectionIndex00 = 0,
    eSectionIndex01 ,
    eSectionIndex02 ,
    eSectionIndex03 ,
    eSectionIndex04 ,
    eSectionIndex05 ,
    eSectionIndex06 ,
    eSectionIndex07 ,
    eSectionIndex08 ,
    eSectionIndex09 ,
    eSectionIndex10 ,
    
    eSectionIndex11 ,
    eSectionIndex12 ,
    eSectionIndex13 ,
    eSectionIndex14 ,
    eSectionIndex15 ,
    eSectionIndex16 ,
    eSectionIndex17 ,
    eSectionIndex18 ,
    eSectionIndex19 ,
    eSectionIndex20 ,
    eSectionIndex21
};

//row index marco
enum eTableViewRowIndex {
    eTableViewRowIndex00 = 0,
    eTableViewRowIndex01 ,
    eTableViewRowIndex02 ,
    eTableViewRowIndex03 ,
    eTableViewRowIndex04 ,
    eTableViewRowIndex05 ,
    eTableViewRowIndex06 ,
    eTableViewRowIndex07 ,
    eTableViewRowIndex08 ,
    eTableViewRowIndex09 ,
    eTableViewRowIndex10 ,
    
    eTableViewRowIndex11 ,
    eTableViewRowIndex12 ,
    eTableViewRowIndex13 ,
    eTableViewRowIndex14 ,
    eTableViewRowIndex15 ,
    eTableViewRowIndex16 ,
    eTableViewRowIndex17 ,
    eTableViewRowIndex18 ,
    eTableViewRowIndex19 ,
    eTableViewRowIndex20 ,
    eTableViewRowIndex21
};


#endif
