//
//  NetworkUrl.m
//  HistoryPlayer
//
//  Created on 21/2/28.
//  Copyright (c) 2021年 apple. All rights reserved.
//

#import "NetworkUrl.h"

@implementation NetworkUrl

#ifdef DEBUG
NSString * const hostReleaseUrl = @"http://192.168.1.117:7007";
#else
NSString * const hostReleaseUrl = @"http://api.huyiquantuan.com/huyiwo";
#endif

NSString * const loginUrl = @"/user/login";

NSString * const registerUrl = @"/user/regist";

NSString * const settingStartingUrl = @"/starting";

NSString * const smsUrl = @"/user/sms";

NSString * const userAgreenmentUrl = @"/agreement";

NSString * const dynamicListUrl = @"/regiment/list_dynamic";

NSString * const MyDynamicListUrl = @"/circles/queryDynamicCount";

NSString * const regimentListUrl = @"/regiment/list";

NSString * const cityUrl = @"/city";

NSString * const countyUrl = @"/county";

NSString * const memberListUrl = @"/regiment/list_member";

NSString * const joinRegimentUrl = @"/regiment/join";

NSString * const addDynamicUrl = @"/theme/dynamic";

NSString * const uploadDynamicImageUrl = @"/regiment/uploadImage";

NSString * const dynamicDetail = @"/theme/dynamic/detail";

NSString * const addPraiseUrl = @"/regiment/add_praise";

NSString * const reportDynamicUrl = @"/report";

NSString * const addCommentUrl = @"/theme/dynamic/comment";

NSString * const commentListUrl = @"/theme/dynamic/first/comment";

NSString * const applyPositionUrl = @"/regiment/apply_position";

NSString * const candidateUrl = @"/regiment/candidate";

NSString * const specialtyListUrl = @"/regiment/list_specialty";

NSString * const addSpecialtyUrl = @"/regiment/add_specialty";

NSString * const resignPositionUrl = @"/regiment/resign_position";

NSString * const quitForcedUrl = @"/regiment/quit_forced";

NSString * const electionUrl = @"/regiment/election";

NSString * const cityEncodeUrl = @"/city_encode";

NSString * const circlesListDynamicUrl = @"/circles/list_dynamic";

NSString * const benefitDynamicListUrl = @"/benefit/dynamic";

NSString * const benefitAcceptListUrl = @"/benefit/list_accept";

NSString * const collectionBenefitUrl = @"/benefit/add_collection";

NSString * const addBendfitUrl = @"/benefit/add";

NSString * const changeBenefitPriceUrl = @"/benefit/adjust";

NSString * const uploadBenefitImageUrl = @"/benefit/uploadImage";

NSString * const benefitSelfDetailUrl = @"/benefit/new/detail";

NSString * const benefitOtherDetailUrl = @"/benefit/detail";

NSString * const benefitAcceptUrl = @"/benefit/accept/plus";

NSString * const deleteBenefitUrl = @"/benefit/del";

NSString * const benefitTagsUrl = @"/benefit/label";

NSString * const benefitMediaDetailUrl = @"/benefit/detail_accept";

NSString * const addCirclesDynamicUrl = @"/circles/add_dynamic";

NSString * const uploadCirclesImageUrl = @"/circles/uploadImage";

NSString * const addCirclesPraiseUrl = @"/circles/add_praise";

NSString * const circlesDynamicDetailUrl = @"/circles/detail_dynamic";

NSString * const circlesCommentListUrl = @"/circles/list_comment";

NSString * const addCirclesCommentUrl = @"/circles/add_comment";

NSString * const groceryListUrl = @"/grocery/list_dynamic";

NSString * const groceryDetailUrl = @"/grocery/detail_dynamic";

NSString * const addGroceryUrl = @"/grocery/add_dynamic";

NSString * const uploadGroceryImageUrl = @"/grocery/uploadImage";

NSString * const grocertAddCommetUrl = @"/grocery/add_comment";

NSString * const groceryCommentListUrl = @"/grocery/list_comment";

NSString * const loadGroceryUrl = @"/grocery/load";

NSString * const collectGroceryUrl = @"/grocery/add_collection";

NSString * const farewellUrl = @"/life/dynamic";

NSString * const addFareWellUrl = @"/farewell/add_dynamic";

NSString * const uploadFarewellImageUrl = @"/life/uploadImage";

