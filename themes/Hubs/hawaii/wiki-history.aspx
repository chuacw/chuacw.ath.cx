﻿<%@ Page EnableViewState="false" Language="C#" AutoEventWireup="true" Inherits="CommunityServer.Wikis.Controls.CSWikiThemePage" MasterPageFile="theme.Master" %>
<%@ Register TagPrefix="CSUserControl" TagName="Tabs" Src="~/themes/hawaii/wikis/tabs.ascx" %>
<%@ Import Namespace = "CommunityServer.Components" %>
<%@ Import Namespace = "CommunityServer.Wikis.Components" %>

<asp:Content ContentPlaceHolderID="bbcr" runat="server">
    <div class="CommonBreadCrumbArea"><div class="Common">
        <CSHub:HubData Property="Name" LinkTo="HomePage" runat="server" />
        &raquo;
        <CSWiki:WikiData LinkTo="HomePage" runat="server" ResourceName="Hubs_Wiki" />
        &raquo;
        <CSWiki:PageData runat="server" LinkTo="Page" Property="Title" />
        &raquo;
        <CSWiki:PageData runat="server" LinkTo="History" ResourceName="Wikis_Page_History" />
    </div></div>
</asp:Content>

<asp:Content ContentPlaceHolderID="tr" runat="server">
    <CSControl:Title runat="server" IncludeSiteName="true" EnableRendering="true" Tag="H1" CssClass="CommonTitle">
        <ContentTemplate><CSWiki:PageData runat="server" Property="Title" /></ContentTemplate>
        <LeaderTemplate><CSControl:ResourceControl runat="server" ResourceName="Wikis_History_Title" /></LeaderTemplate>
    </CSControl:Title>
</asp:Content>

<asp:Content ContentPlaceHolderID="bcr" runat="server">

<script type = "text/javascript">
    function compareVersions()
    {
        var result = '';
	    var pa = document.getElementById('RevisionListing').getElementsByTagName('INPUT');
	    var numChecks = 0;
	    for(var i=0; i<pa.length; i++)
	    {
		    var e = pa[i];
		    if(e.getAttribute('type') == 'checkbox' && e.checked)
		    {
		        numChecks ++;
		        
		        if (numChecks == 1)
		        {
                    result += e.name.replace('cb-', 'revB=');
                }
		        if (numChecks == 2)
		        {
                    result += e.name.replace('cb-', '&revA=');
                }
		    }
	    }
	    
	    if (numChecks != 2)
	    {
	        alert('<%= CommunityServer.Components.ResourceManager.GetString("Wikis_History_TooManyVersionsSelected") %>');
	    }
	    else
	    {
             window.location =  'compare.aspx?' + result;
        }
    }
    
    boxesChecked = 2;
    function ValidateCheck(cb)
    {
        if (cb.checked)
        {
            if ((boxesChecked + 1) > 2)
            {
    	        alert('<%= CommunityServer.Components.ResourceManager.GetString("Wikis_History_TooManyVersionsSelected") %>');
                return false;
            }
            boxesChecked++;
            return true;
        }
        else
        {
            boxesChecked = boxesChecked - 1;
        }
    }
</script>

