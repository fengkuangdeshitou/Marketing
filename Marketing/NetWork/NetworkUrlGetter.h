//
//  NetworkUrlGetter.h
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUrlGetter : NSObject

+ (NSString *)getHost;

+ (NSString *)getUrlAvatarHeader;

+ (NSString *)login;

+ (NSString *)userRegister;

+ (NSString *)getSettingStarting;

+ (NSString *)getSmsWithPhoneNoWithType:(NSString *)type;

+ (NSString *)getUserAgreenment:(NSString *)module;

+ (NSString *)getMyDynamicListWithRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getDynamicList:(NSString *)regmentId andType:(NSString *)type andUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getRegimentList:(NSString *)city andCountry:(NSString *)country andUserId:(NSString *)userId;

+ (NSString *)getCity:(NSString *)keywords andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getCounty:(NSString *)cityCode;

+ (NSString *)getMemberList:(NSString *)regimentId andType:(NSString *)type andUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)joinRegiment:(NSString *)regimentId andUserId:(NSString *)userId;

+ (NSString *)uploadDynamicImage;

+ (NSString *)addDynamic;

+ (NSString *)getDynamicDetail:(NSString *)dynamic_id andUserId:(NSString *)userId;

+ (NSString *)addPraise:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)reportDynamic;

+ (NSString *)addComment;

+ (NSString *)getCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)applyPosition;

+ (NSString *)candidate:(NSString *)regimentId andUserId:(NSString *)userId andTgtposiotion:(NSString *)postion;

+ (NSString *)getSpecialtyList;

+ (NSString *)addSpecialty;

+ (NSString *)addResignPosition;

+ (NSString *)quitForced:(NSString *)regimentId andUserId:(NSString *)userId;

+ (NSString *)getElection;

+ (NSString *)getCityEncode:(NSString *)cityName;

+ (NSString *)getCirclesListDynamicUrl:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getBenefitDynamicList:(NSString *)type andUserId:(NSString *)userId andLabelId:(NSString *)labelId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)addBenefit;

+ (NSString *)changeBenefitPrice;

+ (NSString *)getBenefitAcceptList:(NSString *)dynamicId andStatus:(NSString *)status;

+ (NSString *)uploadBenefitImage;

+ (NSString *)collectionBenefit:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)benefitMediate;

+ (NSString *)getBenefitTagsWithUserId:(NSString *)userid;

+ (NSString *)addCirclesDynamic;

+ (NSString *)uploadCirclesImage;

+ (NSString *)addCirclesPraise:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)getCirclesDynamicDetail:(NSString *)dynamicId andUserId:(NSString *)userID;

+ (NSString *)getCirclesCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)addCirclesComment;

+ (NSString *)getGroceryList:(NSString *)type andUserId:(NSString *)userId andKeywords:(NSString *)keywords andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getGroceryDetail:(NSString *)dynamicId andUserid:(NSString *)userid;

+ (NSString *)getGroceryCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)loadGrocery;

+ (NSString *)collectGrocery:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)collectionJober;

+ (NSString *)getOwnCollectionListWithuserId:(NSString *)userId;

//生命的尊严

+ (NSString *)getFarewellWithUserId:(NSString *)userId Rows:(NSString *)rows anaPage:(NSString *)page;

+ (NSString *)addFarewellDynamic;

+ (NSString *)uploadFarewellImage;

+ (NSString *)addLight;

+ (NSString *)getFarewellDynamicDetail:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)getFarewellCommentListWithDynacmicId:(NSString *)dynamicId parentId:(NSString *)parentId;

+ (NSString *)getOwnCreateWithUserId:(NSString *)userId;

+ (NSString *)conditionrecruitUrl;

+ (NSString *)getOwnFareWellListWithuserId:(NSString *)userId;

//紧急救助
+ (NSString *)getAidList:(NSString *)type andUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)uploadAidImage;

+ (NSString *)addAidDynamic;

+ (NSString *)addAidComment;

+ (NSString *)aidCheck;

+ (NSString *)getWeddingDynamicListWithRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getWeddingDetailWithUserId:(NSString *)userId dynamicId:(NSString *)dynamicId;

+ (NSString *)getOwnWeddingWithUserId:(NSString *)userId;

+ (NSString *)getWeddingCommentListWithDynamic:(NSString *)dynamic parentId:(NSString *)parentId;

+ (NSString *)addWeddingComment;

+ (NSString *)addWeddingDynamic;

+ (NSString *)uploadWeddingImage;

+ (NSString *)addWeddingPraise:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)findJob;

+ (NSString *)findJobRecruitListWithUserId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)reqJobHuntWithUserId:(NSString *)userId;

+ (NSString *)getJobHuntDetail:(NSString *)jobId userId:(NSString *)userId;

+ (NSString *)getJobRecruitDetail:(NSString *)jobId;

+ (NSString *)addHunt;

+ (NSString *)addGrocery;

+ (NSString *)uploadGroceryImage;

+ (NSString *)addGrocertCommet;

+ (NSString *)loveList;

+ (NSString *)addLove;