NSString * const addLightUrl = @"/life/light";

NSString * const farewellDynamicDetailUrl = @"/life/detail";

NSString * const farewellCommentListUrl = @"/life/comments";

NSString * const searchBenefitUrl = @"/benefit/search/plus";


NSString * const aidListUrl = @"/aid/list_dynamic";

NSString * const uploadAidImageUrl = @"/aid/uploadImage";

NSString * const addAidDynamicUrl = @"/aid/add_dynamic";

NSString * const addAidCommentUrl = @"/aid/add_comment";

NSString * const aidCheckUrl = @"/aid/check";

NSString * const regimentApplicantUrl = @"/regiment/applicant";

//新型婚礼
NSString * const weddingCheckUrl = @"/wedding/check";

NSString * const weddingCommentsListUrl = @"/wedding/comments";

NSString * const addWeddingDynamicUrl = @"/wedding/dynamic";

NSString * const uploadWeddingImageUrl = @"/wedding/uploadImage";

NSString * const weddingDetailUrl = @"/wedding/detail/v2";

NSString * const weddingOwnListUrl = @"/wedding/own";

NSString * const addWeddingCommentUrl = @"/wedding/comment";

NSString * const weddingAddPraiseUrl = @"/wedding/add_praise";

NSString * const findJobUrl = @"/job/list_hunt";

NSString * const jobRecruitListUrl = @"/job/infos";

NSString * const reqJobHuntUrl = @"/job/check";

NSString * const addHuntUrl = @"/job/info";

NSString * const jobHuntDetailUrl = @"/job/detail";

NSString * const jobRecruitUrl = @"/job/detail_recruit";

NSString * const loveListUrl = @"/love/list";

NSString * const addLoveUrl = @"/love/add";

NSString * const aidDynamicDetailUrl = @"/aid/detail_dynamic";

NSString * const aidCommentListUrl = @"/aid/list_comment";

NSString * const creditLimitUrl = @"/credit/limit";

NSString * const creditRuleUrl = @"/credit/rule";

NSString * const addrBookListUrl = @"/addrbook/list";

NSString * const addrbookUrl = @"/addrbook/add";

NSString * const collectionJoberUrl = @"/job/collection";// 收藏

NSString * const ownCollectionListUrl = @"/job/collection";//我收藏的

NSString * const ownCreateListUrl = @"/job/own";//我创建的

NSString * const conditionrecruitUrl = @"/job/info";//删除收藏或发布

NSString * const groceryupdateUrl = @"/job/screening";//找员工条件

NSString * const uploadJoberImageUrl = @"/job/uploadImage";

NSString * const JobIndustryUrl = @"/job/industry";

NSString * const NearUserListUrl = @"/addrbook/near";

//我的

NSString * const authInfoUrl = @"/auth/info";

NSString * const authAutoUrl = @"/auth/auto";

NSString * const uploadAuthImageUrl = @"/auth/uploadImage";

NSString * const authAddUrl = @"/auth/add";

NSString * const walletBananceUrl = @"/wallet/balance";

NSString * const userDetailInfoUrl = @"/user/detail_info";

NSString * const userDetailEditUrl = @"/user/detail_edit";

NSString * const userbBImgChangeUrl = @"/user/bgImg/change";

NSString * const userInfoEditUrl = @"/user/user_info_edit";

NSString * const my_info_editUrl = @"/user/my_info_edit";

NSString * const blessDetailUrl = @"/bless/detail_dynamic";

NSString * const getBlessCommentListUrl = @"/bless/list_comment";

NSString * const addBlessCommentUrl = @"/bless/add_comment";

NSString * const userCreditUrl = @"/user/credit";

NSString * const user_userInfoUrl = @"/user/user_info";

NSString * const getUserDicUrl = @"/dict";

NSString * const userUserMarriageAttitudeEditUrl = @"/user/user_marriageAttitude_edit";

NSString * const userUserMarriageAttitudeUrl = @"user/user_marriageAttitude";

NSString * const userEducontextUrl = @"/user/user_educontext";

NSString * const userEduEditUrl = @"/user/user_educontext_edit";

NSString * const userJobcontextEditUrl = @"/user/user_jobcontext_edit";

NSString * const userJobcontextUrl = @"/user/user_jobcontext";

