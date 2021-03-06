<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="False" MasterPageFile="theme.Master" Inherits="CommunityServer.Blogs.Controls.CSBlogThemePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="Server">

    <CSControl:Title runat="server" IncludeSectionOrHubName="true" IncludeSiteName="false">
        <ContentTemplate><CSBlog:WeblogPostData runat="server" Property="Subject" /></ContentTemplate>
    </CSControl:Title>

    <div class="post">
        <div class="posthead">
            <CSBlog:WeblogPostData runat="server" Property="Subject" Tag="H2" CssClass="pageTitle" />
            Posted 
            <CSBlog:WeblogPostData Property="UserTime" LinkTo="Post" IncludeTimeInDate="true" runat="server" />                
            <CSControl:ResourceControl runat="server" ResourceName="Weblog_EntryList_By" id="PostByResource" />
			<CSBlog:WeblogPostData Property="DisplayName" LinkTo="AuthorUrl" runat="server" />
        </div>
        <CSBlog:WeblogPostData Property="FormattedBody" IncrementViewCount="true" runat="server" />
        <CSBlog:WeblogPostData ResourceName="Weblog_ReadMirroredPost" Property="TitleUrl" runat="server">
	        <DisplayConditions><CSBlog:WeblogPostPropertyValueComparison runat="server" ComparisonProperty="IsExternal" Operator="IsSetOrTrue" /></DisplayConditions>
	        <LeaderTemplate><p><i></LeaderTemplate>
	        <TrailerTemplate></i></p></TrailerTemplate>
	    </CSBlog:WeblogPostData>

        <div class="postfoot">
            <CSBlog:PostAttachmentData runat="server" LinkTo="Attachment" Tag="Div" Property="FileName"><LeaderTemplate><span class="em">Attachment:</span> </LeaderTemplate></CSBlog:PostAttachmentData>	
            <CSBlog:WeblogPostRating runat="server" RatingCssClass="CommonRateControl" RatingReadOnlyCssClass="CommonRateControlReadOnly" RatingActiveCssClass="CommonRateControlActive" ImagesBaseUrl="~/utility/images/" />                        
            <CSBlog:WeblogPostTagEditableList runat="server" EditorLinkCssClass="TextButton" EditorCssClass="InlineTagEditor" Tag="Div" CssClass="em" />
        </div>    
    </div>
    
    <CSControl:PlaceHolder runat="server">
		<DisplayConditions Operator="Not"><CSBlog:WeblogPostPropertyValueComparison runat="server" ComparisonProperty="IsExternal" Operator="IsSetOrTrue" /></DisplayConditions>
        <ContentTemplate>
            <CSBlog:WeblogFeedbackList runat="server">
                <QueryOverrides PageSize="999999" />
                <HeaderTemplate>
                    <a name="Comments"></a>
                    <CSControl:ResourceControl runat="server" ResourceName="Weblog_CommentForm_Comments" Tag="H3" />
                    <div id="comments">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="<%# ((bool) Eval("IsOwner")) ? "commentowner" : "comment" %>">
			            <h4>
				            <CSBlog:WeblogPostFeedbackData runat="server" LinkTo="Feedback" Text="#" />
				            <CSBlog:WeblogPostFeedbackData runat="server" Property="Subject" Tag="span" />
			            </h4>
			            <div class="commentssubhead">
			                <CSBlog:WeblogPostFeedbackData runat="server" Property="PostDate" FormatString="f" />
			                by <CSBlog:WeblogPostFeedbackData runat="server" Property="DisplayName" LinkTo="User" />
			                <span class="commentspan">
			                    <CSBlog:DeleteWeblogPostFeedbackForm DeleteButtonId="DeleteComment" ConfirmationResourceName="Weblog_Comment_DeleteVerify" runat="server">
			                        <SuccessActions>
                                        <CSControl:GoToModifiedUrlAction runat="server" />
                                    </SuccessActions>
                                    <FormTemplate>
                                        <CSControl:ResourceLinkButton runat="server" ResourceName="Weblog_Link_RemoveComment" ID="DeleteComment" />
                                    </FormTemplate>
                                </CSBlog:DeleteWeblogPostFeedbackForm>
                            </span>
                        </div>			
		                <div class="commentsbody">
		                    <CSBlog:WeblogPostFeedbackData runat="server" Property="FormattedBody" Tag="p" />
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </CSBlog:WeblogFeedbackList>
            
            <CSControl:ResourceControl runat="server" ResourceName="Blog_Pending_Comment" Tag="Strong">
                <DisplayConditions>
                    <CSControl:QueryStringPropertyValueComparison QueryStringProperty="CommentPosted" Operator="IsSetOrTrue" runat="server" />
                </DisplayConditions>
                <LeaderTemplate><a name="commentmessage"></a></LeaderTemplate>
            </CSControl:ResourceControl>
            
            <CSBlog:WeblogPostCommentForm runat="server"
                MessageTextBoxId="tbComment" 
                NameTextBoxId="tbName" 
                RememberCheckboxId="chkRemember" 
                SubjectTextBoxId="tbTitle" 
                SubmitButtonId="btnSubmit" 
                UrlTextBoxId="tbUrl" 
                ControlIdsToHideFromRegisteredUsers="RegisteredWrapper,RememberWrapper"
                
            >
                <SuccessActions>
                    <CSControl:GoToModifiedUrlAction runat="server" QueryStringModification="CommentPosted=true" TargetLocationModification="commentmessage" />
                </SuccessActions>
                <FormTemplate>
                    <div id="commentform">
                    <CSControl:ResourceControl runat="server" ResourceName="Weblog_CommentForm_WhatDoYouThink" id="rc_think" Tag="h3"/>
	                    <dl>
	                        <asp:Panel runat="server" ID="RegisteredWrapper">
                            <dt><CSControl:FormLabel runat="server" ResourceName="Title" LabelForId="tbTitle" /> <em>(<CSControl:ResourceControl runat="server" ResourceName="Required"/>)</em><asp:RequiredFieldValidator runat="server" ErrorMessage="*" ControlToValidate="tbTitle" ValidationGroup="CreateCommentForm" /></dt>
	                        <dd><asp:TextBox id="tbTitle" runat="server" CssClass="smallbox" ValidationGroup="CreateCommentForm" /></dd>

                            <dt id="NameTitle" runat="server"><CSControl:FormLabel LabelForId="tbName" runat="server" ResourceName="Weblog_CommentForm_Name" /> <em>(<CSControl:ResourceControl runat="server" ResourceName="Required" />)</em><asp:RequiredFieldValidator runat="server" ErrorMessage="*" ControlToValidate="tbName" ValidationGroup="CreateCommentForm" /></dt>
                            <dd id="NameDesc" runat="server"><asp:TextBox id="tbName" runat="server" CssClass="smallbox" ValidationGroup="CreateCommentForm" /></dd>

                            <dt><CSControl:FormLabel runat="server" LabelForId="tbUrl" ResourceName="Weblog_CommentForm_YourUrl" /> <em>(<CSControl:ResourceControl runat="server" ResourceName="Optional" /></em>)</dt>
                            <dd><asp:TextBox id="tbUrl" runat="server" CssClass="smallbox" ValidationGroup="CreateCommentForm" /></dd>
                            </asp:Panel>
                            
                            <dt><CSControl:FormLabel LabelForId="tbComment" runat="server" ResourceName="Weblog_CommentForm_Comments" /> <em>(<CSControl:ResourceControl runat="server" ResourceName="Required" />)</em><asp:RequiredFieldValidator runat="server" ErrorMessage="*" ControlToValidate="tbComment" ValidationGroup="CreateCommentForm" /></dt>
                            <dd><asp:TextBox id="tbComment" runat="server" Rows="5" Columns="25" TextMode="MultiLine" ValidationGroup="CreateCommentForm" /></dd>

                            <dt runat="server" id="RememberWrapper"><asp:CheckBox id="chkRemember" runat="server" Text="Remember Me?" ValidationGroup="CreateCommentForm"></asp:CheckBox></dt>
               
                            <dt><asp:Button id="btnSubmit" runat="server" Text="Submit" ValidationGroup="CreateCommentForm"></asp:Button></dt>
	                    </dl>
                    </div>
                </FormTemplate>
            </CSBlog:WeblogPostCommentForm>    
        </ContentTemplate>
    </CSControl:PlaceHolder>
</asp:Content>
