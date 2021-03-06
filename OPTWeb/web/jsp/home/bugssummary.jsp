<table width="99%" cellpadding=1 cellspacing=1 border=0 align="center" class="TableBorder1Pix">
    <tr>
        <td width="100%" valign="top">
            <table width="100%" cellpadding=0 cellspacing=0 border=0 align="left">
                <tr>
                    <%
                        if ((intBugNotStarted + intBugInProgress + intBugOnHold) > 0)
                        {
                    %>
                    <td class="DarkBlueBandStyleText14" align="left">&nbsp;List of Bugs
                        (<%= intBugNotStarted + intBugInProgress + intBugOnHold %>)
                    </td>
                    <%
                    }
                    else
                    {
                    %>
                    <td class="DarkBlueBandStyleText14" align="left">&nbsp;List of Bugs</td>
                    <%
                        }
                    %>
                </tr>
            </table>
            <%
                if ((intBugNotStarted + intBugInProgress + intBugOnHold) > 0)
                {
            %>
            <table width="100%" cellpadding=2 cellspacing=2 border=0>
                <tr class="LightBlueBandStyle">
                    <td width="3%" class="txtblackbold12">S.No</td>
                    <td width="10%" class="txtblackbold12">Ticket ID</td>
                    <td width="45%" class="txtblackbold12">Ticket Description</td>
                    <td width="8%" class="txtblackbold12">Ticket Priority</td>
                    <td width="14%" class="txtblackbold12">Assignee</td>
                    <td width="7%" class="txtblackbold12">Status</td>
                    <td width="8%" class="txtblackbold12">ETA</td>
                    <td width="5%" class="txtblackbold12" align="center">Ageing</td>
                </tr>
                <%
                    int intCounter = 0;
                    String strBackGround = "";
                    String strTicketETATBDTAG = "<span class=\"blink_me\" style=\"font-weight: bold;color: #FF0000;\">ETA - TBD</span>";
                    StringBuffer sbETAHistory;
                    int intSerialNo = 0;
                    for (int iCount = 0; iCount < arlBugsList.size(); iCount += 8)
                    {
                        sbETAHistory = new StringBuffer();
                        if (intCounter % 2 == 0)
                        {
                            strBackGround = "LightGreyBandStyle";
                        }
                        else
                        {
                            strBackGround = "DarkGreyBandStyle";
                        }

                        strTicketETA = arlBugsList.get(iCount + 5);
                        if (strTicketETA != null && strTicketETA.length() > 0)
                        {
                            ArrayList<Date> arlETADates = new ArrayList();
                            SimpleDateFormat ETA_DISPLAY_FORMAT = new SimpleDateFormat(AppConstants.JAVA_DATE_FORMAT_DD_MMM_YYYY);
                            sbETAHistory.append("title=\"");
                            for (int intETACount = 0; intETACount < arlOpenTicketsETAHistory.size(); intETACount += 3)
                            {
                                if (arlBugsList.get(iCount).equalsIgnoreCase((String) arlOpenTicketsETAHistory.get(intETACount)) &&
                                        arlBugsList.get(iCount + 1).equalsIgnoreCase((String) arlOpenTicketsETAHistory.get(intETACount + 1)))
                                {
                                    arlETADates = (ArrayList<Date>) arlOpenTicketsETAHistory.get(intETACount + 2);
                                    for (Date objTemp : arlETADates)
                                    {
                                        sbETAHistory.append(ETA_DISPLAY_FORMAT.format(objTemp)).append("\n");
                                    }
                                }
                            }
                            sbETAHistory.append("\"");
                        }


                        if (strTicketETA == null || strTicketETA.trim().length() == 0)
                        {
                            strTicketETA = strTicketETATBDTAG;
                        }

                        if (arlBugsList.get(iCount + 5) != null && arlBugsList.get(iCount + 5).length() > 0)
                        {
                            SimpleDateFormat ETA_DATE_FORMAT = new SimpleDateFormat(AppConstants.JAVA_DATE_FORMAT_DD_MMM_YYYY);
                            SimpleDateFormat CURRENT_DATE_FORMAT = new SimpleDateFormat(AppConstants.JAVA_DATE_FORMAT_DD_MM_YYYY);
                            Date ETADate = ETA_DATE_FORMAT.parse(arlBugsList.get(iCount + 5));
                            Date CurrentDate = CURRENT_DATE_FORMAT.parse(strCurrentDateDDMMYYYY);
                            if (CurrentDate.compareTo(ETADate) > 0)
                            {
                                strTicketETA = "<span class=\"blink_me\" style=\"font-weight: bold;color: #FF0000;\">" + strTicketETA + "</span>";
                            }

                        }
                %>
                <tr class="<%= strBackGround %>">
                    <td class="txtgrey" align="right"><%= ++intSerialNo %>
                    </td>
                    <td class="txtgrey"><a
                            href="JavaScript:openJIRAWindow('<%= AppConstants.JIRAURL + arlBugsList.get(iCount + 1) %>', '<%= arlBugsList.get(iCount + 1) %>')"
                            class="link"><%= arlBugsList.get(iCount + 1) %>
                    </a>
                    </td>
                    <td class="txtgrey"><a
                            href="JavaScript:openJIRAWindow('<%= AppConstants.JIRAURL + arlBugsList.get(iCount + 1) %>', '<%= arlBugsList.get(iCount + 1) %>')"
                            class="link"><%= arlBugsList.get(iCount + 2) %>
                    </a>
                    </td>
                    <td class="txtgrey"><a
                            href="JavaScript:viewTicketDetails('<%= arlBugsList.get(iCount) %>','<%= arlBugsList.get(iCount + 1) %>')"
                            title="Ticket Details"><%= arlBugsList.get(iCount + 3) %>
                    </a>
                    </td>
                    <td class="txtgrey"><%= arlBugsList.get(iCount + 4) %>
                    </td>
                    <td class="txtgrey"><%= arlBugsList.get(iCount + 7) %>
                    </td>
                    <td class="txtgrey" <%= sbETAHistory %>><%= strTicketETA %>
                    </td>
                    <td class="txtgrey" align="center"><%= arlBugsList.get(iCount + 6) %>
                    </td>
                </tr>
                <%
                        intCounter++;
                    }
                %>
            </table>
            <%
            }
            else
            {
            %>
            <%@ include file="../common/nodataavailable.jsp" %>
            <%
                }
            %>
        </td>
    </tr>
</table>