NSString * const userSelfevaluateUrl = @"/user/user_selfevaluate";

NSString * const userSelfevaluateEditUrl = @"/user/user_selfevaluate_edit";

NSString * const userHonorEditUrl = @"/user/user_honor_add";

NSString * const uploadUserHonorImageUrl = @"/user/uploadImage";

NSString * const voteMemberUrl = @"/regiment/vote_member";

NSString * const specialCandidateUrl = @"/regiment/special_candidate";

NSString * const searchFriendUrl = @"/addrbook/search";

NSString * const chatAddUrl = @"/chat/add";

NSString * const groupListUrl = @"/addrbook/group";

NSString * const chatGroupInfoUrl = @"/chat";

NSString * const chatSettingUrl = @"/chat/setting";

NSString * const deleteBookUrl = @"/addrbook/del";

NSString * const memberlistUrl = @"/group/memberlist";

NSString * const addGroupMemberUrl = @"/chat/joinBatch";

NSString * const exitGroupChatUrl = @"/chat/quit";

NSString * const removeGroupMemberUrl = @"/chat/groupQuit";

NSString * const userScreeningUrl = @"/user/screening";

NSString * const chatGroupUsersUrl = @"/chat/user";

NSString * const regimentSubOrganizeUrl = @"/regiment/sub_organize";

NSString * const regimentResignPositionUrl = @"/regiment/transfer/v2";

NSString * const findUnReadNumberUrl = @"/love/badge";


NSString * const messagelistUrl = @"/message/list";

NSString * const regimentCheckUrl = @"/regiment/check";

NSString * const agreementUrl = @"/agreement";

NSString * const walletDrawalListUrl = @"/wallet/bill";

NSString * const walletBalanceUrl = @"/wallet/balance";

NSString * const balanceAddPwdUrl = @"/balance/addPwd";

NSString * const deleteDynamicUrl = @"/regiment/del_dynamic";

NSString * const walletDrawalAddUrl = @"/wallet/drawal/add";

NSString * const pwd_retrieveUrl = @"/user/pwd_modify";

NSString * const regimentCountUrl = @"/regiment/count";

NSString * const candidateListUrl = @"/regiment/candidate";

NSString * const otherCandidateListUrl = @"/regiment/candidate";

NSString * const appoint_positionUrl = @"/regiment/appoint_position";

NSString *const updateAliPay = @"/pay/alipay/notify";

NSString * const walletPayUrl = @"/wallet/pay";

NSString * const benefitAddCommentUrl = @"/benefit/comment";

NSString * const circlesMesageListUrl = @"/circles/message";

NSString * const messageUrl = @"/message/list/";

NSString * const addrbookCornerUrl = @"/addrbook/corner";

NSString * const regimentResign_detailUrl = @"/regiment/resign_detail";

NSString * const recallPositionUrl = @"/regiment/recall_position";

NSString * const farewellAddCommentUrl = @"/life/comment";

NSString * const ownFareWellListUrl = @"/life/own";

NSString * const cancelApplyUrl = @"/regiment/position/cancel_apply";

NSString * const mobile_changeUrl = @"/user/mobile_change";

NSString * const settingsListUrl = @"/settings/list";

NSString * const pwd_modifyUrl = @"/user/pwd_modify";

NSString * const suggestUrl = @"/suggest";

NSString * const settingUrl = @"/settings";

NSString * const verifyCodeUrl = @"/verify";

NSString * const conversationReportUrl = @"/chat/reportUser";

NSString * const walletOrderListUrl = @"/wallet/queryOrderCount";

NSString * const updatePositionUrl = @"/position";

NSString * const uploadCurrencyImageUrl = @"/currency/uploadImage";

NSString * const walletRechargeUrl = @"/wallet/recharge";

NSString * const userSummaryUrl = @"/user/summary";

NSString * const uploadMessageImageUrl = @"/message/uploadImage";

NSString * const reloGroupHeaderUrl = @"/chat/modifyGroup";

NSString * const removeBlackMemberUrl = @"/addrbook/modifyUserType";

NSString * const getMyBgImgUrl = @"/bgImage";

NSString * const soldOutUrl = @"/benefit/shelve";

NSString * const chatJoinUserUrl = @"/chat/joinUser";

NSString * const walletBindingAliUrl = @"/wallet/bindingAli";

