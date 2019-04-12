<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY XrefStep "((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=&EffGrp;) or (text/eff/effgrp=&EffGrp;))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=&EffGrp;) or (text/eff/effgrp=&EffGrp;))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))">
<!ENTITY EffGrp "document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp">]>
<?xep-out-embed-images true?><?xep-postscript-language-level 2?><!--###########################################################################################################

# workcardPrint.xsl

# This is Stylsheet for Print Workcard 

##############################################################################################################

# Version history

#20050915  RG  0.01   Written

#20050927  RG  0.02   Updated For Displaying Part Information Depending on "part-state"

#20050928  SH  0.03   Put "*** END OF WORK STEPS..." back into mainfunc template.

#20051003  RG  0.03  Added Table Element

#20051005 	MN	0.04	Added small roman numerals as a formatting style for the fifth level of steps. Changed the 4th level of steps

									from roman numerals to lowercase alphabets.

									Part Information modified to appear on the coverpage and textpages on if it is required part. 

#  20051011  MN	0.05	Modified Part Information display for the text pages to appear with PARTS, AS REQUIRED if part-state is A or C, 
									and PARTS, REQUIRED/PREDRAW , if part-state is R. 

# 20051014	MN	0.06	Commented code to display airplane-tails for all types of checks.

# 20051021	MN	0.07	Deleted display of source-key for tools. 

# 20051101	MN	0.08	Added space-before-conditionality to all the templates

#20051123  MN   0.09 Modifed code for graphics

#20060109  MN   0.10 Modified code to display planning notes on cover page. 

#20060112  MN   0.11  Modified code for Parts to display information retrieved form SCEPTRE

#20060112  MN   0.11  Modified code for tools to display information retrieved form SCEPTRE

#20060216  MN    0.12  Added code to dispay parts, tools, references and drawings on the 2nd page. 

#20060221   MN   0.18   Added the description for each of the configuration codes. 

#20060228   MN   0.20   Sign-offs - Made the table bold if the sign-off was done by Inspector,ETOPS *, NDT, RII, Lead inspector or OK *

#20060308   MN   0.22   Modified steps to match AMI cards as per Issue #3161 

#20060310   MN   0.23   Modified display of zone-panel

#20060228	 MN   0.20   Sign-offs - Made the table bold if the sign-off was done by Inspector,ETOPS *, NDT, RII, Lead inspector or OK *

#20060330   MN   0.24   Modified code for Watemarks.

#20060407   MN   0.25   Removed code to check for CONTINGENT part state for Parts as per the new work card schema for AMDS 0.6.6

#20060410   MN   0.26   Made CMS Print style sheet match AMI work cards. 

################################################################################################################

##New Schema Changes for AMDS 0.6.6##

#20060413   MN   0.25   Added the element "information"

#20060414   MN   0.26   Added code to display reforigin-type and ref-desc for Engineering work cards

                                       Added prelreq-data.

#20060427   MN   0.27   Added code to handle step cross references using xref. 

#20060510   MN   0.28   Modified code for Parts and tools to display A/R if part/tool quantity is zero , to conform to AMI cards 

#20060531   MN   0.29   Added cb-state

#20060606	 MN   0.30   Added stk-num for parts and tools. 

#20060606   MN   0.31   Added step 6

#20060619   MN   0.32   Modified Configuraitons to display the full 'State' description without the Abbreviations. 

#20060823   MN   0.33   Modified code to display  "End of Work steps.." only if there are sign offs, otherwise this text does not appear at 

									   the end of work steps. This requirement came in during the GAP analysis the week of Aug 14th2006- Aug 18th 2006

#20060824   MN   0.34   Modified code for text-pages region body to display graphics whereever they appear in the work card (issue ID 5804)



#20060824   MN   0.34   Commented out Parts and tools to test publication - Please uncomment later. 

#20060823   MN   0.35   Added images for Xray and Dinol head flags. Modified code to display multiple headflags instead of one at a time as  

                                       per GAP Analysis.

#20060828   MN   0.36  Removed headflag option hf03 - ADFAR/ETOPS as per GAP analysis. 

#20060906   MN   0.37  Added a parameter for head flags to be displayed only on the cover page.

#20061004    MN 0. 38    Modified code for planning note to remove space. 

#20061005    MN  0.39   Modified font for graphic title and table title

#20061018    MN  0.40   Modified code for graphics , table. warranty,planning

#20061120    MN  0.41   Modified Code for Note. Only when Note element is the first child of para it calls template with mode step1. 

#20061128    MN  0.42   Changed font from arial to helvetica since arial is unsupported by UNIX. 

#20070112    MN   0.43  Added logic to count the table id and not the table or table title and number the tables only if an id is present for the 

                                       table. 

#20070113    MN   0.44  Added logic to count the graphic id and not the graphic or graphic title and number the graphic only if an id is present 

										for the graphic. 

#20070127    MN   0.45   Modified the logic for graphic and table titles. If a table/graphic id and title are present, then the Figure #/Table # is displayd. If no id 

                                       and only title is present, then only title is displayed.

#20070129    MN   0.46   Added drawing revision level to Drawings.

#20070209    MN   0.47   Cross ref to steps- added periods at end of numbers.

#20070218    MN   0.48   Made changes to graphics width and height and modified the page layout for  graphics as well.

#20070220    MN    0.49  Removed the # sign in WARRANTY CLAIM as per user request

#20071203	MN	  0.50  Increased width for "Drawing Comment"	

#20073103    MN    0.51  Modified para formatting for tables below graphics - Issue 8109

#20073103    MN    0.52  Resolved Issue 8108 by adding attributes "hyphenate=true and hyphenation-character" to fo:block inside the table-cell. 

#20070402	MN	  0.53  Added new headflgag graphic tiff filesfor xray, dinol and corrosion. 

#20070402    MN    0.54  Added new code for XREF

#20070424	MN	 0.55	  Added new logic for visit card conditioning. 

#20070504	MN	0.56   Made changes to table_below_graphic

#20070725	MN	0.57	  Modified code for table-cell to show or no tshow borders based on the values of @frame attribute in the table. 	

#20080207  MN	 0.58	Added code for parts, tools, configurations and drawings to be able to condition  them for tail effectivity. 

#20082011  MN	 0.59	Added a new watermark 'ACSS' for ACSS and RCVG type of routine work cards. 

#20092601  MN	0.60	Added a new code to render tools required and as required seperately.

#20092204  MN	0.61	Added break-before page conditon for tables at the end of graphics and graphics. 

#20100112  MN	0.62	Added a new parameter 'adfar' to control display of addtional text for AD related cards

#20101002  MN   0.63  Added 'Keep-together' rule for table rows below graphics.
#20100324   MN    0.64 Hardcoded skill code to crewtype conversion values for routine cards.
                                    Added code to render part-num to support converted work cards.  
                                    Added figure/sheet reference and cross reference functionality.
                                    Added functionality to show proc-num which contains the Delta south JIC opn. 
 #20100325   MN    0.65 Added additional functionality to format signoff blocks different for routine cards as part of JIC migration. 
#20111005    MN    0.66 MPN lookup, tooling changes for RtoB
##############################################################################################################--><xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:rx="http://www.renderx.com/XSL/Extensions" xmlns:url="http://xml.apache.org/xslt/java/java.net.URLEncoder" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<!-- ******* Imports ********************* -->
	<xsl:import href="panelCard_en-US.xsl"/>
	<xsl:import href="footer_en-US.xsl"/>
	<xsl:import href="header_en-US.xsl"/>
	<!--	<xsl:import href="base/workcardPrint.xsl"/>-->
	<!--Signoff pages-->
	<xsl:import href="workcardPrint_signoff_en-US.xsl"/>
	<xsl:import href="header_signoff_en-US.xsl"/>
	<xsl:import href="header_Rep_en-US.xsl"/>
	<xsl:import href="header_All_en-US.xsl"/>
	<xsl:import href="header_routine_en-US.xsl"/>
	<!--Workcard conditioning-->
	<xsl:import href="visitfilterPrint_en-US.xsl"/>
	<!-- Cross reference to steps, table and graphic-->
	<xsl:key name="steps" match="*[@id]" use="@id"/>
	<xsl:key name="FindGraphic" match="graphic" use="@id"/>
	<xsl:key match="figure" name="FindFigure" use="@id"/>
	<xsl:key name="FindTable" match="table" use="@id"/>
	<xsl:key name="ColSpec" match="colspec" use="@colname"/>
	<!-- Variables for configuring Table Style -->
	<xsl:variable name="NoFrameWidth">0px</xsl:variable>
	<xsl:variable name="FrameWidth">1px</xsl:variable>
	<xsl:variable name="FrameColour">black</xsl:variable>
	<xsl:variable name="THeadWidth">1px</xsl:variable>
	<xsl:variable name="THeadColour">black</xsl:variable>
	<xsl:variable name="SepWidth">1px</xsl:variable>
	<xsl:variable name="SepColour">#CCCCCC</xsl:variable>
	<xsl:variable name="DefaultHAlign">left</xsl:variable>
	<xsl:variable name="DefaultVAlign">top</xsl:variable>
	<!-- ******* Variables and Params ********************* -->
	<xsl:param name="document-id"/>
	<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="taskkey">
		<xsl:value-of select="/workcard/prelreq/references/reference/source-key"/>
	</xsl:variable>
	<xsl:variable name="refid">
		<xsl:value-of select="/workcard/prelreq/references/reference/refid"/>
	</xsl:variable>
	<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<!-- Server Requests -->
	<xsl:param name="request-base" select="'/docato-composer/getTaskReferencesByRef.dox'"/>
	<!-- Parameter for Stock Number -->
	<xsl:param name="stockNumber"/>
	<!-- Parameters for card conditioning-->
	<xsl:param name="tail"/>
	<xsl:param name="company"/>
	<xsl:param name="environment"/>
	<!-- -->
	<xsl:param name="username"/>
	<xsl:param name="docato.server"/>
	<xsl:param name="docato.sessionid"/>
	<xsl:variable name="JIC_Draft" select="concat($docato.server,'/images/NWA_JIC_Draft.jpg')"/>
	<xsl:variable name="Engg_Draft" select="concat($docato.server,'/images/NWA_Engg_Draft.jpg')"/>
	<xsl:variable name="dinol" select="concat($docato.server,'/images/NWA_Dinol.TIF')"/>
	<xsl:variable name="xray" select="concat($docato.server,'/images/NWA_XRay.TIF')"/>
	<xsl:variable name="corrosion" select="concat($docato.server,'/images/NWA_Corrosion.TIF')"/>
	<xsl:variable name="symbol" select="concat($docato.server,'/images/nwa_pnl_symbol.jpg')"/>
	<xsl:variable name="acss" select="concat($docato.server,'/images/NWA_ACSS.jpg')"/>
	<xsl:variable name="wctype" select="/workcard/prelreq/wctype"/>
	<xsl:variable name="hflag" select="/workcard/mainfunc/head-flags/head-flag/@type"/>
	<!--Zones Panels lookup variables-->
	<xsl:variable name="carrier" select="/workcard/prelreq/carrier-code"/>
	<xsl:variable name="mfg" select="/workcard/prelreq/mfg"/>
	<xsl:variable name="model" select="/workcard/prelreq/model"/>
	<xsl:variable name="dash" select="/workcard/prelreq/dash"/>
	<!--End Zones panels lookup variables-->
	<!-- ******* Root Template ********************* -->
	<xsl:template match="workcard">
		<!-- Define page layout -->
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<!--Generate a new layout for the new signoff formats for routine workcards-->
				<xsl:choose>
					<xsl:when test="((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08'))">
						<fo:simple-page-master master-name="signcoverPage" page-height="11in" page-width="8.5in" margin-top="3mm" margin-bottom="3mm" margin-left="5mm" margin-right="5mm">
							<fo:region-body region-name="signcoverPage-region-body" margin-left="8mm" margin-right="8mm" margin-bottom="51.5mm">
								<xsl:attribute name="margin-top"><xsl:choose><xsl:when test="/workcard/mainfunc/head-flags/head-flag/@type='hf01' ">50mm</xsl:when><xsl:otherwise>42mm</xsl:otherwise></xsl:choose></xsl:attribute>
							</fo:region-body>
							<fo:region-before region-name="signcoverPage-region-before" extent="45mm"/>
							<fo:region-after region-name="signcoverPage-region-after" extent="50mm" display-align="after"/>
						</fo:simple-page-master>
						<fo:simple-page-master master-name="RepcoverPage" page-height="11in" page-width="8.5in" margin-top="5mm" margin-bottom="5mm" margin-left="5mm" margin-right="5mm">
							<fo:region-body region-name="RepcoverPage-region-body" margin-left="8mm" margin-right="8mm" margin-top="44mm" margin-bottom="25mm">
								<xsl:choose>
									<xsl:when test="/workcard/prelreq/carrier-code = 'VIR'"/>
									<xsl:otherwise>
										<xsl:if test="/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P'">
											<xsl:choose>
												<xsl:when test="/workcard/prelreq/model='ACSS' or /workcard/prelreq/model='RCVG'">
													<xsl:attribute name="background-image">url(<xsl:value-of select="$acss"/>)</xsl:attribute>
												</xsl:when>
												<xsl:otherwise>
													<xsl:attribute name="background-image">url(<xsl:value-of select="$JIC_Draft"/>)</xsl:attribute>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<xsl:if test="/workcard/prelreq/wctype = 'E'">
											<xsl:attribute name="background-image">url(<xsl:value-of select="$Engg_Draft"/>)</xsl:attribute>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</fo:region-body>
							<fo:region-before region-name="RepcoverPage-region-before" precedence="false" extent="44mm"/>
							<fo:region-after region-name="RepcoverPage-region-after" precedence="false" extent="50mm" display-align="after"/>
						</fo:simple-page-master>
					</xsl:when>
				</xsl:choose>
				<!--End generate-->
				<!-- Layout for the cover page -->
				<fo:simple-page-master master-name="coverPage" page-height="11in" page-width="8.5in" margin-top="5mm" margin-bottom="5mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body region-name="coverPage-region-body" margin-left="8mm" margin-right="8mm" margin-top="61mm" margin-bottom="25mm">
<!-- header missing issue-->
						<xsl:choose>
							<xsl:when test="/workcard/prelreq/carrier-code = 'VIR'"/>
							<xsl:otherwise>
								<xsl:if test="/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P'">
									<xsl:choose>
										<xsl:when test="/workcard/prelreq/model='ACSS' or /workcard/prelreq/model='RCVG'">
											<xsl:attribute name="background-image">url(<xsl:value-of select="$acss"/>)</xsl:attribute>
										</xsl:when>
										<xsl:otherwise>
											<xsl:attribute name="background-image">url(<xsl:value-of select="$JIC_Draft"/>)</xsl:attribute>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<xsl:if test="/workcard/prelreq/wctype = 'E'">
									<xsl:attribute name="background-image">url(<xsl:value-of select="$Engg_Draft"/>)</xsl:attribute>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</fo:region-body>
					<fo:region-before region-name="coverPage-region-before" precedence="false" extent="44mm"/>
					<fo:region-after region-name="coverPage-region-after" precedence="false" extent="50mm" display-align="after"/>
				</fo:simple-page-master>
				<!-- Layout for the rest of pages without graphics -->
				<fo:simple-page-master master-name="textPages" page-height="11in" page-width="8.5in" margin-top="5mm" margin-bottom="5mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body region-name="textPages-region-body" margin-bottom="30mm" margin-left="8mm" margin-right="8mm">
						<xsl:attribute name="margin-top"><xsl:choose><xsl:when test="/workcard/mainfunc/head-flags/head-flag/@type='hf01' ">58mm</xsl:when><!--QC-1034_Job#OverlayIssue_IncreasedMarginTop_50mm--><xsl:otherwise>42mm</xsl:otherwise></xsl:choose></xsl:attribute>
<!-- header missing issue-->
					</fo:region-body>
					<fo:region-before region-name="textPages-region-before" extent="48mm"/>
<!-- header missing issue-->
					<fo:region-after region-name="textPages-region-after" extent="50mm" display-align="after"/>
				</fo:simple-page-master>
				<!-- Layout for the rest of pages with graphics -->
				<fo:simple-page-master master-name="textPagesGraphics" page-height="11in" page-width="8.5in" margin-top="5mm" margin-bottom="5mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body region-name="textPagesGraphics-region-body" margin-top="34mm" margin-bottom="10mm" margin-left="8mm" margin-right="8mm"/>
					<fo:region-before region-name="textPagesGraphics-region-before" extent="44mm"/>
					<fo:region-after region-name="textPagesGraphics-region-after" extent="10mm" display-align="after" precedence="true"/>
				</fo:simple-page-master>
				<!--Page sequence Master for routine cards with the new format-->
				<xsl:choose>
					<xsl:when test="((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08'))">
						<fo:page-sequence-master master-name="Repcover">
							<fo:repeatable-page-master-reference master-reference="RepcoverPage"/>
						</fo:page-sequence-master>
						<fo:page-sequence-master master-name="signcover">
							<fo:repeatable-page-master-reference master-reference="signcoverPage"/>
						</fo:page-sequence-master>
					</xsl:when>
				</xsl:choose>
				<!--End Page sequence-->
				<fo:page-sequence-master master-name="cover">
					<fo:repeatable-page-master-reference master-reference="coverPage"/>
				</fo:page-sequence-master>
				<fo:page-sequence-master master-name="text">
					<fo:repeatable-page-master-reference master-reference="textPages"/>
				</fo:page-sequence-master>
				<!-- Layout for the rest of pages with graphics -->
				<fo:page-sequence-master master-name="textGraphic">
					<fo:repeatable-page-master-reference master-reference="textPagesGraphics"/>
				</fo:page-sequence-master>
				<!-- End: define page layout -->
			</fo:layout-master-set>
			<!--Master reference for signoff pages-->
			<xsl:choose>
				<xsl:when test="((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08'))">
					<fo:page-sequence master-reference="Repcover" font-family="Helvetica" font-size="10pt" force-page-count="no-force">
						<fo:static-content flow-name="RepcoverPage-region-before">
							<xsl:call-template name="Header_Rep">
								<xsl:with-param name="flowNum">Yes</xsl:with-param>
								<xsl:with-param name="headflag">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:static-content flow-name="RepcoverPage-region-after">
							<xsl:call-template name="Footer">
								<xsl:with-param name="verifyTable">No</xsl:with-param>
								<xsl:with-param name="partialSignoff">No</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:flow flow-name="RepcoverPage-region-body">
							<xsl:choose>
								<xsl:when test="/workcard/prelreq/carrier-code ='VIR'">
									</xsl:when>
								<xsl:otherwise>
									<fo:block-container space-before="10pt" space-before.conditionality="retain">
										<fo:block font-weight="bold" start-indent="5pt" text-align="center">
								