<div class="CommonContentBox">
    <div class="CommonContentBoxContent">
        <div style="float: right">
            <CSWiki:WikiData ID="WikiData1" LinkTo="CreatePage" runat="server" LinkCssClass="WikiAddButton">
                <ContentTemplate><span><CSControl:ResourceControl runat="server" ResourceName="Wikis_AddPage" /></span></ContentTemplate>
           </CSWiki:WikiData>
        </div>

        <CSUserControl:Tabs runat="server" SelectedTab="History" />

        <div class="CommonPane">
            <div class="CommonGroupedContentArea">

                <CSControl:Title runat="server" IncludeSiteName="true" EnableRendering="true" Tag="H2" CssClass="CommonContentBoxHeaderSmall">
                    <ContentTemplate><CSWiki:PageData runat="server" Property="Title" LinkTo="Page" /></ContentTemplate>
                </CSControl:Title>

                    <CSControl:Pager runat="server" ID="HistoryListPager" />
                    <CSWiki:PageRevisionList ID="HistoryList" runat="server">
                    <QueryOverrides runat="server" PageSize="10" PagerID="HistoryListPager" />
                    <HeaderTemplate>
                        <table id="RevisionListing" cellSpacing="0" cellPadding="0" border="0" width="100%">
                        <thead>
                            <tr>
                                <th class="CommonListHeader" colspan="2"><CSControl:ResourceControl ID="ResourceControl1" runat="server" ResourceName="Wikis_History_Revision" /></th>
                                <th class="CommonListHeader"><CSControl:ResourceControl ID="ResourceControl2" runat="server" ResourceName="Wikis_History_Date" /></th>
                                <th class="CommonListHeader"><CSControl:ResourceControl ID="ResourceControl3" runat="server" ResourceName="Wikis_History_Author" /></th>
                            </tr>
                        </thead>
                	    <tr class="AltListRow">
	                    <td class="CommonListCellLeftMost"><input type="checkbox" name="cb-0" checked="checked" /></td>
	                    <td class="CommonListCell">
    	                    [Current Revision]
                        </td>
	                    <td class="CommonListCell">
	                        <CSWiki:PageData runat="server" Property="LastModifiedDate" IncludeTimeInDate="true" />
                        </td>
	                    <td class="CommonListCell">
                            by: <CSControl:UserData runat="server" LinkTo="Profile" Property="DisplayName" />
                        </td>
                        </tr>
                    </HeaderTemplate>
                    <NoneTemplate></NoneTemplate>
                    <ItemTemplate>
	                    <tr class="CommonListRow">
	                    <td class="CommonListCellLeftMost">
	                        <input type="checkbox" name="cb-<CSWiki:PageRevisionData runat='server' Property='RevisionNumber' />" />
	                    </td>
	                    <td class="CommonListCell">
    	                    <CSWiki:PageRevisionData runat="server" Property="RevisionNumber" LinkTo="Revision" FormatString="Revision \# 0">
    	                    <LeaderTemplate>[</LeaderTemplate>
    	                    <TrailerTemplate>]</TrailerTemplate>
    	                    </CSWiki:PageRevisionData>
                        </td>
	                    <td class="CommonListCell">
	                        <CSWiki:PageRevisionData runat="server" Property="LastModifiedDate" IncludeTimeInDate="true" />
                        </td>
	                    <td class="CommonListCell">
                            by: <CSControl:UserData runat="server" LinkTo="Profile" Property="DisplayName" />
                        </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                	    <tr class="AltListRow">
	                    <td class="CommonListCellLeftMost"><input type="checkbox" name="cb-<CSWiki:PageRevisionData runat='server' Property='RevisionNumber' />" /></td>
	                    <td class="CommonListCell">
    	                    <CSWiki:PageRevisionData runat="server" Property="RevisionNumber" LinkTo="Revision" FormatString="Revision \# 0">
    	                    <LeaderTemplate>[</LeaderTemplate>
    	                    <TrailerTemplate>]</TrailerTemplate>
    	                    </CSWiki:PageRevisionData>
                        </td>
	                    <td class="CommonListCell">
	                        <CSWiki:PageRevisionData runat="server" Property="LastModifiedDate" IncludeTimeInDate="true" />
                        </td>
	                    <td class="CommonListCell">
                            by: <CSControl:UserData runat="server" LinkTo="Profile" Property="DisplayName" />
                        </td>
                        </tr>
                    </AlternatingItemTemplate>
                    </CSWiki:PageRevisionList>
                    </table>

                    <div class="CommonFormField">
    	                <input type="button" onclick="compareVersions();" value='<%= CommunityServer.Components.ResourceManager.GetString("Wikis_History_Compare") %>' />
    	            </div>

            </div>
        
        </div>
    </div>
</div>

<script type = "text/javascript">
    // Precheck the first revision checkbox
    var revList = document.getElementById('RevisionListing').getElementsByTagName('INPUT');
	var cb2 = revList[1];
    if(cb2.getAttribute('type') == 'checkbox')
    {
        cb2.checked = true;
    }

</script>

</asp:Content>

<asp:Content ContentPlaceHolderID="rcrc" runat="server">
    
    <CSWiki:DeletePageForm runat="server" DeleteSinglePageButtonId="DeletePageLink">
        <SuccessActions>
            <CSControl:GoToSiteUrlAction runat="server" UrlName="hub_wiki">
                <Parameter1Template><CSHub:HubData runat="server" Property="ApplicationKey" /></Parameter1Template>
            </CSControl:GoToSiteUrlAction>
        </SuccessActions>
        <LeaderTemplate>
            <script type="text/javascript">
                function confirmPageDelete()
                {
                    return window.confirm('Are you sure you want to delete this page?');
                }
            </script>
            <ul class="CommonContentBoxList Seperator"><li>
        </LeaderTemplate>
        <FormTemplate>
            <CSControl:ResourceLinkButton runat="server" OnClientClick="return confirmPageDelete();" ID="DeletePageLink" Text="Delete Page" />
        </FormTemplate>
        <TrailerTemplate></li></ul></TrailerTemplate>
    </CSWiki:DeletePageForm>
    
    <CSWiki:LockPageForm runat="server" LockButtonId="LockPageButton" UnlockButtonId="UnlockPageButton">
        <SuccessActions><CSControl:GoToModifiedUrlAction runat="server" /></SuccessActions>
        <LeaderTemplate><ul class="CommonContentBoxList Seperator"><li></LeaderTemplate>
        <FormTemplate>
            <CSControl:ResourceLinkButton runat="server" ID="LockPageButton" Text="Lock Page" />
            <CSControl:ResourceLinkButton runat="server" ID="UnlockPageButton" Text="Unlock Page" />
        </FormTemplate>
        <TrailerTemplate></li></ul></TrailerTemplate>
    </CSWiki:LockPageForm>
    
</asp:Content>