NSString * const walletAuthoriseUrl = @"/wallet/authorise";

NSString * const benefitDelLogicalUrl = @"/benefit/delLogical";

NSString * const protectLoginUrl = @"/user/protectLogin";

NSString * const officialListUrl = @"/official/list_dynamic";

NSString * const UploadFindLoveImageurl = @"/love/uploadImage";

NSString * const FindLoveScopeUrl = @"/love/scope";

NSString * const FindLoveLabelListUrl = @"/love/label";

NSString * const FindLoveEditInfoUrl = @"/love/content";

NSString * const FindLoveLikeListUrl = @"/love/pairing";

NSString * const FindLoveContactUrl = @"/love/contact";

NSString * const credentialImageUrl = @"/credential/uploadImage";

NSString * const uploadTalentImageUrl = @"/talent/uploadImage";

#pragma mark FindLove

NSString * const FindLoveReportUrl = @"/love/report";

NSString * const FindLoveMatchingUrl = @"/love/matching";

NSString * const FindLoveInfoDetailUrl = @"/love/info";

NSString * const FindLoveUserImagesUrl = @"/love/image";

NSString * const FindLoveTagUrl = @"/love/tag";

NSString * const FindLoveScreeningUrl = @"/love/screening";

NSString * const FindLoveCheckUrl = @"/love/check";

// 主题圈

NSString * const ThemeHotUrl = @"/theme/hot/v2";

NSString * const ThemeDetailUrl = @"/theme/detail";

NSString * const ThemeFirstConmentsUrl = @"/theme/first/comment";

NSString * const ThemeSecondConmentsUrl = @"/theme/second/comment";

NSString * const OwnThemeListUrl = @"/theme/own/theme";

NSString * const JoinThemeUrl = @"/theme/join";

NSString * const ThemeMemberListUrl = @"/theme/user";

NSString * const ThemeScreeningUrl = @"/theme/screening";

NSString * const AddThemeCommentUrl = @"/theme/comment";

NSString * const UploadThemeImageUrl = @"/theme/uploadImage";

NSString * const AddThemeUrl = @"/theme/info";

NSString * const ThemeDynamicListUrl = @"/theme/dynamic";

NSString * const OtherThemeRegimentDynamicListUrl = @"/theme/regiment/dynamic";

NSString * const ThemeDynamicPraiseUrl = @"/theme/praise";

NSString * const ThemeBadgeNumberUrl = @"/theme/badge/v2";

NSString * const OwnThemeDynamicListUrl = @"/theme/own/dynamic/";

NSString * const UserShareUrl = @"/user/share";

NSString * const InvitationRankingListUrl = @"//user/ranking";

NSString * const UserFillInviterUrl = @"/user/fill/inviter";

NSString * const OtherDynamicListUrl = @"/theme/other/dynamic";

//  协议

NSString * const userUrl = @"user";  // 互益圈团服务协议

NSString * const farewell_significanceUrl = @"farewell_significance"; // 生命尊严活动的意义

NSString * const serviceUrl = @"service"; // 互益圈团服务协议

NSString * const aboutUrl = @"about"; // 关于互益圈团

NSString * const wedding_significanceUrl = @"wedding_significance"; // 新型婚礼活动意义

NSString * const apply_positionUrl = @"apply_position"; // 申请职务规则提示

NSString * const office_regiment_ruleUrl = @"office_regiment_rule"; // 团长管理协议及说明

NSString * const wedding_ruleUrl = @"wedding_rule"; // 新型婚礼活动规则

NSString * const office_other_ruleUrl = @"office_other_rule"; //其他职务管理协议及说明

NSString * const resign_positionUrl = @"resign_position"; // 申请辞职规则提示

NSString * const credit_limitUrl = @"credit_limit"; // 信誉值获得限制

NSString * const office_professinal_ruleUrl = @"office_professinal_rule"; //专业成员管理协议及说明

NSString * const credit_ruleUrl = @"credit_rule"; // 如何获得信誉值

NSString * const farewell_ruleUrl = @"farewell_rule"; // 生命尊严活动的规则

NSString * const aid_ruleUrl = @"aid_rule"; //紧急救助活动规则

NSString * const aid_significanceUrl = @"aid_significance"; // 紧急救助活动的意义

NSString * const transfer_positionUrl = @"transfer_position"; // 申请调动协议

@end