If you find an error with these work instructions, please contact the Work Instruction Standards Group at:
</fo:block>
										<fo:block space-after="0.5pt" start-indent="5pt" font-weight="bold" text-align="center">WIS@Delta.com</fo:block>
									</fo:block-container>
								</xsl:otherwise>
							</xsl:choose>
							<fo:block>
								<xsl:apply-templates select="prelreq"/>
								<fo:block>
									<xsl:apply-templates select="mainfunc/planning" mode="coverpage"/>
									<xsl:apply-templates select="mainfunc/warranty" mode="coverpage"/>
								</fo:block>
								<!--Removing section per QC 1158	<xsl:if test="/workcard/prelreq/wctype='W'">
									<fo:block space-before="6pt" text-align="center">
										<fo:inline text-align="center">INSPECTION REVIEW</fo:inline>
									</fo:block>
							<fo:block>
									<fo:inline text-align="left">OM328/RCB Number <fo:leader leader-pattern="rule" rule-style="solid" rule-thickness=".5pt" leader-length="25%"/>
										</fo:inline>
									</fo:block>
									<fo:block>
										<fo:inline text-align="left">Originator <fo:leader leader-pattern="rule" rule-style="solid" rule-thickness=".5pt" leader-length="25%"/>
										</fo:inline>
									</fo:block>
									<fo:block>
										<fo:inline text-align="left">Date: <fo:leader leader-pattern="rule" rule-style="solid" rule-thickness=".5pt" leader-length="25%"/>
										</fo:inline>
									</fo:block>
									<fo:block space-before="3pt">
										<fo:inline text-align="left">Quality Control (Signature/Date):

									<fo:leader leader-pattern="rule" rule-style="solid" rule-thickness=".5pt" leader-length="35%"/> RII - Yes/No (Circle

								one)</fo:inline>
									</fo:block>
									<fo:block>
										<fo:inline text-align="left">Comments: </fo:inline>
									</fo:block>
									<fo:block>
										<fo:leader leader-pattern="rule" rule-style="solid" rule-thickness=".5pt" leader-length="85%"/>
									</fo:block>
									<fo:block>
										<fo:leader leader-pattern="rule" rule-style="solid" rule-thickness=".5pt" leader-length="85%"/>
									</fo:block>
								</xsl:if>-->
								<fo:block id="Rep_terminator"/>
							</fo:block>
						</fo:flow>
					</fo:page-sequence>
					<fo:page-sequence master-reference="signcover" font-family="Helvetica" font-size="10pt" force-page-count="no-force" initial-page-number="1">
						<fo:static-content flow-name="signcoverPage-region-before">
							<xsl:call-template name="Header_signoff">
								<xsl:with-param name="flowNum">No</xsl:with-param>
								<xsl:with-param name="headflag">Yes</xsl:with-param>
								<xsl:with-param name="adfar">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:static-content flow-name="signcoverPage-region-after">
							<xsl:call-template name="Footer">
								<xsl:with-param name="verifyTable">No</xsl:with-param>
								<xsl:with-param name="partialSignoff">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:flow flow-name="signcoverPage-region-body">
							<fo:block>
								<xsl:apply-templates select="/workcard/mainfunc/step1" mode="signoff"/>
								<xsl:apply-templates select="/workcard/mainfunc/step2" mode="signoff"/>
								<xsl:apply-templates select="/workcard/mainfunc/step3" mode="signoff"/>
								<xsl:apply-templates select="/workcard/mainfunc/step4" mode="signoff"/>
								<xsl:apply-templates select="/workcard/mainfunc/step5" mode="signoff"/>
								<xsl:apply-templates select="/workcard/mainfunc/step6" mode="signoff"/>
								<fo:block id="all_terminator"/>
							</fo:block>
							<xsl:choose>
								<xsl:when test="/workcard/mainfunc/sign or //sign">
									<fo:block text-align="center" font-weight="bold" keep-with-previous.within-page="always" font-size="12pt">
										<fo:inline>*
										** END OF WORK STEPS / NO FURTHER SIGNOFFS REQUIRED
						***</fo:inline>
									</fo:block>
								</xsl:when>
							</xsl:choose>
						</fo:flow>
					</fo:page-sequence>
				</xsl:when>
			</xsl:choose>
			<!--End master reference for signoff pages-->
			<xsl:choose>
				<xsl:when test="not(((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08')))">
					<fo:page-sequence master-reference="cover" font-family="Helvetica" font-size="10pt">
						<fo:static-content flow-name="coverPage-region-before">
							<xsl:call-template name="Header_All">
								<xsl:with-param name="flowNum">Yes</xsl:with-param>
								<xsl:with-param name="headflag">Yes</xsl:with-param>
								<xsl:with-param name="adfar">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:static-content flow-name="coverPage-region-after">
							<xsl:call-template name="Footer">
								<xsl:with-param name="verifyTable">No</xsl:with-param>
								<xsl:with-param name="partialSignoff">No</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:flow flow-name="coverPage-region-body">
							<xsl:choose>
								<xsl:when test="/workcard/prelreq/carrier-code ='VIR'">
									</xsl:when>
								<xsl:otherwise>
									<fo:block-container space-before="10pt" space-before.conditionality="retain">
										<fo:block font-weight="bold" start-indent="5pt" text-align="center">
If you find an error with these work instructions, please contact the Work Instruction Standards Group at:
</fo:block>
										<fo:block space-after="0.5pt" start-indent="5pt" font-weight="bold" text-align="center">WIS@Delta.com</fo:block>
									</fo:block-container>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:apply-templates select="prelreq"/>
							<fo:block>
								<xsl:apply-templates select="mainfunc/planning" mode="coverpage"/>
								<xsl:apply-templates select="mainfunc/warranty" mode="coverpage"/>
							</fo:block>
						</fo:flow>
					</fo:page-sequence>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="not(((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08')))">
					<!--if its not a routine workcard for DLS fleets , so it should be a DLN worutine card or an engineering card-->
					<fo:page-sequence master-reference="text" font-family="Helvetica" font-size="10pt">
						<!-- Header of the text pages -->
						<fo:static-content flow-name="textPages-region-before">
							<xsl:call-template name="Header_All">
								<xsl:with-param name="adfar">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:static-content flow-name="textPages-region-after">
							<xsl:call-template name="Footer">
								<xsl:with-param name="verifyTable">No</xsl:with-param>
								<xsl:with-param name="partialSignoff">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:flow flow-name="textPages-region-body">
							<fo:block>
								<xsl:apply-templates select="mainfunc"/>
								<!--DAL changes to link fromAMDS-->
								<xsl:if test="/workcard/mainfunc/text/xi:include">
									<xsl:variable name="href" select="/workcard/mainfunc/text/xi:include/@href"> 
 </xsl:variable>
									<fo:block space-before="4pt">
										<fo:basic-link color="blue" external-destination="url({$href})" show-destination="new" text-decoration="underline"> 