+ (NSString *)getAidDynamicDetail:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)getAidCommentList:(NSString *)dynamicId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getCreditLimit;

+ (NSString *)getCreditRule;

//通讯录
+ (NSString *)getAddrBookList:(NSString *)userId andType:(NSString *)type;

+ (NSString *)addBook;

//我的

+ (NSString *)getAuthInfo:(NSString *)userId;

+ (NSString *)authAuto;

+ (NSString *)getMyinfo:(NSString *)userId andOtherUserId:(NSString *)otherUserId;

+ (NSString *)uploadAuthImage;

+ (NSString *)authAdd;

+ (NSString *)getWalletBanance:(NSString *)userId;

+ (NSString *)getUserDetailInfo:(NSString *)userId;

+ (NSString *)userDetailEdit;

+ (NSString *)userInfoEdit;

+ (NSString *)my_info_edit;

+ (NSString *)getBenefitSelfDetail:(NSString *)dynamicId acceptId:(NSString *)acceptId userId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)fetBenefitOtherDetail:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)benefitAccept;

+ (NSString *)deleteBenefitWithDynaicId:(NSString *)dynamicId;

+ (NSString *)getblessDetailWithDynamicId:(NSString *)dynamicId;

+ (NSString *)getBlessCommentList:(NSString *)dynaimicId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)addBlessComment;

+ (NSString *)getUserCredit:(NSString *)userId;

+ (NSString *)getUser_userInfo:(NSString *)userId;

+ (NSString *)getUserDic;

+ (NSString *)getUserUserMarriageAttitudeEditUrl;

+ (NSString *)getUserUserMarriageAttitude:(NSString *)userId;

+ (NSString *)getUserEducontext:(NSString *)userId;

+ (NSString *)editUserEdu;

+ (NSString *)userJobcontextEdit;

+ (NSString *)getUserJobcontextList:(NSString *)userId;

+ (NSString *)getUserSelfevaluate:(NSString *)userId;

+ (NSString *)getUserSelfevaluateEdit;

+ (NSString *)userHonorEdit;

+ (NSString *)uploadUserHonorImage;

+ (NSString *)voteMember;

+ (NSString *)getSpecialCandidate:(NSString *)regimentId;

+ (NSString *)searchFriendWithUserId:(NSString *)userId andKeywords:(NSString *)keywords rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)addChat;

+ (NSString *)getGroupListWithUserId:(NSString *)userId;

+ (NSString *)getChatGroupInfoWitGroupId:(NSString *)groupId;

+ (NSString *)chatSettingWithType:(NSString *)type;

+ (NSString *)chatSetting:(NSString *)groupId andUserId:(NSString *)userId andType:(NSString *)type ;

+ (NSString *)deleteBoolWithUser:(NSString *)userId andtgtUserid:(NSString *)tgtUserId andType:(NSString *)type;

+ (NSString *)getMemberlist:(NSString *)groupId;

+ (NSString *)addGroupMember;

+ (NSString *)exitGroupChat;

+ (NSString *)removeGroupMember;

+ (NSString *)getUserScreeningWithUserId:(NSString *)userId andGroupId:(NSString *)groupId;

+ (NSString *)getChatGroupUsersWithGroupId:(NSString *)groupId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getRegimentSubOrganize;

+ (NSString *)groceryUpdateUrl;

+ (NSString *)messageMe:(NSString *)moduleType :(NSString *)userId :(NSString *)rows :(NSString *)page;

+ (NSString *)chatListMyMessageModuleType:(NSString *)moduleType userId:(NSString *)userid rows:(NSString *)row page:(NSString *)page;

+ (NSString *)regimentResignPosition;

+ (NSString *)regimentCheck;

+ (NSString *)getAgreementWithModule:(NSString *)modeule;

+ (NSString *)getWalletDrawalListWithUserId:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getWalletBalanceWithUserId:(NSString *)userId;

+ (NSString *)addBalancePwd;

+ (NSString *)deleteDynamicWithDynamicId:(NSString *)dynamicId andUserId:(NSString *)userId;

+ (NSString *)walletDrawalAdd;

+ (NSString *)pwd_modifyUrl;

+ (NSString *)getRegimentCount;

+ (NSString *)candidateListWithRegimentId:(NSString *)regimentId andUserId:(NSString *)userId;

+ (NSString *)getOtherCandidateListWithRegimentId:(NSString *)regimentId andUserId:(NSString *)userId andIndex:(NSString *)index;

+ (NSString *)appoint_position;

+ (NSString *)updateAliPay;

+ (NSString *)walletPay;

+ (NSString *)benefitAddComment;

+ (NSString *)getCirclesMesageList:(NSString *)userId andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getMessageWithUserId:(NSString *)userId andModuleType:(NSString *)moduleType andRows:(NSString *)rows andPage:(NSString *)page;

+ (NSString *)getAddrbookCorner:(NSString *)userId andtype:(NSString *)type;

+ (NSString *)getRegimentResignDetail:(NSString *)resignApplyId;

+ (NSString *)cancelapply;

+ (NSString *)recallPosition;