Linked Data
<!-- 
– <xsl:value-of select="((str:tokenize($href, '/')[last()]))"/>
-->
										</fo:basic-link>
									</fo:block>
								</xsl:if>
								<!--End Changes-->
								<fo:block id="all_terminator"/>
							</fo:block>
						</fo:flow>
					</fo:page-sequence>
				</xsl:when>
				<xsl:otherwise>
					<!--if it is a DLS routine card-->
					<xsl:if test="((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08'))">
						<fo:page-sequence master-reference="text" font-family="Helvetica" font-size="10pt">
							<!-- Header of the text pages -->
							<fo:static-content flow-name="textPages-region-before">
								<xsl:call-template name="Header_All">
									<xsl:with-param name="adfar">Yes</xsl:with-param>
								</xsl:call-template>
							</fo:static-content>
							<fo:static-content flow-name="textPages-region-after">
								<xsl:call-template name="Footer">
									<xsl:with-param name="verifyTable">No</xsl:with-param>
									<xsl:with-param name="partialSignoff">No</xsl:with-param>
								</xsl:call-template>
							</fo:static-content>
							<fo:flow flow-name="textPages-region-body">
								<fo:block>
									<xsl:apply-templates select="mainfunc" mode="signoff"/>
									<fo:block id="all_terminator"/>
								</fo:block>
							</fo:flow>
						</fo:page-sequence>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="not(((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08')))">
					<fo:page-sequence master-reference="textGraphic" font-family="Helvetica" font-size="10pt">
						<fo:static-content flow-name="textPagesGraphics-region-before">
							<xsl:call-template name="Header_All">
								<xsl:with-param name="adfar">No</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:static-content flow-name="textPagesGraphics-region-after">
							<xsl:call-template name="Footer">
								<xsl:with-param name="verifyTable">No</xsl:with-param>
								<xsl:with-param name="partialSignoff">No</xsl:with-param>
								<xsl:with-param name="barcode"/>
								<xsl:with-param name="graphicPage">Yes</xsl:with-param>
							</xsl:call-template>
						</fo:static-content>
						<fo:flow flow-name="textPagesGraphics-region-body">
							<fo:block>
								<xsl:if test="/workcard/mainfunc[child::graphic[not(parent::figure)] or child::figure]">
									<xsl:apply-templates select="/workcard/mainfunc/figure" mode="child"/>
									<xsl:apply-templates select="/workcard/mainfunc/graphic[not(parent::figure)]" mode="child"/>
									<fo:block id="all_terminator"/>
								</xsl:if>
							</fo:block>
						</fo:flow>
					</fo:page-sequence>
				</xsl:when>
				<xsl:otherwise>
					<!--if it is a DLS routine card-->
					<xsl:if test="((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08'))">
						<fo:page-sequence master-reference="textGraphic" font-family="Helvetica" font-size="10pt">
							<fo:static-content flow-name="textPagesGraphics-region-before">
								<xsl:call-template name="Header_All">
									<xsl:with-param name="adfar">No</xsl:with-param>
								</xsl:call-template>
							</fo:static-content>
							<fo:static-content flow-name="textPagesGraphics-region-after">
								<xsl:call-template name="Footer">
									<xsl:with-param name="verifyTable">No</xsl:with-param>
									<xsl:with-param name="partialSignoff">No</xsl:with-param>
									<xsl:with-param name="barcode"/>
									<xsl:with-param name="graphicPage">Yes</xsl:with-param>
								</xsl:call-template>
							</fo:static-content>
							<fo:flow flow-name="textPagesGraphics-region-body">
								<fo:block>
									<xsl:if test="/workcard/mainfunc[child::graphic[not(parent::figure)] or child::figure]">
										<xsl:apply-templates select="/workcard/mainfunc/figure" mode="child"/>
										<xsl:apply-templates select="/workcard/mainfunc/graphic[not(parent::figure)]" mode="child"/>
										<fo:block id="all_terminator"/>
									</xsl:if>
								</fo:block>
							</fo:flow>
						</fo:page-sequence>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</fo:root>
	</xsl:template>
	<!-- Define prelreq element -->
	<!--_______________________________________________________________________-->
	<!--          ****************Prelreq*******************             -->
	<!--_______________________________________________________________________-->
	<xsl:template match="prelreq">
		<fo:block padding-before="2pt" padding-after="2pt" start-indent="2pt" end-indent="2pt" font-family="Helvetica" font-size="10pt">
			<xsl:if test="maintflow-num"> </xsl:if>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="carrier-code | model | dash | maintflow-num | mfg | wctype | wc-num | wc-title | wc-status | station-code|wcjo-num|job-num"> </xsl:template>
	<!--_______________________________________________________________________-->
	<!--          ****************Prelreq Data on text pages*******************             -->
	<!--_______________________________________________________________________-->
	<xsl:template match="prelreq-data">
		<fo:block>
			<xsl:if test="@type='pd01'">
				<xsl:apply-templates select="//configurations"/>
			</xsl:if>
			<xsl:if test="@type='pd02'">
				<xsl:apply-templates select="//forecasts"/>
			</xsl:if>
			<xsl:if test="@type='pd03'">
				<xsl:call-template name="zonespanelsTextPages"/>
			</xsl:if>
			<xsl:if test="@type='pd04'">
				<xsl:apply-templates select="//drawings"/>
			</xsl:if>
			<xsl:if test="@type='pd05'">
				<xsl:apply-templates select="//references"/>
			</xsl:if>
			<xsl:if test="@type='pd06'">
				<xsl:apply-templates select="//tools"/>
			</xsl:if>
			<xsl:if test="@type='pd07'">
				<xsl:apply-templates select="//parts"/>
			</xsl:if>
			<xsl:if test="@type='pd08'">
				<xsl:apply-templates select="//circuit-breakers"/>
			</xsl:if>
		</fo:block>
	</xsl:template>
	<!--_______________________________________________________________________-->
	<!--          Crew-type          -->
	<!--_______________________________________________________________________-->
	<xsl:template match="crew-type">
		<xsl:choose>
			<xsl:when test="/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P'">
				<xsl:choose>
					<xsl:when test=".='SC' or .='CAB' or .='01'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 Cabin
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='APU' or .='ENG' or .='CGO' or .='DR' or .='PNE' or .='PT' or .='PR' or .='UTL' or .='ZC' or .='ZF' or .='ZS' or .='COMP' or .='02'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 A/C and Engine
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='STR' or .='03'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 Sheetmetal
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='HYD' or .='05'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 Hydraulic
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='AV' or .='06'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 Avionics
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='CLN' or .='06'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 Cleaning
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='IN' or .='12'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 Inspection
					</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:when test=".='NDT' or .='14'">
						<fo:block space-before="2pt" space-before.conditionality="retain">
							<fo:inline treat-as-word-space="true">
								<fo:inline font-weight="bold">CREW: </fo:inline>
				 NDT
					</fo:inline>
						</fo:block>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--_______________________________________________________________________-->
	<!--          Checks, retrieve information from external interfaces             -->
	<!--_______________________________________________________________________-->
	<xsl:template match="checks">
		<xsl:variable name="cnt" select="count(check)"/>
		<xsl:choose>
			<xsl:when test="check">
				<fo:block space-before="6pt" space-before.conditionality="retain">
					<fo:inline treat-as-word-space="true">
						<fo:inline font-weight="bold">FREQUENCY: </fo:inline>
						<xsl:for-each select="check">
							<xsl:apply-templates select="check-type" mode="list"/>
							<xsl:if test="position() != $cnt">, </xsl:if>
						</xsl:for-each>
					</fo:inline>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<fo:inline font-weight="bold">FREQUENCY: </fo:inline>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--          Forecast			         -->
	<!--_________________________________________________________________________-->
	<xsl:template match="forecasts">
		<xsl:param name="indent" select="'0'"/>
		<fo:block space-after="6pt" padding-before="0pt" padding-before.conditionality="retain" padding-top="0pt" space-before="6pt">
			<fo:table table-layout="fixed">
				<fo:table-column column-width="30mm"/>
				<fo:table-column column-width="10mm"/>
				<fo:table-column column-width="30mm"/>
				<fo:table-column column-width="10mm"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block text-decoration="underline">
								FORECAST							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">
								NHA						</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:for-each select="forecast">
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="fc-num"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="nha-pos"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--          Source-docs, retrieve information from external interfaces             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="source-docs">
		<xsl:choose>
			<xsl:when test="(../wctype='W' or ../wctype='P') and (../model='B767' or ../model='B737' or ../model='B777' or ../model='MD90' or ../model='MD88')">
				<xsl:apply-templates select="tasks/task-key"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tasks">
		<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="eng-proj-num">
		<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="sn-affected">
		<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="section-num">
		<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="major-zone">
		<xsl:text> </xsl:text>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--          Configurations             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="configurations">
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block space-before="6pt">
					<fo:inline font-weight="bold">CONFIGURATIONS:</fo:inline>
				</fo:block>
				<fo:table table-layout="fixed">
					<fo:table-column column-width="50mm"/>
					<fo:table-column column-width="50mm"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell text-decoration="underline">
								<fo:block>Type</fo:block>
							</fo:table-cell>
							<fo:table-cell text-decoration="underline">
								<fo:block>State</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="accfg">
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select=".">
					<fo:table table-layout="fixed">
						<fo:table-column column-width="50mm"/>
						<fo:table-column column-width="50mm"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:choose>
											<xsl:when test="accfg-type='ECAM'">
												<xsl:text>ELECTRONIC CENTRALIZED AIRCRAFT MONITORING</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='ELEC' or accfg-type='ELECT'">
												<xsl:text>ELECTRICAL POWER</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='ENGRUN'">
												<xsl:text>ENGINE RUN</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='FHCNT'">
												<xsl:text>FLIGHT CONTROL POSITION/MOVEMENT</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='FUEL'">
												<xsl:text>FUEL REQUIREMENTS</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='HYD'">
												<xsl:text>HYDRAULIC POWER</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='JACK'">
												<xsl:text>JACKING/SHORING REQUIREMENTS</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='MCDU'">
												<xsl:text>MULTIPURPOSE CONTROL DISPLAY UNIT</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='PNEU'">
												<xsl:text>PNEUMATIC PRESSURE</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='SAFETY'">
												<xsl:text>SAFETY DEVICES</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='STANDS'">
												<xsl:text>STANDS/LIFTS</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='WASTE'">
												<xsl:text>WASTE</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-type='WATER'">
												<xsl:text>WATER REQUIREMENTS</xsl:text>
											</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:choose>
											<xsl:when test="accfg-state='Y'">
												<xsl:text>REQUIRED</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-state='N'">
												<xsl:text>NOT PERMITTED</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-state='B'">
												<xsl:text>NO PREFERENCE</xsl:text>
											</xsl:when>
											<xsl:when test="accfg-state='T'">
												<xsl:text>LIMITED USE</xsl:text>
											</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--          References             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="prelreq/references">
		<fo:block space-before="6pt" space-before.conditionality="retain">
			<fo:block keep-with-next="always">
				<fo:inline font-weight="bold">REFERENCES:</fo:inline>
			</fo:block>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="55mm"/>
				<fo:table-column column-width="45mm"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block text-decoration="underline">Type Reference</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Reference</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="reference">
		<xsl:variable name="taskkey">
			<xsl:value-of select="source-key"/>
		</xsl:variable>
		<xsl:variable name="refid">
			<xsl:value-of select="refid"/>
		</xsl:variable>
		<fo:block>
			<xsl:choose>
				<xsl:when test="/workcard/prelreq/wctype = 'W' or /workcard/prelreq/wctype = 'P'">
					<!-- returns the task reference description for a particular task key -->
					<xsl:apply-templates select="document(concat($docato.server,'/getTaskReferencesByRef.dox?taskref=',$taskkey,':',$refid,'&amp;sessionid=',$docato.sessionid))"/>
				</xsl:when>
				<xsl:otherwise>
					<fo:block>
						<fo:table table-layout="fixed" width="100%">
							<fo:table-column column-width="55mm"/>
							<fo:table-column column-width="45mm"/>
							<fo:table-body>
								<xsl:for-each select=".">
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="reforigin-type"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="ref-desc"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:for-each>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<xsl:template match="task/reference">
		<fo:block>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="55mm"/>
				<fo:table-column column-width="45mm"/>
				<fo:table-body>
					<xsl:for-each select=".">
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="reforigin-type"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="ref-desc"/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<!-- References Text Pages -->
	<xsl:template name="refTextPages">
		<fo:block>
			<xsl:apply-templates select="//references"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Zones-panels*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="zones-panels">
		<xsl:param name="indent" select="'0'"/>
		<xsl:variable name="cnt" select="count(//zone-panel)"/>
		<fo:block space-before="6pt" space-before.conditionality="retain">
			<fo:inline treat-as-word-space="true" white-space="nowrap">
				<fo:inline font-weight="bold">ZONES: </fo:inline>
				<xsl:for-each select="zone-panel">
					<xsl:choose>
						<xsl:when test="(self::*/zn-num=following::*/zn-num)"> </xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="zn-num"/>
							<xsl:if test="position() != $cnt">, </xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</fo:inline>
		</fo:block>
		<xsl:choose>
			<xsl:when test="string(//pnl-num)">
				<fo:block space-before="6pt" space-before.conditionality="retain">
					<fo:block>
						<fo:inline font-weight="bold">REQUIRED ACCESS:</fo:inline>
					</fo:block>
					<fo:table width="100%">
						<fo:table-column column-width="40mm"/>
						<fo:table-column column-width="75mm"/>
						<fo:table-column column-width="40mm"/>
						<fo:table-column column-width="75mm"/>
						<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block text-decoration="underline">Panel ID</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Aircraft

									Effectivity</fo:block>
								</fo:table-cell>
								<xsl:choose>
									<xsl:when test="count(//pnl-num) >=2">
										<fo:table-cell>
											<fo:block text-decoration="underline">Panel

											ID</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block text-decoration="underline">Aircraft

												Effectivity</fo:block>
										</fo:table-cell>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</fo:table-row>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:apply-templates select="zone-panel" mode="table1"/>
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:apply-templates select="zone-panel" mode="eff"/>
									</fo:block>
								</fo:table-cell>
								<xsl:choose>
									<xsl:when test="count(//pnl-num)>=2">
										<fo:table-cell>
											<fo:block>
												<xsl:apply-templates select="zone-panel" mode="table2"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:apply-templates select="zone-panel" mode="eff2"/>
											</fo:block>
										</fo:table-cell>
									</xsl:when>
								</xsl:choose>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="zone-panel" mode="table1">
		<fo:table>
			<fo:table-column column-width="40mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="count(//pnl-num)=1">
									<xsl:value-of select="pnl-num"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="position() mod 2 !=0">
											<xsl:choose>
												<xsl:when test="string(pnl-num)">
													<xsl:value-of select="pnl-num[position()]"/>
												</xsl:when>
											</xsl:choose>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template match="zone-panel" mode="eff">
		<fo:table>
			<fo:table-column column-width="75mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="position() mod 2 !=0">
									<xsl:choose>
										<xsl:when test="string(pnl-num)">
											<xsl:for-each select=".">
												<xsl:variable name="zone" select="zn-num"/>
												<xsl:variable name="panel" select="pnl-num"/>
												<xsl:variable name="effgrp">
													<xsl:value-of select="(concat($docato.server, '/getPanel.dox?prgrss=true&amp;carrier=', $carrier, '&amp;mfg=', $mfg, '&amp;model=', $model, '&amp;dash=', $dash, '&amp;zone=', $zone, '&amp;panel=', $panel, '&amp;sessionid=',$docato.sessionid))"/>
												</xsl:variable>
												<xsl:value-of select="document($effgrp)/panel/eff/effgrp"/>
											</xsl:for-each>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template match="zone-panel" mode="table2">
		<fo:table>
			<fo:table-column column-width="40mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="position() mod 2 =0">
									<xsl:choose>
										<xsl:when test="string(pnl-num)">
											<xsl:value-of select="pnl-num[position()]"/>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template match="zone-panel" mode="eff2">
		<fo:table>
			<fo:table-column column-width="75mm"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="position() mod 2 =0">
									<xsl:choose>
										<xsl:when test="string(pnl-num)">
											<xsl:for-each select=".">
												<xsl:variable name="zone" select="zn-num"/>
												<xsl:variable name="panel" select="pnl-num"/>
												<xsl:variable name="effgrp">
													<xsl:value-of select="(concat($docato.server, '/getPanel.dox?prgrss=true&amp;carrier=', $carrier, '&amp;mfg=', $mfg, '&amp;model=', $model, '&amp;dash=', $dash, '&amp;zone=', $zone, '&amp;panel=', $panel, '&amp;sessionid=',$docato.sessionid))"/>
												</xsl:variable>
												<xsl:value-of select="document($effgrp)/panel/eff/effgrp"/>
											</xsl:for-each>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	<xsl:template name="zonespanelsTextPages">
		<fo:block>
			<xsl:choose>
				<xsl:when test="string(//pnl-num)">
					<fo:block space-before="6pt" space-before.conditionality="retain">
						<fo:block>
							<fo:inline font-weight="bold">REQUIRED ACCESS:</fo:inline>
						</fo:block>
						<fo:table>
							<fo:table-column column-width="40mm"/>
							<fo:table-column column-width="75mm"/>
							<fo:table-column column-width="40mm"/>
							<fo:table-column column-width="75mm"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell>
										<fo:block text-decoration="underline">Panel ID</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block text-decoration="underline">Aircraft

										Effectivity</fo:block>
									</fo:table-cell>
									<xsl:choose>
										<xsl:when test="count(//pnl-num) >=2">
											<fo:table-cell>
												<fo:block text-decoration="underline">Panel

												ID</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block text-decoration="underline">Aircraft

												Effectivity</fo:block>
											</fo:table-cell>
										</xsl:when>
										<xsl:otherwise/>
									</xsl:choose>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block>
											<xsl:apply-templates select="//zone-panel" mode="table1"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:apply-templates select="//zone-panel" mode="eff"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:apply-templates select="//zone-panel" mode="table2"/>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:apply-templates select="//zone-panel" mode="eff2"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Eff (Effectivity)*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template name="eff">
		<xsl:choose>
			<xsl:when test="eff">
				<xsl:apply-templates select="eff"/>
			</xsl:when>
			<xsl:otherwise> ALL </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="eff">
		<xsl:choose>
			<xsl:when test="tails/airplane-tail">   </xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Parts*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="parts">
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="./part/part-state='R'">
					<fo:block space-before="6pt" space-before.conditionality="retain">
						<fo:inline font-weight="bold">PARTS, REQUIRED/PREDRAW: </fo:inline>
					</fo:block>
					<fo:table table-layout="fixed" rx:table-omit-initial-header="false">
						<fo:table-column column-width="100mm"/>
						<fo:table-column column-width="20mm"/>
						<fo:table-column column-width="15mm"/>
						<fo:table-column column-width="15mm"/>
						<fo:table-column column-width="15mm"/>
						<fo:table-header>
							<!--	<fo:table-body>-->
							<fo:table-row>
								<fo:table-cell number-columns-spanned="6">
									<!--Changes for AMT enhancements parts indicator-->
									<fo:block font-weight="bold" wrap-option="wrap" start-indent="12pt">If Allow Sub is set to "N", you cannot substitute the listed part number for another part number unless otherwise stated in this work card.</fo:block>
									<fo:block font-weight="bold" wrap-option="wrap" start-indent="12pt" space-after="12pt">If IPC Check Req'd is set to "Y", then you must check the IPC to verify that the part number is correct.</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row text-decoration="underline" keep-with-next="always">
								<fo:table-cell>
									<fo:block text-decoration="underline">Part.Number/Desc</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Vcode</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Quan</fo:block>
								</fo:table-cell>
								<!--New fields for parts indicator-->
								<fo:table-cell>
									<fo:block text-decoration="underline">Allow Sub</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">IPC Check Req'd</fo:block>
								</fo:table-cell>
								<!--<fo:table-cell>
							<fo:block text-decoration="underline">Description</fo:block>
						</fo:table-cell>-->
							</fo:table-row>
							<!--	</fo:table-body>-->
						</fo:table-header>
						<xsl:apply-templates select="part" mode="required"/>
					</fo:table>
				</xsl:if>
				<xsl:if test="./part/part-state='A'">
					<fo:block space-before="6pt" space-before.conditionality="retain" keep-with-next.within-page="always">
						<fo:inline font-weight="bold">PARTS, AS REQUIRED:</fo:inline>
					</fo:block>
					<fo:table table-layout="fixed" rx:table-omit-initial-header="false">
						<fo:table-column column-width="100mm"/>
						<fo:table-column column-width="20mm"/>
						<fo:table-column column-width="15mm"/>
						<fo:table-column column-width="15mm"/>
						<fo:table-column column-width="15mm"/>
						<fo:table-header>
							<!--	<fo:table-body>-->
							<fo:table-row>
								<fo:table-cell number-columns-spanned="6">
									<!--Changes for AMT enhancements parts indicator-->
									<fo:block font-weight="bold" wrap-option="wrap" start-indent="12pt">If Allow Sub is set to "N", you cannot substitute the listed part number for another part number unless otherwise stated in this work card.</fo:block>
									<fo:block font-weight="bold" wrap-option="wrap" start-indent="12pt" space-after="12pt">If IPC Check Req'd is set to "Y", then you must check the IPC to verify that the part number is correct.</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row text-decoration="underline" keep-with-next="always">
								<fo:table-cell>
									<fo:block text-decoration="underline">Part.Number/Desc</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Vcode</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Quan</fo:block>
								</fo:table-cell>
								<!--New fields for parts indicator-->
								<fo:table-cell>
									<fo:block text-decoration="underline">Allow Sub</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">IPC Check Req'd</fo:block>
								</fo:table-cell>
								<!--<fo:table-cell>
							<fo:block text-decoration="underline">Description</fo:block>
						</fo:table-cell>-->
							</fo:table-row>
							<!--	</fo:table-body>-->
						</fo:table-header>
						<xsl:apply-templates select="part" mode="asrequired"/>
					</fo:table>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="part" mode="required">
		<xsl:variable name="vendorCode">
			<xsl:value-of select="vendor-code"/>
		</xsl:variable>
		<xsl:variable name="partNumber">
			<xsl:value-of select="part-num"/>
		</xsl:variable>
		<xsl:variable name="stockNumber">
			<xsl:value-of select="stk-num"/>
		</xsl:variable>
		<xsl:variable name="quantity" select="part-qty"/>
		<xsl:variable name="flag" select="part-flags/part-flag"/>
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$hflag='hf01'">
						<xsl:if test="part-state='R'">
							<xsl:choose>
								<xsl:when test="part-state='R'">
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="part-num">
														<fo:block>
															<xsl:apply-templates select="part-num"/>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>	 </fo:block>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:choose>
													<xsl:when test="part-desc">
														<fo:block-container max-width="3in" start-indent="8pt">
															<fo:block>
																<xsl:apply-templates select="part-desc"/>
															</fo:block>
														</fo:block-container>
													</xsl:when>
													<xsl:otherwise>
														<fo:block> </fo:block>
													</xsl:otherwise>
													<!--<xsl:otherwise>
																	<fo:block-container max-width="3in">
																				<fo:block>
																					<xsl:apply-templates select="document(concat($server,'/getPartInfo.dox?vendorCode=',$vendorCode,'&amp;partNumber=',$partNumber,'&amp;stockNumber=',$stockNumber,'&amp;sessionid=',$sessionid))/results/partdata/partDescription"/>
																				</fo:block>
																			</fo:block-container>
																		</xsl:otherwise>-->
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="vendor-code">
														<fo:block>
															<xsl:apply-templates select="vendor-code"/>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>		 </fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="part-qty=0">
														<fo:block text-align="left">
															<xsl:text>A/R</xsl:text>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>
															<xsl:value-of select="part-qty"/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font-weight="bold">
													<xsl:value-of select="'N'"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="$flag='EN02'">
														<fo:block font-weight="bold">
															<xsl:value-of select="'Y'"/>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>
															<xsl:value-of select="'N'"/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<fo:leader leader-pattern="rule" leader-length="7.3in"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:when>
					<!--if not ad related-->
					<xsl:otherwise>
						<xsl:variable name="doc" select="document(concat($docato.server,'/UpdateServlet?id=LookupParts&amp;vendorCode=',$vendorCode,'&amp;partNumber=',(url:encode($partNumber))))/Interface/part/stk"/>
						<xsl:variable name="errcond" select="document(concat($docato.server,'/UpdateServlet?id=LookupParts&amp;vendorCode=',$vendorCode,'&amp;partNumber=',(url:encode($partNumber))))"/>
						<xsl:choose>
							<xsl:when test="part-state='R'">
								<xsl:choose>
									<xsl:when test="$doc[child::mpn]">
										<!--if mpn exists-->
										<fo:table-body>
											<xsl:for-each select="$doc/mpn">
												<fo:table-row>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="@ind='P'">
																<fo:block space-before="8pt">
																	<xsl:text>Preferred: </xsl:text>
																	<xsl:value-of select="@num"/>
																	<fo:block start-indent="8pt">
																		<xsl:value-of select="../@desc"/>
																	</fo:block>
																</fo:block>
															</xsl:when>
															<xsl:when test="@ind='I'">
																<fo:block start-indent="8pt">
																	<xsl:text>Interchange: </xsl:text>
																	<xsl:value-of select="@num"/>
																</fo:block>
															</xsl:when>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="@ind='P'">
																	<xsl:value-of select="@vcode"/>
																</xsl:when>
																<xsl:when test="@ind='I'">
																	<xsl:value-of select="@vcode"/>
																</xsl:when>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="$quantity=0">
																	<xsl:text>A/R</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$quantity"/>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN01'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN02'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<!--<fo:table-cell>
															<fo:block-container max-width="3in">
																<fo:block>
																	<xsl:value-of select="../@desc"/>
																</fo:block>
															</fo:block-container>
														</fo:table-cell>-->
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block> 
													 
												</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</xsl:for-each>
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<fo:leader leader-pattern="rule" leader-length="7.3in"/>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</xsl:when>
									<xsl:otherwise>
										<!--if no return from interface, display information as is-->
										<!--TBD multiple stk num error message-->
										<!--	<xsl:if test="part-state='R'">
															<xsl:choose>
																<xsl:when test="part-state='R'">-->
										<!--check for error conditions-->
										<xsl:if test="$errcond/Interface/part/@error='SYS'">
											<xsl:text>UNABLE TO CONNECT TO SCEPTRE TO RETRIEVE PART DATA</xsl:text>
										</xsl:if>
										<xsl:if test="$errcond/Interface/part/@error='MULT'">
											<fo:table-body>
												<fo:table-row>
													<fo:table-cell number-columns-spanned="4" padding-before="5pt">
														<fo:block font-weight="bold">	NOTE: Check the IPC for the correct MPN.</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<!--	<xsl:choose>
																					<xsl:when test="part-num">
																						<xsl:apply-templates select="part-num"/>
																					</xsl:when>
																					<xsl:otherwise>
											</xsl:otherwise>
																				</xsl:choose>-->
														<xsl:choose>
															<xsl:when test="part-desc">
																<fo:block-container max-width="3in" start-indent="8pt">
																	<fo:block>
																		<xsl:apply-templates select="part-desc"/>
																	</fo:block>
																</fo:block-container>
															</xsl:when>
															<xsl:otherwise>
																<fo:block> </fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<!--	<xsl:choose>
																					<xsl:when test="vendor-code">
																						<xsl:apply-templates select="vendor-code"/>
																					</xsl:when>
																					<xsl:otherwise>
											</xsl:otherwise>
																				</xsl:choose>-->
														</fo:block>
													</fo:table-cell>
													<!--	<fo:table-cell>
																			<fo:block>
																				<xsl:choose>
																					<xsl:when test="stk-num">
																						<xsl:value-of select="stk-num"/>
																					</xsl:when>
																					<xsl:otherwise>
																						<xsl:apply-templates select="document(concat($server,'/getPartInfo.dox?vendorCode=',$vendorCode,'&amp;partNumber=',$partNumber,'&amp;sessionid=',$sessionid))/results/partdata/stockNumber"/>
																					</xsl:otherwise>
																				</xsl:choose>
																			</fo:block>
																		</fo:table-cell>-->
													<fo:table-cell>
														<fo:block text-align="left">
															<xsl:choose>
																<xsl:when test="part-qty=0">
																	<xsl:text>A/R</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="../part-qty"/>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN01'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN02'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:leader leader-pattern="rule" leader-length="7.3in"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</xsl:if>
										<xsl:if test="$errcond/Interface/part/@error='NODATA'">
											<fo:table-body>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="part-num">
																	<xsl:apply-templates select="part-num"/>
																</xsl:when>
																<xsl:otherwise> 
											</xsl:otherwise>
															</xsl:choose>
														</fo:block>
														<xsl:choose>
															<xsl:when test="part-desc">
																<fo:block-container max-width="3in" start-indent="8pt">
																	<fo:block>
																		<xsl:apply-templates select="part-desc"/>
																	</fo:block>
																</fo:block-container>
															</xsl:when>
															<xsl:otherwise>
																<fo:block> </fo:block>
															</xsl:otherwise>
															<!--<xsl:otherwise>
																			<fo:block-container max-width="3in">
																				<fo:block>
																					<xsl:apply-templates select="document(concat($server,'/getPartInfo.dox?vendorCode=',$vendorCode,'&amp;partNumber=',$partNumber,'&amp;stockNumber=',$stockNumber,'&amp;sessionid=',$sessionid))/results/partdata/partDescription"/>
																				</fo:block>
																			</fo:block-container>
																				</xsl:otherwise>-->
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="vendor-code">
																	<xsl:apply-templates select="vendor-code"/>
																</xsl:when>
																<xsl:otherwise> 
											</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<!--	<fo:table-cell>
																			<fo:block>
																				<xsl:choose>
																					<xsl:when test="stk-num">
																						<xsl:value-of select="stk-num"/>
																					</xsl:when>
																					<xsl:otherwise>
																						<xsl:apply-templates select="document(concat($server,'/getPartInfo.dox?vendorCode=',$vendorCode,'&amp;partNumber=',$partNumber,'&amp;sessionid=',$sessionid))/results/partdata/stockNumber"/>
																					</xsl:otherwise>
																				</xsl:choose>
																			</fo:block>
																		</fo:table-cell>-->
													<fo:table-cell>
														<fo:block text-align="left">
															<xsl:choose>
																<xsl:when test="part-qty=0">
																	<xsl:text>A/R</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="part-qty"/>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN01'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN02'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:leader leader-pattern="rule" leader-length="7.3in"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</xsl:if>
										<!--	</xsl:when>
															</xsl:choose>
														</xsl:if>-->
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Parts for Text Pages -->
	<xsl:template match="part" mode="asrequired">
		<xsl:variable name="vendorCode">
			<xsl:value-of select="vendor-code"/>
		</xsl:variable>
		<xsl:variable name="partNumber">
			<xsl:value-of select="part-num"/>
		</xsl:variable>
		<xsl:variable name="stockNumber">
			<xsl:value-of select="stk-num"/>
		</xsl:variable>
		<xsl:variable name="quantity" select="part-qty"/>
		<xsl:variable name="flag" select="part-flags/part-flag"/>
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$hflag='hf01'">
						<xsl:if test="part-state='A'">
							<xsl:choose>
								<xsl:when test="part-state='A'">
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="part-num">
														<fo:block>
															<xsl:apply-templates select="part-num"/>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>	 </fo:block>
													</xsl:otherwise>
												</xsl:choose>
												<xsl:choose>
													<xsl:when test="part-desc">
														<fo:block-container max-width="3in" start-indent="8pt">
															<fo:block>
																<xsl:apply-templates select="part-desc"/>
															</fo:block>
														</fo:block-container>
													</xsl:when>
													<xsl:otherwise>
														<fo:block> </fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="vendor-code">
														<fo:block>
															<xsl:apply-templates select="vendor-code"/>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>		 </fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="part-qty=0">
														<fo:block text-align="left">
															<xsl:text>A/R</xsl:text>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>
															<xsl:value-of select="part-qty"/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block font-weight="bold">
													<xsl:value-of select="'N'"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="$flag='EN02'">
														<fo:block font-weight="bold">
															<xsl:value-of select="'Y'"/>
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block>
															<xsl:value-of select="'N'"/>
														</fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<fo:leader leader-pattern="rule" leader-length="7.3in"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:when>
					<!--if not ad related-->
					<xsl:otherwise>
						<xsl:variable name="doc" select="document(concat($docato.server,'/UpdateServlet?id=LookupParts&amp;vendorCode=',$vendorCode,'&amp;partNumber=',(url:encode($partNumber))))/Interface/part/stk"/>
						<xsl:variable name="errcond" select="document(concat($docato.server,'/UpdateServlet?id=LookupParts&amp;vendorCode=',$vendorCode,'&amp;partNumber=',(url:encode($partNumber))))"/>
						<xsl:choose>
							<xsl:when test="part-state='A'">
								<xsl:choose>
									<xsl:when test="$doc[child::mpn]">
										<!--if mpn exists-->
										<fo:table-body>
											<xsl:for-each select="$doc/mpn">
												<fo:table-row>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="@ind='P'">
																<fo:block space-before="8pt">
																	<xsl:text>Preferred: </xsl:text>
																	<xsl:value-of select="@num"/>
																</fo:block>
																<fo:block start-indent="8pt">
																	<xsl:value-of select="../@desc"/>
																</fo:block>
															</xsl:when>
															<xsl:when test="@ind='I'">
																<fo:block start-indent="8pt">
																	<xsl:text>Interchange: </xsl:text>
																	<xsl:value-of select="@num"/>
																</fo:block>
															</xsl:when>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="@ind='P'">
																	<xsl:value-of select="@vcode"/>
																</xsl:when>
																<xsl:when test="@ind='I'">
																	<xsl:value-of select="@vcode"/>
																</xsl:when>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="$quantity=0">
																	<xsl:text>A/R</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$quantity"/>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN01'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN02'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<!--	<fo:table-cell>
															<fo:block-container max-width="3in">
																<fo:block>
																	<xsl:value-of select="../@desc"/>
																</fo:block>
															</fo:block-container>
														</fo:table-cell>-->
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block> 
													 
												</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</xsl:for-each>
											<fo:table-row>
												<fo:table-cell>
													<fo:block>
														<fo:leader leader-pattern="rule" leader-length="7.3in"/>
													</fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</xsl:when>
									<xsl:otherwise>
										<!--check for error conditions-->
										<xsl:if test="$errcond/Interface/part/@error='SYS'">
											<xsl:text>UNABLE TO CONNECT TO SCEPTRE TO RETRIEVE PART DATA</xsl:text>
										</xsl:if>
										<xsl:if test="$errcond/Interface/part/@error='MULT'">
											<fo:table-body>
												<fo:table-row>
													<fo:table-cell number-columns-spanned="4" padding-before="5pt">
														<fo:block font-weight="bold">	NOTE: Check the IPC for the correct MPN.</fo:block>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<!--	<xsl:choose>
																					<xsl:when test="part-num">
																						<xsl:apply-templates select="part-num"/>
																					</xsl:when>
																					<xsl:otherwise>
											</xsl:otherwise>
																				</xsl:choose>-->
															<xsl:choose>
																<xsl:when test="part-desc">
																	<fo:block-container max-width="3in" start-indent="8pt">
																		<fo:block>
																			<xsl:apply-templates select="part-desc"/>
																		</fo:block>
																	</fo:block-container>
																</xsl:when>
																<xsl:otherwise>
																	<fo:block> </fo:block>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<!--	<xsl:choose>
																					<xsl:when test="vendor-code">
																						<xsl:apply-templates select="vendor-code"/>
																					</xsl:when>
																					<xsl:otherwise>
											</xsl:otherwise>
																				</xsl:choose>-->
														</fo:block>
													</fo:table-cell>
													<!--	<fo:table-cell>
																			<fo:block>
																				<xsl:choose>
																					<xsl:when test="stk-num">
																						<xsl:value-of select="stk-num"/>
																					</xsl:when>
																					<xsl:otherwise>
																						<xsl:apply-templates select="document(concat($server,'/getPartInfo.dox?vendorCode=',$vendorCode,'&amp;partNumber=',$partNumber,'&amp;sessionid=',$sessionid))/results/partdata/stockNumber"/>
																					</xsl:otherwise>
																				</xsl:choose>
																			</fo:block>
																		</fo:table-cell>-->
													<fo:table-cell>
														<fo:block text-align="left">
															<xsl:choose>
																<xsl:when test="part-qty=0">
																	<xsl:text>A/R</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="../part-qty"/>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN01'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN02'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:leader leader-pattern="rule" leader-length="7.3in"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</xsl:if>
										<xsl:if test="$errcond/Interface/part/@error='NODATA'">
											<fo:table-body>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="part-num">
																	<xsl:apply-templates select="part-num"/>
																</xsl:when>
																<xsl:otherwise> 
											</xsl:otherwise>
															</xsl:choose>
														</fo:block>
														<xsl:choose>
															<xsl:when test="part-desc">
																<fo:block-container max-width="3in" start-indent="8pt">
																	<fo:block>
																		<xsl:apply-templates select="part-desc"/>
																	</fo:block>
																</fo:block-container>
															</xsl:when>
															<xsl:otherwise>
																<fo:block> </fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<fo:block>
															<xsl:choose>
																<xsl:when test="vendor-code">
																	<xsl:apply-templates select="vendor-code"/>
																</xsl:when>
																<xsl:otherwise> 
											</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<!--	<fo:table-cell>
																			<fo:block>
																				<xsl:choose>
																					<xsl:when test="stk-num">
																						<xsl:value-of select="stk-num"/>
																					</xsl:when>
																					<xsl:otherwise>
																						<xsl:apply-templates select="document(concat($server,'/getPartInfo.dox?vendorCode=',$vendorCode,'&amp;partNumber=',$partNumber,'&amp;sessionid=',$sessionid))/results/partdata/stockNumber"/>
																					</xsl:otherwise>
																				</xsl:choose>
																			</fo:block>
																		</fo:table-cell>-->
													<fo:table-cell>
														<fo:block text-align="left">
															<xsl:choose>
																<xsl:when test="part-qty=0">
																	<xsl:text>A/R</xsl:text>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="part-qty"/>
																</xsl:otherwise>
															</xsl:choose>
														</fo:block>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN01'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
													<fo:table-cell>
														<xsl:choose>
															<xsl:when test="$flag='EN02'">
																<fo:block font-weight="bold">
																	<xsl:value-of select="'Y'"/>
																</fo:block>
															</xsl:when>
															<xsl:otherwise>
																<fo:block>
																	<xsl:value-of select="'N'"/>
																</fo:block>
															</xsl:otherwise>
														</xsl:choose>
													</fo:table-cell>
												</fo:table-row>
												<fo:table-row>
													<fo:table-cell>
														<fo:block>
															<fo:leader leader-pattern="rule" leader-length="7.3in"/>
														</fo:block>
													</fo:table-cell>
												</fo:table-row>
											</fo:table-body>
										</xsl:if>
										<!--	</xsl:when>
															</xsl:choose>
														</xsl:if>-->
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="results">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="partdata">
		<xsl:for-each select=".">
			<xsl:apply-templates/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="partdata/partDescription">
		<fo:block>
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	<xsl:template match="partdata/stockNumber">
		<fo:block>
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	<xsl:template name="partsTextPages">
		<fo:block>
			<xsl:apply-templates select="//parts"/>
		</fo:block>
	</xsl:template>
	<xsl:template name="partsDesc">
		<!--Changes for AMT enhancements parts indicator-->
		<fo:block font-weight="bold" wrap-option="wrap" start-indent="12pt">If Allow Sub is set to "N", you cannot substitute the listed part number for another part number unless otherwise stated in this work card.</fo:block>
		<fo:block font-weight="bold" wrap-option="wrap" start-indent="12pt" space-after="12pt">If IPC Check Req'd is set to "Y", then you must check the IPC to verify that the part number is correct.</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Tools*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="tools">
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block space-before="6pt" space-before.conditionality="retain">
					<xsl:if test="./tool/tool-state='R'">
						<fo:block space-before="6pt" space-before.conditionality="retain">
							<fo:inline font-weight="bold">EQUIPMENT REQUIRED: </fo:inline>
							<xsl:call-template name="toolDesc"/>
							<xsl:apply-templates select="tool" mode="required"/>
						</fo:block>
					</xsl:if>
					<xsl:if test="./tool/tool-state='A'">
						<fo:block space-before="6pt" space-before.conditionality="retain">
							<fo:inline font-weight="bold">EQUIPMENT, AS REQUIRED:</fo:inline>
							<xsl:call-template name="toolDesc"/>
							<xsl:apply-templates select="tool" mode="asrequired"/>
						</fo:block>
					</xsl:if>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="toolDesc">
		<fo:block space-before="6pt" space-before.conditionality="retain">
			<fo:table table-layout="fixed">
				<fo:table-column column-width="55mm"/>
				<fo:table-column column-width="35mm"/>
				<fo:table-column column-width="20mm"/>
				<fo:table-column column-width="200mm"/>
				<fo:table-body>
					<fo:table-row text-decoration="underline">
						<fo:table-cell>
							<fo:block text-decoration="underline">Tool.Number</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Vcode</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Quan</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Description</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<xsl:template match="tool" mode="required">
		<xsl:variable name="vendorCode">
			<xsl:value-of select="vendor-code"/>
		</xsl:variable>
		<xsl:variable name="toolNumber">
			<xsl:value-of select="tool-num"/>
		</xsl:variable>
		<xsl:variable name="stockNumber">
			<xsl:value-of select="stk-num"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="tool-state='R'">
					<xsl:choose>
						<xsl:when test="tool-state='R'">
							<fo:table>
								<fo:table-column column-width="55mm"/>
								<fo:table-column column-width="35mm"/>
								<fo:table-column column-width="20mm"/>
								<fo:table-column column-width="200mm"/>
								<fo:table-body>
									<xsl:for-each select=".">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:choose>
														<xsl:when test="tool-num">
															<!--	<xsl:value-of select="stk-num"/>-->
															<xsl:value-of select="tool-num"/>
														</xsl:when>
														<xsl:otherwise> </xsl:otherwise>
													</xsl:choose>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:choose>
														<xsl:when test="vendor-code">
															<xsl:apply-templates select="vendor-code"/>
														</xsl:when>
														<xsl:otherwise>
											</xsl:otherwise>
													</xsl:choose>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block text-align="left">
													<xsl:choose>
														<xsl:when test="tool-qty=0">
															<xsl:text>A/R</xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="tool-qty"/>
														</xsl:otherwise>
													</xsl:choose>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="tool-desc">
														<fo:block-container max-width="3in">
															<fo:block>
																<xsl:apply-templates select="tool-desc"/>
															</fo:block>
														</fo:block-container>
													</xsl:when>
													<xsl:otherwise>
														<fo:block> </fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tool" mode="asrequired">
		<xsl:variable name="vendorCode">
			<xsl:value-of select="vendor-code"/>
		</xsl:variable>
		<xsl:variable name="toolNumber">
			<xsl:value-of select="tool-num"/>
		</xsl:variable>
		<xsl:variable name="stockNumber">
			<xsl:value-of select="stk-num"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="tool-state='A'">
					<xsl:choose>
						<xsl:when test="tool-state='A'">
							<fo:table>
								<fo:table-column column-width="55mm"/>
								<fo:table-column column-width="35mm"/>
								<fo:table-column column-width="20mm"/>
								<fo:table-column column-width="200mm"/>
								<fo:table-body>
									<xsl:for-each select=".">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:choose>
														<xsl:when test="tool-num">
															<!--	<xsl:value-of select="stk-num"/>-->
															<xsl:value-of select="tool-num"/>
														</xsl:when>
														<xsl:otherwise> </xsl:otherwise>
													</xsl:choose>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:choose>
														<xsl:when test="vendor-code">
															<xsl:apply-templates select="vendor-code"/>
														</xsl:when>
														<xsl:otherwise>
											</xsl:otherwise>
													</xsl:choose>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block text-align="left">
													<xsl:choose>
														<xsl:when test="tool-qty=0">
															<xsl:text>A/R</xsl:text>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="tool-qty"/>
														</xsl:otherwise>
													</xsl:choose>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="tool-desc">
														<fo:block-container max-width="3in">
															<fo:block>
																<xsl:apply-templates select="tool-desc"/>
															</fo:block>
														</fo:block-container>
													</xsl:when>
													<xsl:otherwise>
														<fo:block> </fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
									</xsl:for-each>
								</fo:table-body>
							</fo:table>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="results">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="tooldata">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tooldata/toolDescription">
		<fo:block>
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	<xsl:template match="stockNumber">
		<fo:block>
			<xsl:value-of select="."/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Tools text Pages*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template name="toolsTextPages">
		<fo:block>
			<xsl:apply-templates select="//tools"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Drawings*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="drawings">
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block space-before="6pt" space-before.conditionality="retain">
					<fo:block keep-with-next="always">
						<fo:inline font-weight="bold">DRAWINGS REQUIRED: </fo:inline>
					</fo:block>
					<fo:table table-layout="fixed">
						<fo:table-column column-width="40mm"/>
						<fo:table-column column-width="45mm"/>
						<fo:table-column column-width="40mm"/>
						<fo:table-column column-width="proportional-column-width(3)"/>
						<fo:table-body>
							<fo:table-row text-decoration="underline">
								<fo:table-cell>
									<fo:block text-decoration="underline">Originator</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Drawing Code</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Status</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block text-decoration="underline">Drawing Comment</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<xsl:apply-templates/>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="drawing">
		<xsl:choose>
			<xsl:when test=".//eff">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="draw-vendor-code">
									<xsl:apply-templates select="draw-vendor-code" mode="list"/>
								</xsl:when>
								<xsl:otherwise> </xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="draw-num">
									<xsl:apply-templates select="draw-num" mode="list"/>
									<xsl:if test="draw-rev">

							(<xsl:apply-templates select="draw-rev" mode="list"/>)

							</xsl:if>
								</xsl:when>
								<xsl:otherwise> </xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="draw-type">
									<xsl:apply-templates select="draw-type" mode="list"/>
								</xsl:when>
								<xsl:otherwise> </xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell>
						<fo:block>
							<xsl:choose>
								<xsl:when test="draw-comment">
									<xsl:apply-templates select="draw-comment" mode="list"/>
								</xsl:when>
								<xsl:otherwise> </xsl:otherwise>
							</xsl:choose>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- DRAWINGS FOR TEXT PAGES -->
	<xsl:template name="drawingsTextPages">
		<fo:block>
			<xsl:apply-templates select="//drawings"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Circuit-Breakers*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="circuit-breakers">
		<fo:block space-before="6pt" space-before.conditionality="retain">
			<fo:block>
				<fo:inline font-weight="bold">CIRCUIT BREAKERS: </fo:inline>
			</fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="25mm"/>
				<fo:table-column column-width="25mm"/>
				<fo:table-column column-width="30mm"/>
				<fo:table-column column-width="25mm"/>
				<fo:table-body>
					<fo:table-row text-decoration="underline">
						<fo:table-cell>
							<fo:block text-decoration="underline">Source Key</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Zn Num</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Cbpnl Num</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Cb Num</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Cb State</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<xsl:apply-templates/>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<xsl:template match="circuit-breaker">
		<fo:table-row>
			<fo:table-cell>
				<fo:block>
					<xsl:choose>
						<xsl:when test="source-key">
							<xsl:apply-templates select="source-key" mode="list"/>
						</xsl:when>
						<xsl:otherwise> - </xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:choose>
						<xsl:when test="zn-num">
							<xsl:apply-templates select="zn-num" mode="list"/>
						</xsl:when>
						<xsl:otherwise> - </xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:choose>
						<xsl:when test="cbpnl-num">
							<xsl:apply-templates select="cbpnl-num" mode="list"/>
						</xsl:when>
						<xsl:otherwise> - </xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:choose>
						<xsl:when test="cb-num">
							<xsl:apply-templates select="cb-num" mode="list"/>
						</xsl:when>
						<xsl:otherwise> - </xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block>
					<xsl:choose>
						<xsl:when test="cb-state">
							<xsl:apply-templates select="cb-state" mode="list"/>
						</xsl:when>
						<xsl:otherwise> - </xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Mainfunc*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="mainfunc">
		<xsl:choose>
			<xsl:when test="/workcard/prelreq/wctype='E' or /workcard/prelreq/wctype='W'">
				<fo:block font-weight="bold" space-after="5pt">
					<fo:inline text-decoration="underline">CAUTION:</fo:inline> ALWAYS OBEY THE PRECAUTIONS THAT FOLLOW TO KEEP WIRING IN A SATISFACTORY CONDITION (ELECTRICALLY AND MECHANICALLY SERVICEABLE). </fo:block>
				<fo:block space-before="5pt" space-after="5pt">
					<fo:inline>WHEN YOU DO MAINTENANCE WORK, REPAIRS OR MODIFICATIONS, ALWAYS KEEP WIRING, COMPONENTS AND THE WORK AREA AS CLEAN AS POSSIBLE. TO DO THIS:</fo:inline>
					<fo:list-block space-before="5pt" start-indent="14pt">
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>PUT PROTECTION, SUCH AS PLASTIC SHEETING, CLOTHS, ETC. AS NECESSARY ON WIRING AND COMPONENTS.</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>REGULARLY REMOVE ALL SHAVINGS, UNWANTED MATERIAL AND OTHER CONTAMINATION.</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>DO NOT USE WIRE BUNDLES, TUBING, DUCTS, OR OTHER COMPONENTS AS A STEP OR HAND-HOLD. DAMAGE TO EQUIPMENT CAN OCCUR.</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>KEEP TOOLS, TOOL TRAYS, AND OTHER WORK ITEMS OFF THE WIRES. OBJECTS PUT ON THE WIRE BUNDLES OR THEIR RELATED COMPONENTS CAN CAUSE DAMAGE TO THE WIRES, INSULATION, AND CONNECTORS.</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
				</fo:block>
				<fo:block space-before="5pt" space-after="5pt">THESE PRECAUTIONS WILL DECREASE THE RISK OF CONTAMINATION AND DAMAGE TO THE WIRING INSTALLATION. </fo:block>
				<fo:block space-before="5pt" space-after="5pt">FOR AIRCRAFT PROTECTION, REFERENCE: 
									<fo:list-block space-before="5pt" start-indent="14pt">
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>AIRBUS – ESPM 20-50-00</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>BOEING, ALL MODELS (EXCEPT B717) – AMM 20-60-07</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>B717 – AMM 20-30-00</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>MD88/MD90 – AMM 20-50-00</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>BOMBARDIER – AMP BD500-A-J20-70-00-00AAA-913G-A</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
				</fo:block>
				<fo:block space-before="5pt" space-after="5pt">IF THERE IS CONTAMINATION, THEN CLEAN AS REFERENCED:
									<fo:list-block space-before="5pt" start-indent="14pt">
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>AIRBUS A320FAM, A330 – ESPM 20-55-00</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>AIRBUS A350 – ESPM 20-55-50</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>BOEING, ALL MODELS (EXCEPT B717) – AMM 20-60-02</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>B717, MD88, MD90 – AMM 20-51-01</fo:block>
							</fo:list-item-body>
						</fo:list-item>
						<fo:list-item space-after="3pt">
							<fo:list-item-label end-indent="label-end()">
								<fo:block>•</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="20pt">
								<fo:block>BOMBARDIER – AMP BD500-A-J20-70-00-00AAA-254A-A</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
				</fo:block>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		<fo:block space-after="40pt"/>
		<fo:block font-family="Helvetica" font-size="10pt">
			<xsl:choose>
				<!--<xsl:when test="*[self::graphic[following-sibling::table] or self::graphic]">
					<xsl:apply-templates select="*[not(self::graphic) and not(self::table[preceding::graphic])]"/>
				</xsl:when>-->
				<xsl:when test="*[(self::graphic[not(parent::figure) and following-sibling::table] or self::graphic[not(parent::figure)]) or (self::figure[following-sibling::table] or self::figure)]">
					<xsl:apply-templates select="*[not(self::graphic) and not(self::table[preceding::graphic]) and not(self::figure) and not(self::table[preceding::figure])]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="string(//sign)">
					<fo:block text-align="center">
						<fo:inline text-align="center" font-weight="bold" keep-together.within-page="always" font-size="12pt">*** END OF WORK STEPS / NO FURTHER SIGNOFFS REQUIRED

						***</fo:inline>
					</fo:block>
				</xsl:when>
				<xsl:otherwise> </xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<xsl:template match="mainfunc" mode="signoff">
		<fo:block font-family="Helvetica" font-size="10pt">
			<xsl:choose>
				<xsl:when test="*[((self::sign) or (child::sign) or self::graphic[not(parent::figure) and following-sibling::table] or self::graphic[not(parent::figure)]) or (self::figure[following-sibling::table] or self::figure)]">
					<xsl:apply-templates select="*[not(self::sign) and not(self::graphic) and not(self::table[preceding::graphic]) and not(self::figure) and not(self::table[preceding::figure])]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="signoff"/>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Task Key*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="task-key">
		<fo:inline>
			<fo:inline font-weight="bold"> Tasks: </fo:inline>
			<xsl:apply-templates mode="inline"/>
		</fo:inline>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Title*************             -->
	<!--________________________________________________________________________

	<xsl:template match="title">

		<fo:block text-align="center" font-weight="bold" keep-with-previous.within-page="always">

			<xsl:apply-templates/>

		</fo:block>

	</xsl:template>_-->
	<!--_________________________________________________________________________-->
	<!--         ************* Proc-Num*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="proc-num">
		<xsl:choose>
			<xsl:when test="para[@id='DAL']">
				<fo:block text-align="center" font-weight="bold">
					<xsl:value-of select="para"/>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Information*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="information">
		<fo:block space-before="6pt" space-before.conditionality="retain" space-after="3pt">
			<fo:inline font-weight="bold" text-align="center">INFORMATION: </fo:inline>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="information/para">
		<fo:block space-after="3pt" space-before="3pt">
			<xsl:call-template name="indicateChangesParaRow"/>
			<!-- QC525 Indicate changes added for revision bar issue -->
			<xsl:apply-templates/>
			<xsl:call-template name="indicateChangesEndParaRow"/>
			<!-- QC525 Indicate changes added for revision bar issue -->
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Warranty*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="warranty"> </xsl:template>
	<xsl:template match="warranty" mode="coverpage">
		<xsl:choose>
			<xsl:when test="not(string(.))"/>
			<xsl:otherwise>
				<fo:block space-before="6pt" space-before.conditionality="retain">
					<fo:inline font-weight="bold">WARRANTY CLAIM: </fo:inline>
					<fo:inline>
						<xsl:apply-templates mode="coverpage"/>
					</fo:inline>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Planing*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="planning"/>
	<xsl:template match="planning" mode="coverpage">
		<fo:list-block space-before="6pt" start-indent="0mm" provisional-distance-between-starts="32mm" space-before.conditionality="retain">
			<fo:list-item>
				<fo:list-item-label>
					<fo:block font-weight="bold">PLANNING NOTE: </fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()" end-indent="0pt">
					<fo:block>
						<xsl:apply-templates mode="coverpage"/>
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>
		</fo:list-block>
	</xsl:template>
	<xsl:template match="planning/para" mode="coverpage">
		<fo:block space-after="3pt" space-before="3pt">
			<xsl:apply-templates mode="coverpage"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Head-Flags*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="head-flags|head-flag">
		<xsl:value-of select="@type"/>
	</xsl:template>
	<!--**********************************Req Access************************************-->
	<xsl:template match="req-access">
		<xsl:choose>
			<xsl:when test=".//location or .//eff or (.//location and .//eff)">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block space-before="6pt" space-before.conditionality="discard">
					<fo:inline>REQUIRED ACCESS</fo:inline>: <xsl:apply-templates/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="req-access/para|req-access/link/para" priority="2">
		<xsl:apply-templates/>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Warning*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="eff/effgrp"> </xsl:template>
	<xsl:template match="warning">
		<xsl:choose>
			<xsl:when test=".//location or .//eff or (.//location and .//eff)">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:list-block keep-together.within-page="always" space-before="6pt" start-indent="0mm" provisional-distance-between-starts="20mm">
					<fo:list-item>
						<fo:list-item-label font-weight="bold">
							<fo:block>
								<fo:inline text-decoration="underline">WARNING</fo:inline>
								<fo:inline>: </fo:inline>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()" end-indent="0pt">
							<fo:block>
								<xsl:apply-templates/>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="warning/para|warning/link/para">
		<fo:block font-weight="bold" text-transform="uppercase">
			<!-- QC525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesParaRow"/>
			<xsl:apply-templates/>
			<xsl:call-template name="indicateChangesEndParaRow"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* NOTE*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="note">
		<xsl:choose>
			<xsl:when test=".//location or .//eff or (.//location and .//eff)">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:list-block space-before="6pt" start-indent="0mm" provisional-distance-between-starts="13mm">
					<fo:list-item>
						<fo:list-item-label end-indent="label-end()">
							<fo:block font-weight="bold">NOTE: </fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()" end-indent="0pt">
							<fo:block>
								<xsl:apply-templates/>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="note/para|note/link/para">
		<fo:block>
			<!-- QC525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesParaRow"/>
			<xsl:apply-templates/>
			<xsl:call-template name="indicateChangesEndParaRow"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="note/xi:include">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="xi:include">
		<xsl:variable name="targetDocId">
			<xsl:value-of select="substring-before(@href,'.')"/>
		</xsl:variable>
		<xsl:variable name="targetXpointer">
			<xsl:value-of select="@xpointer"/>
		</xsl:variable>
		<!-- This URI returns the complete XML structure of the included/referenced work card inside another work card -->
		<xsl:apply-templates select="document(concat($docato.server,'/getLinkTargetAsXML.dox?id=',$document-id,'&amp;targetResourceId=',$targetDocId,'&amp;targetId=',$targetXpointer,'&amp;typeMappingId=ref1&amp;sessionid=',$docato.sessionid))"/>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Caution*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="caution">
		<xsl:choose>
			<xsl:when test=".//location or .//eff or (.//location and .//eff)">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:list-block keep-together.within-page="always" space-before="6pt" start-indent="0mm" provisional-distance-between-starts="20mm">
					<fo:list-item>
						<fo:list-item-label font-weight="bold">
							<fo:block>
								<fo:inline text-decoration="underline">CAUTION</fo:inline>
								<fo:inline>: </fo:inline>
							</fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()" end-indent="0pt">
							<fo:block>
								<xsl:apply-templates/>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="caution/para|caution/link/para">
		<fo:block font-weight="bold" text-transform="uppercase">
			<!-- QC525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesParaRow"/>
			<xsl:apply-templates/>
			<xsl:call-template name="indicateChangesEndParaRow"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Location*************             -->
	<!--________________________________________________________________________-->
	<xsl:template match="location">
		<fo:block space-before="6pt" space-before.conditionality="retain">
			<fo:block keep-with-next="always">
				<fo:inline font-weight="bold">LOCATION:</fo:inline>
			</fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="proportional-column-width(1)"/>
				<fo:table-column column-width="proportional-column-width(1)"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block text-decoration="underline">Environment</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-decoration="underline">Company</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<xsl:apply-templates/>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<xsl:template match="environment | company">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="."/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         ************* Sources*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="sources"> </xsl:template>
	<xsl:template match="source"> </xsl:template>
	<xsl:template match="type | ref"> </xsl:template>
	<xsl:template name="inline.italicseq">
		<fo:inline font-style="italic" border-left-width="0pt" border-right-width="0pt">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template name="inline.boldseq">
		<fo:inline font-weight="bold" border-left-width="0pt" border-right-width="0pt">
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<xsl:template name="inline.charseq">
		<fo:inline>
			<xsl:apply-templates/>
		</fo:inline>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Emphasis*************             -->
	<!--_________________________________________________________________________-->
	<!-- Define Emphasis Element according to schema -->
	<xsl:template match="emphasis">
		<xsl:choose>
			<xsl:when test="@emph='em01'">
				<xsl:call-template name="inline.boldseq"/>
			</xsl:when>
			<xsl:when test="@emph='em02'">
				<xsl:call-template name="inline.italicseq"/>
			</xsl:when>
			<xsl:when test="@emph='em03'">
				<fo:inline border-left-width="0pt" border-right-width="0pt" text-decoration="underline">
					<xsl:call-template name="inline.charseq"/>
				</fo:inline>
			</xsl:when>
			<xsl:when test="@emph='em04'">
				<fo:inline border-left-width="0pt" border-right-width="0pt" text-decoration="overline">
					<xsl:call-template name="inline.charseq"/>
				</fo:inline>
			</xsl:when>
			<xsl:when test="@emph='em05'">
				<fo:inline border-left-width="0pt" border-right-width="0pt" text-decoration="line-through">
					<xsl:call-template name="inline.charseq"/>
				</fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="count(ancestor::EMPH) mod 2">
						<fo:inline border-left-width="0pt" border-right-width="0pt" font-style="normal">
							<xsl:apply-templates/>
						</fo:inline>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="inline.boldseq"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Graphic*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="figure">
		<!-- QC525 Indicate changes added for revision bar issue -->
		<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<xsl:apply-templates select="graphic"/>
			<xsl:call-template name="indicateChangesEnd"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="graphic">
		<xsl:variable name="wid">
			<xsl:value-of select="number(substring-before(@reprowid,'in'))"/>
		</xsl:variable>
		<xsl:variable name="hgt">
			<xsl:value-of select="number(substring-before(@reprohgt,'in'))"/>
		</xsl:variable>
		<xsl:variable name="dpi">75</xsl:variable>
		<xsl:variable name="width">
			<xsl:value-of select="round($wid * $dpi)"/>
		</xsl:variable>
		<xsl:variable name="height">
			<xsl:value-of select="round($hgt * $dpi)"/>
		</xsl:variable>
		<fo:block display-align="center" text-align="center" start-indent="0mm">
			<!-- QC525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChanges"/>
			<fo:external-graphic text-align="center" content-height="scale-to-fit" keep-with-previous.within-page="always" keep-with-previous="always">
				<xsl:attribute name="src">url(<xsl:value-of select="@href"/>)</xsl:attribute>
				<xsl:attribute name="height"><xsl:variable name="max-height">6.8</xsl:variable><xsl:choose><xsl:when test="@reprohgt"><xsl:choose><xsl:when test="$hgt > $max-height"><xsl:value-of select="concat($max-height,'in')"/></xsl:when><xsl:otherwise><xsl:value-of select="concat((normalize-space(substring-before(@reprohgt,'in'))),'in')"/><!--	<xsl:value-of select="@reprohgt"/>--></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise>

		100%</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:attribute name="width"><xsl:variable name="max-width">6.5</xsl:variable><xsl:choose><xsl:when test="@reprowid"><xsl:choose><xsl:when test="$wid > $max-width"><xsl:value-of select="concat($max-width,'in')"/></xsl:when><xsl:otherwise><xsl:value-of select="concat((normalize-space(substring-before(@reprowid,'in'))),'in')"/></xsl:otherwise></xsl:choose><!--	<xsl:value-of select="@reprowid"/>--></xsl:when><xsl:otherwise>100%</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:attribute name="content-width"><xsl:choose><xsl:when test="@reproscl"><xsl:value-of select="concat(string(@reproscl),'%')"/></xsl:when><xsl:otherwise>scale-to-fit</xsl:otherwise></xsl:choose></xsl:attribute>
			</fo:external-graphic>
			<xsl:call-template name="indicateChangesEnd"/>
		</fo:block>
		<fo:block keep-with-previous.within-page="always" text-align="center">
			<fo:inline text-align="center" font-style="italic" padding-after="8pt" font-size="10pt">
				<xsl:for-each select=".">
					<xsl:choose>
						<xsl:when test="parent::figure">
							<xsl:choose>
								<xsl:when test="parent::figure/@id">
									<!--If its not a DLS card-->
													Figure  <xsl:value-of select="count(preceding::figure[@id]) + count(parent::figure/preceding-sibling::graphic[@id]) + 1"/>
									<xsl:if test="(count(preceding-sibling::graphic[@id]) +count(following-sibling::graphic[@id]) +1) > 1">
				      (Sheet  <xsl:value-of select="count(preceding-sibling::graphic[@id]) + 1"/> of <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(following-sibling::graphic[@id])+ 1"/>)
				   </xsl:if>
									<xsl:choose>
										<xsl:when test="string(title)">
											<xsl:choose>
												<xsl:when test="parent::figure/title">
													<xsl:value-of select="parent::figure/title"/>
													<xsl:if test="string(title)">  :   <xsl:value-of select="title"/>
													</xsl:if>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="title"/>
												</xsl:otherwise>
											</xsl:choose>
											<!--Fig&#160;<xsl:value-of select="count(preceding::figure[@id]) + count(parent::figure/preceding-sibling::graphic[@id]) + 1"/>
				   Sheet <xsl:value-of select="count(preceding-sibling::graphic[@id]) + 1"/>-->
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<!--If there is onle a <graphic> element per the old schema-->
									<xsl:choose>
										<xsl:when test="@id">
											<xsl:choose>
												<xsl:when test="string(title)">
													<!--if its not a DLS card-->
	Figure   <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
													<xsl:value-of select="title"/>
													<!--Fig&#160;<xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
											<xsl:value-of select="title"/>-->
												</xsl:when>
												<xsl:otherwise>  
							</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="title">
												<xsl:value-of select="title"/>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="@id">
									<xsl:choose>
										<xsl:when test="string(title)">
											<!--if its not a DLS card-->
	Figure  <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
											<xsl:value-of select="title"/>
											<!--Fig&#160;<xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
											<xsl:value-of select="title"/>-->
										</xsl:when>
										<xsl:otherwise>  
							</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="title">
										<xsl:value-of select="title"/>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</fo:inline>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Graphic as a child of mainfunc*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="figure" mode="child">
		<!-- QC525 Indicate changes added for revision bar issue -->
		<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<xsl:apply-templates select="graphic" mode="child"/>
			<xsl:call-template name="indicateChangesEnd"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="graphic" mode="child">
		<xsl:variable name="wid">
			<xsl:value-of select="number(substring-before(@reprowid,'in'))"/>
		</xsl:variable>
		<xsl:variable name="hgt">
			<xsl:value-of select="number(substring-before(@reprohgt,'in'))"/>
		</xsl:variable>
		<xsl:variable name="dpi">100</xsl:variable>
		<xsl:variable name="width">
			<xsl:value-of select="concat((round($wid * $dpi)),'px')"/>
		</xsl:variable>
		<xsl:variable name="height">
			<xsl:value-of select="concat((round($hgt * $dpi)),'px')"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block text-align="center">
					<!-- QC525 Indicate changes added for revision bar issue -->
					<xsl:call-template name="indicateChanges"/>
					<fo:external-graphic text-align="center" content-height="scale-to-fit" keep-with-previous.within-page="always" keep-with-previous="always">
						<xsl:attribute name="src">url(<xsl:value-of select="@href"/>)</xsl:attribute>
						<xsl:attribute name="height"><xsl:variable name="max-height">7.8</xsl:variable><xsl:choose><xsl:when test="@reprohgt"><xsl:choose><xsl:when test="$hgt > $max-height"><xsl:value-of select="concat($max-height,'in')"/></xsl:when><xsl:otherwise><xsl:value-of select="concat((normalize-space(substring-before(@reprohgt,'in'))),'in')"/><!--	<xsl:value-of select="@reprohgt"/>--></xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise>

		100%</xsl:otherwise></xsl:choose></xsl:attribute>
						<xsl:attribute name="width"><xsl:choose><xsl:when test="@reprowid"><xsl:value-of select="concat((normalize-space(substring-before(@reprowid,'in'))),'in')"/><!--<xsl:value-of select="@reprowid"/>--></xsl:when><xsl:otherwise>100%</xsl:otherwise></xsl:choose></xsl:attribute>
						<xsl:attribute name="content-width"><xsl:choose><xsl:when test="@reproscl"><xsl:value-of select="concat(string(@reproscl),'%')"/></xsl:when><xsl:otherwise>scale-to-fit</xsl:otherwise></xsl:choose></xsl:attribute>
					</fo:external-graphic>
					<xsl:call-template name="indicateChangesEnd"/>
				</fo:block>
				<fo:block keep-with-previous.within-page="always" text-align="center">
					<fo:inline text-align="center" font-style="italic" padding-after="8pt" font-size="10pt">
						<xsl:for-each select=".">
							<xsl:choose>
								<xsl:when test="parent::figure">
									<xsl:choose>
										<xsl:when test="parent::figure/@id">
											<!--If its not a DLS card-->
													Figure  <xsl:value-of select="count(preceding::figure[@id]) + count(parent::figure/preceding-sibling::graphic[@id]) + 1"/>
											<xsl:if test="(count(preceding-sibling::graphic[@id]) +count(following-sibling::graphic[@id]) +1) > 1">
				      (Sheet  <xsl:value-of select="count(preceding-sibling::graphic[@id]) + 1"/> of <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(following-sibling::graphic[@id])+ 1"/>)
				   </xsl:if>
											<xsl:choose>
												<xsl:when test="parent::figure/title">
													<xsl:value-of select="parent::figure/title"/>
													<xsl:if test="string(title)">  :   <xsl:value-of select="title"/>
													</xsl:if>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="title"/>
												</xsl:otherwise>
											</xsl:choose>
											<!--Fig&#160;<xsl:value-of select="count(preceding::figure[@id]) + count(parent::figure/preceding-sibling::graphic[@id]) + 1"/>
				   Sheet <xsl:value-of select="count(preceding-sibling::graphic[@id]) + 1"/>-->
										</xsl:when>
										<xsl:otherwise>
											<!--If there is onle a <graphic> element per the old schema-->
											<xsl:choose>
												<xsl:when test="@id">
													<xsl:choose>
														<xsl:when test="string(title)">
															<!--if its not a DLS card-->
	Figure   <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
															<xsl:value-of select="title"/>
															<!--Fig&#160;<xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
											<xsl:value-of select="title"/>-->
														</xsl:when>
														<xsl:otherwise>  
							</xsl:otherwise>
													</xsl:choose>
												</xsl:when>
												<xsl:otherwise>
													<xsl:if test="title">
														<xsl:value-of select="title"/>
													</xsl:if>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="@id">
											<xsl:choose>
												<xsl:when test="string(title)">
													<!--if its not a DLS card-->
	Figure   <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
													<xsl:value-of select="title"/>
													<!--Fig&#160;<xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(preceding::figure[@id]) + 1"/>
											<xsl:value-of select="title"/>-->
												</xsl:when>
												<xsl:otherwise>  
							</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="title">
												<xsl:value-of select="title"/>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</fo:inline>
				</fo:block>
				<xsl:if test="following::*[1][self::table]">
					<fo:block page-break-before="always">
						<xsl:apply-templates select="following::*[1][self::table]" mode="table_below_graphic"/>
					</fo:block>
				</xsl:if>
				<!--End of Otherwise-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Order of elements *************             -->
	<!--_________________________________________________________________________-->
	<xsl:template name="order">
		<xsl:param name="in"/>
		<xsl:if test="$in">
			<xsl:apply-templates select="$in"/>
		</xsl:if>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************STEPS*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template name="steps">
		<xsl:param name="format"/>
		<xsl:choose>
			<xsl:when test="text[1]/preceding-sibling::node()">
				<fo:block start-indent="0pt">
					<xsl:call-template name="order">
						<xsl:with-param name="in" select="text[1]/preceding-sibling::node()"/>
					</xsl:call-template>
				</fo:block>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
		<fo:list-block font-family="Helvetica,Symbol">
			<fo:list-item space-before="6pt">
				<fo:list-item-label end-indent="label-end()">
					<xsl:choose>
						<xsl:when test="$format = '1'">
							<fo:block>
								<fo:inline>
									<xsl:number count="step1[((./location[($environment != 'Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[($environment != 'Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[($environment != 'Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[($environment != 'Electronic') and environment ='Printed' or environment=$environment or environment='All']) and (not(text/eff or ./eff)))]" from="/" format="1."/>
								</fo:inline>
							</fo:block>
						</xsl:when>
						<xsl:when test="$format = 'A'">
							<fo:block>
								<fo:inline>
									<xsl:number format="A" count="step2[((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and not(text/eff or ./eff)) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)) and not(text/location or ./location)) or                       ((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)))]" from="/"/>.</fo:inline>
							</fo:block>
						</xsl:when>
						<xsl:when test="$format = '(1)'">
							<fo:block>
								<fo:inline>
									<xsl:number format="(1)" count="step3[((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and not(text/eff or ./eff)) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)) and not(text/location or ./location)) or                       ((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)))]" from="/"/>
								</fo:inline>
							</fo:block>
						</xsl:when>
						<xsl:when test="$format = '(a)'">
							<fo:block>
								<fo:inline>
									<xsl:number format="(a)" count="step4[((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and not(text/eff or ./eff)) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)) and not(text/location or ./location)) or                       ((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)))]" from="/"/>
								</fo:inline>
							</fo:block>
						</xsl:when>
						<xsl:when test="$format = '1)'">
							<fo:block>
								<fo:inline>
									<xsl:number format="1)" count="step5[((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and not(text/eff or ./eff)) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)) and not(text/location or ./location)) or                       ((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)))]" from="/"/>
								</fo:inline>
							</fo:block>
						</xsl:when>
						<xsl:when test="$format = 'a)'">
							<fo:block>
								<fo:inline>
									<xsl:number format="a)" count="step6[((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and not(text/eff or ./eff)) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)) and not(text/location or ./location)) or                       ((./location[environment=$environment or environment='All'] or text/location[environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp)))]" from="/"/>
								</fo:inline>
							</fo:block>
						</xsl:when>
					</xsl:choose>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()" end-indent="0pt">
					<fo:block>
						<xsl:choose>
							<xsl:when test="text">
								<xsl:apply-templates select="text[1]"/>
								<xsl:apply-templates select="text[1]/following-sibling::*"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates/>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>
		</fo:list-block>
		<!--<xsl:if test="following-sibling::*[1][self::sign]">

				<xsl:choose>
								<xsl:when test="not((../../prelreq/wctype='W' or ../../prelreq/wctype='P') and (../../prelreq/model='B767' or ../../prelreq/model='B737' or ../../prelreq/model='B777' or ../../prelreq/model='MD90' or ../../prelreq/model='MD88'))">					<xsl:apply-templates select="following-sibling::*[1][self::sign]"/>
					</xsl:when>
				<xsl:otherwise>
				
				</xsl:otherwise>
				</xsl:choose>
			
		</xsl:if>-->
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Step1*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="step1">
	<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		<xsl:choose>
			<xsl:when test="(text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff)))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				
				<xsl:call-template name="steps">
					<xsl:with-param name="format">1</xsl:with-param>
				</xsl:call-template>
			
			</xsl:otherwise>
		</xsl:choose>
			<xsl:call-template name="indicateChangesEnd"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Cross-References*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="xref">
		<xsl:for-each select="key( 'steps',@xrefid)">
			<xsl:choose>
				<xsl:when test="self::step1 or self::step2">
					<xsl:number count="step1[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]        | step2[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]" format="1.A" level="multiple" from="/"/>
				</xsl:when>
				<xsl:when test="self::step3">
					<xsl:number level="multiple" count="step1[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step2[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step3[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]" format="1.A.(1)."/>
				</xsl:when>
				<xsl:when test="self::step4">
					<xsl:number level="multiple" count="step1[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step2[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step3[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step4[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]" format="1.A.(1).(a)."/>
				</xsl:when>
				<xsl:when test="self::step5">
					<xsl:number level="multiple" count="step1[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step2[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step3[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step4[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step5[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]" format="1.A.(1).(a).1)."/>
				</xsl:when>
				<xsl:when test="self::step6">
					<xsl:number level="multiple" count="step1[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step2[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step3[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step4[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))] | step5[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]| step6[((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All' ] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All']) and  (text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))) or (not(text/location or ./location) and not(text/eff or ./eff)) or ((text/eff/tails/airplane-tail=$tail or ./eff/tails/airplane-tail=$tail or (./eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp) or (text/eff/effgrp=document(concat($docato.server,'/getEffGroupByTail.dox?tail=',$tail,'&amp;carrier=',$carrier,'&amp;mfg=',$mfg,'&amp;model=',$model,'&amp;dash=',$dash,'&amp;sessionid=',$docato.sessionid))/airplane/effgrp))and (not(text/location or ./location)))or ((./location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] or text/location[(environment !='Electronic') and environment ='Printed' or environment=$environment or environment='All'] ) and (not(text/eff or ./eff)))]" format="1.A.(1).(a).1).a."/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:variable name="tab" select="key('FindTable',@xrefid)"/>
		<xsl:for-each select="$tab">
			<xsl:value-of select="count(preceding::table[@id]) + 1"/>
		</xsl:for-each>
		<xsl:variable name="Figure" select="key('FindGraphic',@xrefid)"/>
		<xsl:for-each select="key('FindGraphic',@xrefid)">
			<xsl:choose>
				<xsl:when test="parent::figure">
					<!--Figure <xsl:value-of select="count(preceding-sibling::figure[@id]) + count(preceding-sibling::graphic[@id]) + 1"/>&#160;
sheet <xsl:value-of select="count(preceding-sibling::graphic[@id]) +1"/>-->
					<xsl:choose>
						<xsl:when test="(count(preceding::figure) + count(following::figure) +1) = 1">
							<xsl:choose>
								<!--more than one figure, within each figure is three only 1 graphic,if yes figure 1-->
								<xsl:when test="count(preceding-sibling::graphic)+count(following-sibling::graphic) +1 = 1">
Figure <xsl:value-of select="count(preceding::figure[@id]) + count(preceding::graphic[@id and not(parent::figure)]) + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<!--more than one sheet-->

Figure <xsl:value-of select="count(preceding::figure[@id]) + count(preceding::graphic[@id and not(parent::figure)]) + 1"/> (Sheet <xsl:value-of select="count(preceding-sibling::graphic[@id]) + 1"/> of <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(following-sibling::graphic[@id])+ 1"/>)


</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<!--more than one figure, within each figure is three only 1 graphic,if yes figure 1-->
								<xsl:when test="count(preceding-sibling::graphic)+count(following-sibling::graphic) +1 = 1">
Figure <xsl:value-of select="count(preceding::figure[@id]) + count(preceding::graphic[@id and not(parent::figure)]) + 1"/>
								</xsl:when>
								<xsl:otherwise>
									<!--more than one sheet-->

Figure <xsl:value-of select="count(preceding::figure[@id]) + count(preceding::graphic[@id and not(parent::figure)]) + 1"/> (Sheet <xsl:value-of select="count(preceding-sibling::graphic[@id]) + 1"/> of <xsl:value-of select="count(preceding-sibling::graphic[@id]) +count(following-sibling::graphic[@id])+ 1"/>)


</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(preceding-sibling::figure[@id]) + count(preceding-sibling::graphic[@id]) +1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:variable name="figures" select="key('FindFigure',@xrefid)"> 
 </xsl:variable>
		<xsl:for-each select="$figures">

			Figure <xsl:value-of select="count(preceding-sibling::figure[@id]) + count(preceding-sibling::graphic[@id]) + 1"/>
		</xsl:for-each>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Step2*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="step2">
	<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
			
				<xsl:call-template name="steps">
					<xsl:with-param name="format">A</xsl:with-param>
				</xsl:call-template>
			
			</xsl:otherwise>
		</xsl:choose>
			<xsl:call-template name="indicateChangesEnd"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Step3*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="step3">
	<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				
				<xsl:call-template name="steps">
					<xsl:with-param name="format">(1)</xsl:with-param>
				</xsl:call-template>
				
			</xsl:otherwise>
		</xsl:choose>
			<xsl:call-template name="indicateChangesEnd"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Step4*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="step4">
	<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
			
				<xsl:call-template name="steps">
					<xsl:with-param name="format">(a)</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="indicateChangesEnd"/>
			</xsl:otherwise>
		</xsl:choose>
			<xsl:call-template name="indicateChangesEnd"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
			</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Step5*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="step5">
	<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
			
				<xsl:call-template name="steps">
					<xsl:with-param name="format">1)</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="indicateChangesEnd"/>
			</xsl:otherwise>
		</xsl:choose>
			<xsl:call-template name="indicateChangesEnd"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Step6*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="step6">
	<fo:block>
			<xsl:call-template name="indicateChanges"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
			
				<xsl:call-template name="steps">
					<xsl:with-param name="format">a)</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="indicateChangesEnd"/>
			</xsl:otherwise>
		</xsl:choose>
			<xsl:call-template name="indicateChangesEnd"/>
			<!-- QC 525 Indicate changes added for revision bar issue -->
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Para*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="para">
		<fo:block space-before="3pt" space-after="3pt" space-before.conditionality="discard">
			<!-- QC525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesParaRow"/>
			<xsl:apply-templates/>
			<xsl:call-template name="indicateChangesEndParaRow"/>
		</fo:block>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Text*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="text">
		<xsl:choose>
			<xsl:when test=".//location or .//eff or (.//location and .//eff)">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block space-before.conditionality="discard" space-after="3pt" space-before="3pt">
					<xsl:apply-templates/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Table*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="table">
		<xsl:variable name="cnt" select="count(tgroup)"/>
		<!-- QC525 Indicate changes added for revision bar issue -->
		<xsl:call-template name="indicateChanges"/>
		<xsl:choose>
			<xsl:when test="@tabstyle='1'">
				<fo:block page-break-before="always">
					<xsl:choose>
						<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
							<xsl:apply-imports/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="@id">
									<xsl:choose>
										<xsl:when test="string(title)">
											<fo:block font-style="italic" text-align="center" padding-bottom="2pt" font-size="10pt" keep-with-next.within-page="always">
						Table  <xsl:value-of select="count(preceding::table[@id]) + 1"/>
												<xsl:value-of select="title"/>
											</fo:block>
										</xsl:when>
										<xsl:otherwise>
						</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="title">
										<fo:block font-style="italic" text-align="center" padding-bottom="2pt" font-size="10pt" keep-with-next.within-page="always">
											<xsl:value-of select="title"/>
										</fo:block>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<!-- QC 1610 - Fix table conditioning issue - Changed this choose inside otherwise -->
								<xsl:when test="count(tgroup) = 1">
									<fo:table id="{@id}" border="1pt solid black">
										<xsl:if test="@pgwide='1'">
											<xsl:attribute name="start-indent"><xsl:value-of select="'0'"/></xsl:attribute>
										</xsl:if>
										<xsl:choose>
											<xsl:when test="@frame='bottom' or @frame='BOTTOM'">
												<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											</xsl:when>
											<xsl:when test="@frame='sides' or @frame='SIDES'">
												<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											</xsl:when>
											<xsl:when test="@frame='top' or @frame='TOP'">
												<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											</xsl:when>
											<xsl:when test="@frame='topbot' or @frame='TOPBOT'">
												<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											</xsl:when>
											<xsl:when test="@frame='none' or @frame='NONE'">
												<xsl:attribute name="border">0px</xsl:attribute>
											</xsl:when>
											<xsl:when test="@frame='all' or @frame='ALL'">
												<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											</xsl:when>
										</xsl:choose>
										<xsl:apply-templates select="thead"/>
										<xsl:apply-templates select="tgroup"/>
									</fo:table>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="count(tgroup) > 1">
										<xsl:for-each select="tgroup">
											<fo:table id="{@id}" border="1pt solid black">
												<xsl:if test="@pgwide='1'">
													<xsl:attribute name="start-indent"><xsl:value-of select="'0'"/></xsl:attribute>
												</xsl:if>
												<xsl:choose>
													<xsl:when test="@frame='bottom' or @frame='BOTTOM'">
														<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													</xsl:when>
													<xsl:when test="@frame='sides' or @frame='SIDES'">
														<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
														<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													</xsl:when>
													<xsl:when test="@frame='top' or @frame='TOP'">
														<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													</xsl:when>
													<xsl:when test="@frame='topbot' or @frame='TOPBOT'">
														<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
														<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													</xsl:when>
													<xsl:when test="@frame='none' or @frame='NONE'">
														<xsl:attribute name="border">0px</xsl:attribute>
													</xsl:when>
													<xsl:when test="@frame='all' or @frame='ALL'">
														<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
														<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
														<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
														<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													</xsl:when>
												</xsl:choose>
												<xsl:apply-templates select="colspec"/>
												<xsl:apply-templates select="thead"/>
												<xsl:apply-templates select="tbody"/>
												<xsl:apply-templates select="tfoot"/>
											</fo:table>
										</xsl:for-each>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
						<xsl:apply-imports/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="@id">
								<xsl:choose>
									<xsl:when test="string(title)">
										<fo:block font-style="italic" text-align="center" padding-bottom="2pt" font-size="10pt" keep-with-next.within-page="always">

						Table  <xsl:value-of select="count(preceding::table[@id]) + 1"/>
											<xsl:value-of select="title"/>
										</fo:block>
									</xsl:when>
									<xsl:otherwise>
						</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="title">
									<fo:block font-style="italic" text-align="center" padding-bottom="2pt" font-size="10pt" keep-with-next.within-page="always">
										<xsl:value-of select="title"/>
									</fo:block>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<!--QC 1610 - Fix table conditioning issue -  Changed this choose inside otherwise -->
						<xsl:choose>
							<xsl:when test="count(tgroup) = 1">
								<fo:table id="{@id}" border="1pt solid black">
									<xsl:if test="@pgwide='1'">
										<xsl:attribute name="start-indent"><xsl:value-of select="'0'"/></xsl:attribute>
									</xsl:if>
									<xsl:choose>
										<xsl:when test="@frame='bottom' or @frame='BOTTOM'">
											<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
										</xsl:when>
										<xsl:when test="@frame='sides' or @frame='SIDES'">
											<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
										</xsl:when>
										<xsl:when test="@frame='top' or @frame='TOP'">
											<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
										</xsl:when>
										<xsl:when test="@frame='topbot' or @frame='TOPBOT'">
											<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
										</xsl:when>
										<xsl:when test="@frame='none' or @frame='NONE'">
											<xsl:attribute name="border">0px</xsl:attribute>
										</xsl:when>
										<xsl:when test="@frame='all' or @frame='ALL'">
											<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
											<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
										</xsl:when>
									</xsl:choose>
									<xsl:apply-templates select="thead"/>
									<xsl:apply-templates select="tgroup"/>
								</fo:table>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="count(tgroup) > 1">
									<xsl:for-each select="tgroup">
										<fo:table id="{@id}" border="1pt solid black">
											<xsl:if test="@pgwide='1'">
												<xsl:attribute name="start-indent"><xsl:value-of select="'0'"/></xsl:attribute>
											</xsl:if>
											<xsl:choose>
												<xsl:when test="@frame='bottom' or @frame='BOTTOM'">
													<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												</xsl:when>
												<xsl:when test="@frame='sides' or @frame='SIDES'">
													<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												</xsl:when>
												<xsl:when test="@frame='top' or @frame='TOP'">
													<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												</xsl:when>
												<xsl:when test="@frame='topbot' or @frame='TOPBOT'">
													<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												</xsl:when>
												<xsl:when test="@frame='none' or @frame='NONE'">
													<xsl:attribute name="border">0px</xsl:attribute>
												</xsl:when>
												<xsl:when test="@frame='all' or @frame='ALL'">
													<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
													<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
												</xsl:when>
											</xsl:choose>
											<xsl:apply-templates select="colspec"/>
											<xsl:apply-templates select="thead"/>
											<xsl:apply-templates select="tbody"/>
											<xsl:apply-templates select="tfoot"/>
										</fo:table>
									</xsl:for-each>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="indicateChangesEnd"/>
	</xsl:template>
	<xsl:template match="tgroup">
		<xsl:variable name="total-colwidth">
			<xsl:value-of select="sum(colspec/@colwidth)"/>
		</xsl:variable>
		<xsl:apply-templates select="colspec"/>
		<xsl:apply-templates select="thead"/>
		<xsl:apply-templates select="tfoot"/>
		<xsl:apply-templates select="tbody"/>
	</xsl:template>
	<xsl:template match="colspec">
		<xsl:variable name="total-colwidth">
			<xsl:value-of select="sum(@colwidth)"/>
		</xsl:variable>
		<fo:table-column>
			<xsl:attribute name="column-width"><!-- Conversion for COLUMN widths --><xsl:choose><xsl:when test="contains(@colwidth,'pt')"><xsl:value-of select="substring-before(@colwidth,'pt')"/>pt</xsl:when><xsl:when test="contains(@colwidth,'mm')"><xsl:value-of select="round(number(substring-before(@colwidth,'mm'))*2.83464567)"/>pt</xsl:when><xsl:when test="contains(@colwidth,'cm')"><xsl:value-of select="round(number(substring-before(@colwidth,'cm')) *28.3464567)"/>pt</xsl:when><xsl:when test="contains(@colwidth,'px')"><xsl:value-of select="round(number(substring-before(@colwidth,'px')))"/>px</xsl:when><xsl:when test="contains(@colwidth,'in')"><xsl:value-of select="number(substring-before(@colwidth,'in'))"/>in</xsl:when><xsl:when test="contains(@colwidth,'*')">proportional-column-width(<xsl:value-of select="substring-before(@colwidth,'*')"/>)</xsl:when><xsl:when test="contains(@colwidth,'')">proportional-column-width(1)</xsl:when><xsl:otherwise/></xsl:choose></xsl:attribute>
		</fo:table-column>
	</xsl:template>
	<xsl:template match="thead">
		<fo:table-header font-family="sans-serif">
			<xsl:apply-templates select="row"/>
		</fo:table-header>
	</xsl:template>
	<xsl:template match="tfoot">
		<fo:table-footer font-family="sans-serif">
			<xsl:apply-templates select="row"/>
		</fo:table-footer>
	</xsl:template>
	<xsl:template match="tbody">
		<fo:table-body>
			<xsl:apply-templates select="row"/>
		</fo:table-body>
	</xsl:template>
	<xsl:template match="row">
		<fo:table-row keep-together.within-page="always">
			<xsl:apply-templates select="entry"/>
		</fo:table-row>
	</xsl:template>
	<xsl:template name="Cell-Push">
		<xsl:param name="TableID"/>
		<xsl:param name="Static-Position"/>
		<xsl:param name="HeadBody"/>
		<xsl:for-each select="key('FindTable',$TableID)">
			<xsl:for-each select="./tgroup/*/row/entry[position()=1][@morerows > 0]">
				<xsl:variable name="ForEach-Position">
					<xsl:choose>
						<xsl:when test="$HeadBody > 0">
							<xsl:number level="multiple" format="1" count="thead/row"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:number level="multiple" format="1" count="tbody/row"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test=" number($ForEach-Position) &lt; $Static-Position">
						<xsl:choose>
							<xsl:when test="$Static-Position > number($ForEach-Position) + number(ancestor::row/entry/@morerows)"/>
							<xsl:otherwise>
								<xsl:text>True</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="entry">
		<xsl:variable name="entry">
			<xsl:number level="multiple" format="1" count="entry"/>
		</xsl:variable>
		<xsl:variable name="row-count">
			<xsl:choose>
				<xsl:when test="number(count(ancestor::thead)) > 0">
					<xsl:value-of select="count(ancestor::thead/row)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(ancestor::tbody/row)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="row-position">
			<xsl:choose>
				<xsl:when test="number(count(ancestor::thead)) > 0">
					<xsl:number level="multiple" format="1" count="thead/row"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:number level="multiple" format="1" count="tbody/row"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="rowspan">
			<xsl:choose>
				<xsl:when test="@morerows > 0">
					<xsl:value-of select="number(@morerows) + 1"/>
				</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="@nameend">
					<xsl:value-of select=" count(ancestor::table[1]/*/colspec[@colname=current()/@nameend]/                    preceding-sibling::colspec ) -              count(ancestor::table[1]/*/colspec[@colname=current()/@namest]/                    preceding-sibling::colspec )                     + 1 "/>
				</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Cell-Pushed">
			<xsl:call-template name="Cell-Push">
				<xsl:with-param name="TableID" select="ancestor::table/@id"/>
				<xsl:with-param name="HeadBody" select="count(ancestor::thead)"/>
				<xsl:with-param name="Static-Position" select="$row-position"/>
			</xsl:call-template>
		</xsl:variable>
		<fo:table-cell number-rows-spanned="{$rowspan}" number-columns-spanned="{$colspan}" padding-before="2pt" padding-after="2pt">
			<xsl:attribute name="border-top"><xsl:choose><xsl:when test="ancestor::table/@frame='top' or ancestor::table/@frame='topbot' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:attribute name="border-bottom"><xsl:choose><xsl:when test="ancestor::table/@frame='bottom' or ancestor::table/@frame='topbot' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:attribute name="border-left"><xsl:choose><xsl:when test="ancestor::table/@frame='sides' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:attribute name="border-right"><xsl:choose><xsl:when test="ancestor::table/@frame='sides' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<!--QC 525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesParaTableRow">
				<xsl:with-param name="changeType" select="../@changeType"/>
				<xsl:with-param name="changeMark" select="../@changeMark"/>
			</xsl:call-template>
			<fo:block font-size="10pt" font-family="Helvetica,Symbol" wrap-option="wrap" start-indent="1pt" hyphenate="true" hyphenation-character="">
				<!--Added Symbol font family for the missing character issue -->
				<xsl:attribute name="text-align"><xsl:choose><xsl:when test="@align"><xsl:value-of select="@align"/></xsl:when><xsl:when test="ancestor::tgroup/colspec[number($entry)]/@align"><xsl:value-of select="ancestor::tgroup/colspec[number($entry)]/@align"/></xsl:when><xsl:when test="ancestor::tgroup/@align"><xsl:value-of select="ancestor::tgroup/@align"/></xsl:when><xsl:otherwise> left </xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:apply-templates/>
			</fo:block>
			<!--QC 525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesEndParaTableRow">
				<xsl:with-param name="changeType" select="../@changeType"/>
				<xsl:with-param name="changeMark" select="../@changeMark"/>
			</xsl:call-template>
		</fo:table-cell>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************This is for the Table displayed below graphic*************             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="table" mode="table_below_graphic">
		<!-- QC525 Indicate changes added for revision bar issue -->
		<xsl:call-template name="indicateChanges"/>
		<xsl:choose>
			<xsl:when test="@id">
				<xsl:choose>
					<xsl:when test="string(title)">
						<fo:block font-style="italic" text-align="center" padding-bottom="2pt" font-size="10pt" keep-with-next.within-page="always" padding-top="5pt">
							<xsl:attribute name="space-before"><xsl:choose><xsl:when test="preceding-sibling::*[1][self::graphic[title]]">13pt</xsl:when><xsl:otherwise>0pt</xsl:otherwise></xsl:choose></xsl:attribute>
							<fo:inline>

						Table  <xsl:value-of select="count(preceding::table[@id]) + 1"/>
								<xsl:value-of select="title"/>
							</fo:inline>
						</fo:block>
					</xsl:when>
					<xsl:otherwise>						

						 

						</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="title">
					<fo:block font-style="italic" text-align="center" padding-bottom="2pt" font-size="10pt" keep-with-next.within-page="always" padding-top="5pt">
						<xsl:attribute name="space-before"><xsl:choose><xsl:when test="preceding-sibling::*[1][self::graphic[title]]">13pt</xsl:when><xsl:otherwise>0pt</xsl:otherwise></xsl:choose></xsl:attribute>
						<xsl:value-of select="title"/>
					</fo:block>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<fo:table id="{@id}" border="1pt solid black">
			<xsl:if test="@pgwide='1'">
				<xsl:attribute name="start-indent"><xsl:value-of select="'0'"/></xsl:attribute>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@frame='bottom' or @frame='BOTTOM'">
					<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@frame='sides' or @frame='SIDES'">
					<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
					<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@frame='top' or @frame='TOP'">
					<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@frame='topbot' or @frame='TOPBOT'">
					<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
					<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="@frame='none' or @frame='NONE'">
					<xsl:attribute name="border">0px</xsl:attribute>
				</xsl:when>
				<xsl:when test="@frame='all' or @frame='ALL'">
					<xsl:attribute name="border-bottom"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
					<xsl:attribute name="border-left"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
					<xsl:attribute name="border-right"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
					<xsl:attribute name="border-top"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="border"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="thead" mode="table_below_graphic"/>
			<xsl:apply-templates select="tgroup" mode="table_below_graphic"/>
		</fo:table>
		<fo:block>
			<xsl:if test="following-sibling::*[1][self::table]">
				<xsl:apply-templates select="following-sibling::*[1][self::table]" mode="table_below_graphic"/>
			</xsl:if>
		</fo:block>
		<xsl:call-template name="indicateChangesEnd"/>
	</xsl:template>
	<xsl:template match="thead">
		<fo:table-header font-family="sans-serif">
			<xsl:apply-templates select="row" mode="table_below_graphic"/>
		</fo:table-header>
	</xsl:template>
	<xsl:template match="tgroup" mode="table_below_graphic">
		<xsl:variable name="total-percents-colwidth">
			<xsl:value-of select="sum(colspec/@colwidth)"/>
		</xsl:variable>
		<xsl:apply-templates select="colspec" mode="table_below_graphic"/>
		<xsl:apply-templates select="thead" mode="table_below_graphic"/>
		<xsl:apply-templates select="tfoot" mode="table_below_graphic"/>
		<xsl:apply-templates select="tbody" mode="table_below_graphic"/>
	</xsl:template>
	<xsl:template match="colspec" mode="table_below_graphic">
		<xsl:variable name="total-percents-colwidth">
			<xsl:value-of select="sum(@colwidth)"/>
		</xsl:variable>
		<fo:table-column>
			<xsl:attribute name="column-width"><!-- Conversion for COLUMN widths --><xsl:choose><xsl:when test="contains(@colwidth,'pt')"><xsl:value-of select="substring-before(@colwidth,'pt')"/>pt </xsl:when><xsl:when test="contains(@colwidth,'mm')"><xsl:value-of select="round(number(substring-before(@colwidth,'mm'))*2.83464567)"/>pt </xsl:when><xsl:when test="contains(@colwidth,'cm')"><xsl:value-of select="round(number(substring-before(@colwidth,'cm')) *28.3464567)"/>pt </xsl:when><xsl:when test="contains(@colwidth,'px')"><xsl:value-of select="round(number(substring-before(@colwidth,'px')))"/>px </xsl:when><xsl:when test="contains(@colwidth,'in')"><xsl:value-of select="number(substring-before(@colwidth,'in'))"/>in</xsl:when><xsl:when test="contains(@colwidth,'*')">proportional-column-width(<xsl:value-of select="substring-before(@colwidth,'*')"/>)</xsl:when><xsl:when test="contains(@colwidth,'')">proportional-column-width(1)</xsl:when><xsl:otherwise/></xsl:choose></xsl:attribute>
			<!--	<xsl:apply-templates mode="table_below_graphic"/>-->
		</fo:table-column>
	</xsl:template>
	<xsl:template match="thead" mode="table_below_graphic">
		<fo:table-header>
			<xsl:apply-templates select="row" mode="table_below_graphic"/>
		</fo:table-header>
	</xsl:template>
	<xsl:template match="tbody" mode="table_below_graphic">
		<fo:table-body>
			<xsl:apply-templates select="row" mode="table_below_graphic"/>
		</fo:table-body>
	</xsl:template>
	<xsl:template match="row" mode="table_below_graphic">
		<fo:table-row keep-together.within-page="always">
			<xsl:apply-templates select="entry" mode="table_below_graphic"/>
		</fo:table-row>
	</xsl:template>
	<!-- This function is designed to test for a previous MOREROWS pushing the current ENTRY out of position -->
	<xsl:template match="entry" mode="table_below_graphic">
		<!-- Variable - Position of the current ENTRY -->
		<xsl:variable name="entry">
			<xsl:number level="multiple" format="1" count="entry"/>
		</xsl:variable>
		<!-- Variable - THEAD and TBODY ROW count -->
		<xsl:variable name="row-count">
			<xsl:choose>
				<xsl:when test="number(count(ancestor::thead)) > 0">
					<xsl:value-of select="count(ancestor::thead/row)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="count(ancestor::tbody/row)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Variable - Position of current ROW -->
		<xsl:variable name="row-position">
			<xsl:choose>
				<xsl:when test="number(count(ancestor::thead)) > 0">
					<xsl:number level="multiple" format="1" count="thead/row"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:number level="multiple" format="1" count="tbody/row"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Variable - Boolean True/False - Is a previous MOREROW pushing this ENTRY out of position -->
		<xsl:variable name="rowspan">
			<xsl:choose>
				<xsl:when test="@morerows > 0">
					<xsl:value-of select="number(@morerows) + 1"/>
				</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- This variable returns a start position number 

		<xsl:variable name="Start-Position">

			<xsl:for-each select="key('ColSpec', @namest)">

				<xsl:value-of select="count(preceding::colspec)"/>

			</xsl:for-each>

		</xsl:variable>-->
		<!-- This variable returns a end position number 

		<xsl:variable name="End-Position">

			<xsl:for-each select="key('ColSpec', @nameend)">

				<xsl:value-of select="count(preceding::colspec)"/>

			</xsl:for-each>

		</xsl:variable>-->
		<!-- If there is an attribute called NAMEEND -->
		<xsl:variable name="colspan">
			<xsl:choose>
				<xsl:when test="@nameend">
					<xsl:value-of select=" count(ancestor::table[1]/*/colspec[@colname=current()/@nameend]/                    preceding-sibling::colspec ) - count(ancestor::table[1]/*/colspec[@colname=current()/@namest]/preceding-sibling::colspec )                     + 1"/>
				</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:table-cell number-rows-spanned="{$rowspan}" number-columns-spanned="{$colspan}" padding-before="2pt" padding-after="2pt">
			<xsl:attribute name="border-top"><xsl:choose><xsl:when test="ancestor::table/@frame='top' or ancestor::table/@frame='topbot' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:attribute name="border-bottom"><xsl:choose><xsl:when test="ancestor::table/@frame='bottom' or ancestor::table/@frame='topbot' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:attribute name="border-left"><xsl:choose><xsl:when test="ancestor::table/@frame='sides' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<xsl:attribute name="border-right"><xsl:choose><xsl:when test="ancestor::table/@frame='sides' or ancestor::table/@frame='all'"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when><xsl:when test="ancestor::table/@frame='none'"><xsl:value-of select="$NoFrameWidth"/></xsl:when><xsl:otherwise><xsl:choose><xsl:when test="not(string(ancestor::table/@frame))"><xsl:value-of select="$FrameWidth"/> solid

							<xsl:value-of select="$FrameColour"/></xsl:when></xsl:choose></xsl:otherwise></xsl:choose></xsl:attribute>
			<!--QC 525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesParaTableRow">
				<xsl:with-param name="changeType" select="../@changeType"/>
				<xsl:with-param name="changeMark" select="../@changeMark"/>
			</xsl:call-template>
			<fo:block font-size="10pt" font-family="Helvetica,Symbol" wrap-option="wrap" start-indent="1pt" hyphenate="true" hyphenation-character="">
				<xsl:attribute name="text-align"><xsl:choose><xsl:when test="@align"><xsl:value-of select="@align"/></xsl:when><xsl:when test="ancestor::tgroup/colspec[number($entry)]/@align"><xsl:value-of select="ancestor::tgroup/colspec[number($entry)]/@align"/></xsl:when><xsl:when test="ancestor::tgroup/@align"><xsl:value-of select="ancestor::tgroup/@align"/></xsl:when><xsl:otherwise> left </xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:apply-templates/>
			</fo:block>
			<!--QC 525 Indicate changes added for revision bar issue -->
			<xsl:call-template name="indicateChangesEndParaTableRow">
				<xsl:with-param name="changeType" select="../@changeType"/>
				<xsl:with-param name="changeMark" select="../@changeMark"/>
			</xsl:call-template>
		</fo:table-cell>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--         *************Sign*************             -->
	<!-- Define signature Block, will generate # of Signaure Block debending on signature blocks in  xml file-->
	<!-- _________________________________________________________________________-->
	<!--<xsl:template match="sign" mode="deltasignoff">
	
				<xsl:choose>
					<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
						<xsl:apply-imports/>
					</xsl:when>
					<xsl:otherwise>
						<fo:block start-indent="0pt" space-before="6pt" keep-with-previous.within-page="always">
							<fo:table table-layout="fixed" keep-together.within-page="always">
								<xsl:choose>
									<xsl:when test="count(block) = 2">
										<fo:table-column column-width="140mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 3">
										<fo:table-column column-width="115mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 4">
										<fo:table-column column-width="90mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 5">
										<fo:table-column column-width="65mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 6">
										<fo:table-column column-width="40mm"/>
									</xsl:when>
									<xsl:otherwise>
										<fo:table-column column-width="165mm"/>
									</xsl:otherwise>
								</xsl:choose>
								<fo:table-column column-width="25mm"/>
								<fo:table-column column-width="25mm"/>
								<fo:table-column column-width="25mm"/>
								<fo:table-column column-width="25mm"/>
								<fo:table-column column-width="25mm"/>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell display-align="after">
											<fo:block>
												<fo:leader keep-with-next.within-page="always" leader-pattern="rule" rule-style="dashed" rule-thickness=".5pt" leader-length="100%"/>
											</fo:block>
										</fo:table-cell>
										<xsl:apply-templates select="block" mode="deltasignoff"/>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</xsl:otherwise>
				</xsl:choose>
		
	</xsl:template>
	<xsl:template match="block" mode="deltasignoff">
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-cell padding-start="3pt">
					<fo:block text-align="right" border="1pt">
						<fo:table>
							<fo:table-column column-width="24mm"/>
							<fo:table-body>
								<xsl:if test="sign-label">
									<fo:table-row height="3mm">
										<fo:table-cell text-align="center" border=".5pt" border-style="solid" border-color="black">
											<fo:block>
												<fo:inline font-size="8pt">
													<xsl:value-of select="sign-label"/>
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
								<fo:table-row>
									<fo:table-cell padding-after="1pt">
										<fo:block/>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block>
						<xsl:choose>
							<xsl:when test="sign-skill='Inspector' or sign-skill='ETOPS Mech' or sign-skill='RII' or sign-skill='NDT' or sign-skill='Lead Inspector' or sign-skill='OK to Close' or sign-skill='OK to Install' or sign-skill='OK'">
								<fo:table>
									<fo:table-column column-width="24mm"/>
									<fo:table-body>
										<fo:table-row height="3mm">
											<fo:table-cell text-align="center" border="2pt" border-style="solid" border-color="black">
												<fo:block>
													<xsl:value-of select="sign-skill"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="7mm">
											<fo:table-cell text-align="center" border="2pt" border-style="solid" border-color="black">
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</xsl:when>
							<xsl:otherwise>
								<fo:table>
									<fo:table-column column-width="24mm"/>
									<fo:table-body>
										<fo:table-row height="3mm">
											<fo:table-cell text-align="center" border=".5pt" border-style="solid" border-color="black">
												<fo:block>
													<xsl:value-of select="sign-skill"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="7mm">
											<fo:table-cell text-align="center" border=".5pt" border-style="solid" border-color="black">
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:table-cell>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>-->
	<xsl:template match="sign">
		<xsl:choose>
			<xsl:when test="((/workcard/prelreq/wctype='W' or /workcard/prelreq/wctype='P') and ($hflag='hf08'))"/>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
						<xsl:apply-imports/>
					</xsl:when>
					<xsl:otherwise>
						<!-- QC525 Indicate changes added for revision bar issue -->
						<xsl:call-template name="indicateChanges"/>
						<fo:block start-indent="0pt" space-before="6pt" keep-with-previous.within-page="always">
							<fo:table table-layout="fixed" keep-together.within-page="always">
								<xsl:choose>
									<xsl:when test="count(block) = 2">
										<fo:table-column column-width="140mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 3">
										<fo:table-column column-width="105mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 4">
										<fo:table-column column-width="70mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 5">
										<fo:table-column column-width="40mm"/>
									</xsl:when>
									<xsl:when test="count(block) = 6">
										<fo:table-column column-width="10mm"/>
									</xsl:when>
									<xsl:otherwise>
										<fo:table-column column-width="165mm"/>
									</xsl:otherwise>
								</xsl:choose>
								<fo:table-column column-width="31mm"/>
								<fo:table-column column-width="31mm"/>
								<fo:table-column column-width="31mm"/>
								<fo:table-column column-width="31mm"/>
								<fo:table-column column-width="31mm"/>
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell display-align="after">
											<fo:block>
												<fo:leader keep-with-next.within-page="always" leader-pattern="rule" rule-style="dashed" rule-thickness=".5pt" leader-length="100%"/>
											</fo:block>
										</fo:table-cell>
										<xsl:apply-templates select="block"/>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
						<xsl:call-template name="indicateChangesEnd"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="block">
		<xsl:choose>
			<xsl:when test="text/location or ./location or text/eff or ./eff or ((text/location or ./location) and (text/eff or ./eff))">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:table-cell padding-start="3pt">
					<fo:block text-align="right" border="1pt">
						<fo:table>
							<fo:table-column column-width="30mm"/>
							<fo:table-body>
								<xsl:if test="sign-label">
									<fo:table-row height="3.175mm">
										<fo:table-cell text-align="center" border=".5pt" border-style="solid" border-color="black">
											<fo:block>
												<fo:inline font-size="8pt">
													<xsl:value-of select="sign-label"/>
												</fo:inline>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
								<fo:table-row>
									<fo:table-cell padding-after="1pt">
										<fo:block/>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
					<fo:block>
						<xsl:choose>
							<xsl:when test="sign-skill='Inspector' or sign-skill='ETOPS Mech' or sign-skill='RII' or sign-skill='NDT' or sign-skill='Lead Inspector' or sign-skill='OK to Close' or sign-skill='OK to Install' or sign-skill='OK' or sign-skill='Preflight'">
								<fo:table>
									<fo:table-column column-width="30mm"/>
									<fo:table-body>
										<fo:table-row height="3.175mm">
											<fo:table-cell text-align="center" border="2pt" border-style="solid" border-color="black">
												<fo:block>
													<xsl:value-of select="sign-skill"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="14mm">
											<fo:table-cell text-align="center" border="2pt" border-style="solid" border-color="black">
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</xsl:when>
							<xsl:otherwise>
								<fo:table>
									<fo:table-column column-width="30mm"/>
									<fo:table-body>
										<fo:table-row height="3.175mm">
											<fo:table-cell text-align="center" border=".5pt" border-style="solid" border-color="black">
												<fo:block>
													<xsl:value-of select="sign-skill"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="14mm">
											<fo:table-cell text-align="center" border=".5pt" border-style="solid" border-color="black">
												<fo:block> </fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</xsl:otherwise>
						</xsl:choose>
					</fo:block>
				</fo:table-cell>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--          Random List             -->
	<!--_________________________________________________________________________-->
	<xsl:template match="randlist/title">
		<fo:block font-weight="bold">
			<xsl:copy-of select="node()"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="randlist/item">
		<fo:list-block>
			<fo:list-item padding-top="1pt">
				<fo:list-item-label end-indent="label-end()">
					<fo:block>
						<xsl:call-template name="listsign">
							<xsl:with-param name="format">
								<xsl:value-of select="../@prefix"/>
							</xsl:with-param>
						</xsl:call-template>
					</fo:block>
				</fo:list-item-label>
				<fo:list-item-body start-indent="body-start()" end-indent="0pt">
					<fo:block>
						<xsl:apply-templates/>
					</fo:block>
				</fo:list-item-body>
			</fo:list-item>
		</fo:list-block>
	</xsl:template>
	<xsl:template name="listsign">
		<xsl:param name="format"/>
		<xsl:choose>
			<xsl:when test="$format='pf01'"> </xsl:when>
			<xsl:when test="$format='pf02'">
				<xsl:variable name="lev" select="count(ancestor::randlist)"/>
				<xsl:choose>
					<xsl:when test="$lev=1 or $lev=3">?</xsl:when>
					<xsl:otherwise>•</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$format='pf03'">•</xsl:when>
			<!-- &#x2010; should be there -->
			<xsl:when test="$format='pf04'">?</xsl:when>
			<xsl:when test="$format='pf05'">?</xsl:when>
			<xsl:when test="$format='pf06'">?</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--        Revision Bar Templates         -->
	<!--_________________________________________________________________________-->
	<xsl:template name="indicateChanges">
		<xsl:choose>
			<xsl:when test="(@changeType='modify' or 'add') and @changeMark = '1' ">
				<fo:change-bar-begin change-bar-class="1" change-bar-style="solid" change-bar-color="black" change-bar-width="2pt" change-bar-offset="7mm" change-bar-placement="start"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<!-- template for revision bar changes -->
	<xsl:template name="indicateChangesEnd">
		<xsl:if test="@changeType and @changeMark = '1'">
			<fo:change-bar-end change-bar-class="1"/>
		</xsl:if>
	</xsl:template>
	<!-- template for Para revision bar changes -->
	<xsl:template name="indicateChangesParaRow">
		<xsl:choose>
			<xsl:when test="(@changeType='modify' or 'add') and @changeMark = '1' ">
				<fo:change-bar-begin change-bar-class="1" change-bar-style="solid" change-bar-color="black" change-bar-width="2pt" change-bar-offset="1mm" change-bar-placement="start"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<!-- template for para revision bar changes -->
	<xsl:template name="indicateChangesEndParaRow">
		<xsl:if test="@changeType and @changeMark = '1'">
			<fo:change-bar-end change-bar-class="1"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="indicateChangesParaTableRow">
		<xsl:param name="changeType"/>
		<xsl:param name="changeMark"/>
		<xsl:choose>
			<xsl:when test="($changeType='modify' or 'add') and $changeMark = '1' ">
				<fo:change-bar-begin change-bar-class="1" change-bar-style="solid" change-bar-color="black" change-bar-width="2pt" change-bar-offset="1mm" change-bar-placement="start"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<!-- template for para revision bar changes -->
	<xsl:template name="indicateChangesEndParaTableRow">
		<xsl:param name="changeType"/>
		<xsl:param name="changeMark"/>
		<xsl:if test="$changeType and $changeMark = '1'">
			<fo:change-bar-end change-bar-class="1"/>
		</xsl:if>
	</xsl:template>
	<!--_________________________________________________________________________-->
	<!--        Reftp - Links to training videos         -->
	<!--_________________________________________________________________________-->
	<xsl:template match="reftp">
		<!-- TBD reftp template override for EED LMOS URLs<xsl:variable name="lmosd">
			<xsl:if test="contains($docato.server, 'cmsd')">
				<xsl:value-of select="'http://lpad.delta.com/LPA/oilEntry'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="lmosi">
			<xsl:if test="contains($docato.server, 'cmsi')">
				<xsl:value-of select="'http://lpai.delta.com/LPA/oilEntry'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="lmosp">
			<xsl:if test="contains($docato.server, 'cms')">
				<xsl:value-of select="'http://lpa.delta.com/LPA/oilEntry'"/>
			</xsl:if>
		</xsl:variable>
		<fo:block>
			<fo:inline text-decoration="underline">
				<xsl:choose>
					<xsl:when test="pubcode/@pubcodsy='LMOS'">
						<xsl:choose>
							<xsl:when test="contains($docato.server, 'cmsd')">
							Click here for LMOS - <xsl:value-of select="concat($lmosd,'?acnum=',$tail,'&amp;station=&amp;date=00&amp;time=0000&amp;userid=&amp;syscode=EMX&amp;rploggedin=false')"/>
							</xsl:when>
							<xsl:when test="contains($docato.server, 'cmsi')">
							Click here for LMOS - <xsl:value-of select="concat($lmosi,'?acnum=',$tail,'&amp;station=&amp;date=00&amp;time=0000&amp;userid=&amp;syscode=EMX&amp;rploggedin=false')"/>
							</xsl:when>
							<xsl:when test="contains($docato.server, 'cms')">
							Click here for LMOS - <xsl:value-of select="concat($lmosp,'?acnum=',$tail,'&amp;station=&amp;date=00&amp;time=0000&amp;userid=&amp;syscode=EMX&amp;rploggedin=false')"/>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</fo:inline>
		</fo:block>-->
		<fo:inline font-weight="bold" text-decoration="underline">
			<xsl:choose>
				<xsl:when test="@xlink:title">
					<xsl:value-of select="@xlink:title"/>
				</xsl:when>
				<!--<xsl:when test="pubtitle">
					<xsl:value-of select="concat('refTP(PubCode=',pubcode,', Pubcodsy=',pubcode/@pubcodsy,', Pubtitle=',pubtitle,')')"/>
				</xsl:when>-->
			</xsl:choose>
		</fo:inline>
		<xsl:choose>
			<xsl:when test="child::xlink:locator or xlink:resource or xlink:arc">
				<xsl:apply-templates/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="xlink:resource | xlink:locator | xlink:arc">
		<xsl:variable name="link">
			<xsl:value-of select="@xlink:href"/>
		</xsl:variable>
		<fo:inline>
			<xsl:call-template name="indicateChanges"/>
			<xsl:text> </xsl:text>
			<fo:inline color="blue" text-decoration="underline">
				<!--	<fo:basic-link external-destination="{$link}" color="blue" text-decoration="underline">Click Here</fo:basic-link>-->
				<!--<xsl:value-of select="@label"/>-->
				<xsl:value-of select="$link"/>
			</fo:inline>
			<!--	<fo:inline color="black">
		<xsl:text> [</xsl:text>
				<xsl:for-each select="@*">
					<fo:inline font-weight="bold">
						<xsl:value-of select="concat(local-name(.), ': ')"/>
					</fo:inline>
					<xsl:value-of select="."/>
					<xsl:if test="not(position() = last())">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			<xsl:text>]</xsl:text>
			</fo:inline>-->
			<xsl:text> </xsl:text>
			<xsl:call-template name="indicateChangesEnd"/>
		</fo:inline>
	</xsl:template>
</xsl:stylesheet>