+ (NSString *)farewellAddComment;

+ (NSString *)industryListUrl;

+ (NSString *)mobileChange;

+ (NSString *)getSettingsList;

+ (NSString *)pwd_modify;

+ (NSString *)submitSuggest;

+ (NSString *)setting;

+ (NSString *)userbBImgChange;

+ (NSString *)verifyCode;

+ (NSString *)conversationReport;

+ (NSString *)getWalletListWithUserId:(NSString *)userId andRows:(NSString *)row andPage:(NSString *)page;

+ (NSString *)updatePosition;

+ (NSString *)uploadCurrencyImage;

+ (NSString *)walletRecharge;

+ (NSString *)getUserSummaryWithUserId:(NSString *)userId;

+ (NSString *)uploadMessageImage;

+ (NSString *)reloadGroupHeader;

+ (NSString *)removeBlackMember;

+ (NSString *)getMyBgImgWithuserId:(NSString *)userId Row:(NSString *)row andPage:(NSString *)page;

+ (NSString *)benefitSoldOut;

+ (NSString *)getMyGroupOtherMemberWithGroupId:(NSString *)groupId andUserId:(NSString *)userId;

+ (NSString *)walletBindingAli;

+ (NSString *)walletAuthorise;

+ (NSString *)benefitDelLogical;

+ (NSString *)protectLogin;

+ (NSString *)getOfficialDynamicListWithRows:(NSString *)row page:(NSString *)page;

+ (NSString *)FindLoveReport;

+ (NSString *)FindLoveMatchingWithUserId:(NSString *)userid;

+ (NSString *)FindLoveInfoDetailWithuserId:(NSString *)userId otherId:(NSString *)otherId;

+ (NSString *)FindLoveUserImagesWithUserId:(NSString *)userId;

+ (NSString *)FindLoveDeleteImage;

+ (NSString *)FindLoveUploadImage;

+ (NSString *)UploadFindLoveImage;

+ (NSString *)FindLoveScopeWithType:(NSString *)type;

+ (NSString *)FindLoveGetLabelWithUserId:(NSString *)userId labelType:(NSString *)labelType;

+ (NSString *)FindLoveAddLabel;

+ (NSString *)FindLoveEditInfo;

+ (NSString *)FindLoveLikeListWithUserId:(NSString *)userId status:(NSString *)status;

+ (NSString *)FindLoveDeleteMatching;

+ (NSString *)FindLoveTag;

+ (NSString *)FindLoveScreening;

+ (NSString *)FindLoveGetScreeningWithUsrId:(NSString *)userId;

+ (NSString *)FinfLoveCheckWithUserId:(NSString *)userId;

+ (NSString *)FindLoveContact;

+ (NSString *)getRegimentApplicantWithRegimentId:(NSString *)regiment userId:(NSString *)userId;

+ (NSString *)searchBenefitWithUserId:(NSString *)userId srange:(NSString *)range keywords:(NSString *)keywords;

+ (NSString *)findUnReadNumberWithUserId:(NSString *)userId;

+ (NSString *)uploadJoberImage;

+ (NSString *)getOwnJobScreeningWithUserId:(NSString *)userId;

+ (NSString *)getJobIndustry;

+ (NSString *)getThemeHot;

+ (NSString *)getThemeDetailWithThemeId:(NSString *)themeId userId:(NSString *)userId;

+ (NSString *)getThemeFirstCommentsWithThemeId:(NSString *)themeId rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)getOwnThemeListWithUserId:(NSString *)userId;

+ (NSString *)joinTheme;

+ (NSString *)getThemeMemberListWithThemeId:(NSString *)themeId rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)getThemeScreeningWithUserId:(NSString *)userId;

+ (NSString *)getThemeCommentListWithThemeId:(NSString *)themeId parentId:(NSString *)parentId;

+ (NSString *)addThemeComment;

+ (NSString *)uploadThemeImage;

+ (NSString *)addTheme;

+ (NSString *)getThemeDynamicListWithUserId:(NSString *)userId regimentId:(NSString *)regimentId  moduleId:(NSString *)moduleId rows:(NSString *)row page:(NSString *)page;

+ (NSString *)getOtherThemeRegimentDynamicListWithRegimentId:(NSString *)regimentId userId:(NSString *)userId rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)themeDynamicPraise;

+ (NSString *)getThemeBadgeNumberWithUserId:(NSString *)userId;

+ (NSString *)getOwnThemeDynamicListWithUserId:(NSString *)userId rows:(NSString * )rows page:(NSString *)page;

+ (NSString *)getOtherDynamicListWithOwnUserId:(NSString *)ownUserId otherId:(NSString *)otherId rows:(NSString *)rows page:(NSString *)page;

+ (NSString *)getuserShareWithUserId:(NSString *)userId;

+ (NSString *)getInvitationRankingWithUsrId:(NSString *)userId;

+ (NSString *)addFillInviter;

+ (NSString *)getNearUserListWithUserId:(NSString *)userId;

+ (NSString *)uploadCredentialImage;

+ (NSString *)uploadTalentImage;

@end
