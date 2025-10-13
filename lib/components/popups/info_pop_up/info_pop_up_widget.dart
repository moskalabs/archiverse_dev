import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'info_pop_up_model.dart';
export 'info_pop_up_model.dart';

class InfoPopUpWidget extends StatefulWidget {
  const InfoPopUpWidget({
    super.key,
    required this.title,
  });

  /// 제목
  final String? title;

  @override
  State<InfoPopUpWidget> createState() => _InfoPopUpWidgetState();
}

class _InfoPopUpWidgetState extends State<InfoPopUpWidget> {
  late InfoPopUpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InfoPopUpModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: () {
        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
          return 450.0;
        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
          return 500.0;
        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
          return 700.0;
        } else {
          return 800.0;
        }
      }(),
      height: () {
        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
          return 700.0;
        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
          return 800.0;
        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
          return 900.0;
        } else {
          return 1000.0;
        }
      }(),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 16.0,
            color: Color(0x1B080B1F),
            offset: Offset(
              0.0,
              6.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return 5.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return 10.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return 12.0;
                } else {
                  return 15.0;
                }
              }(),
              0.0,
            ),
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return 5.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return 10.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return 12.0;
                } else {
                  return 15.0;
                }
              }(),
              0.0,
            ),
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return 5.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return 10.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return 12.0;
                } else {
                  return 15.0;
                }
              }(),
              0.0,
            ),
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return 5.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return 10.0;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return 12.0;
                } else {
                  return 15.0;
                }
              }(),
              0.0,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.title,
                            '이용약관 안내',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 16.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 16.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 18.0;
                                  } else {
                                    return 22.0;
                                  }
                                }(),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2.0,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    Expanded(
                      flex: 50,
                      child: FlutterFlowWebView(
                        content: widget.title == '개인정보처리방침'
                            ? '<div id=\"contents\">  <style type=\"text/css\">    /* 기본 스타일 */    body {      font-family: \"돋움\", sans-serif;      font-size: 10pt; /* 기존 크기로 복원 */      color: #272727;      line-height: 1.6;    }    /* 제목 스타일 */    h1 {      font-size: 12pt; /* 기존 대비 축소 */      font-weight: 700;      margin: 20pt 0 10pt;      text-align: justify;    }    h2 {      font-size: 11pt; /* 기존 대비 축소 */      font-weight: 700;      margin: 15pt 0 8pt;      text-align: justify;    }    /* 본문 스타일 */    p {      margin: 8pt 0;      text-align: justify;    }    /* 목록 스타일 */    ol, ul {      margin: 8pt 0;      padding: 0;    }    ol {      list-style-position: inside;    }    ul {      list-style-type: none;    }    li {      margin: 6pt 0;      margin-left: 20pt;      text-indent: 0pt;    }    ul li:before {      content: \"• \";      margin-left: -14pt;      white-space: nowrap;      display: inline-block;      min-width: 14pt;    }    /* 테이블 스타일 */    table {      border-spacing: 0;      border-collapse: collapse;      margin: 15pt auto;    }    td {      padding: 5pt;      border: 1pt solid #000000;      text-align: left;      vertical-align: middle;    }    td.c6 { width: 137.2pt; }    td.c13 { width: 119.3pt; }    td.c4 { width: 139.8pt; }    td.c11 { width: 153.7pt; }    /* 문서 컨테이너 */    .doc-content {      background-color: #ffffff;      max-width: 500pt;      padding: 20pt;    }    /* 강조 텍스트 */    .highlight {      color: #d32f2f;    }  </style>  <div class=\"doc-content\">    <h1>개인정보 처리방침</h1>    <h2>1. 개인정보의 취급 및 목적</h2>    <p>① <span class=\"highlight\">메타로지 주식회사</span>는 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.</p>    <p>- <span class=\"highlight\">건축학인증 플랫폼 “archiverse”</span>의 고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별, 인증, 회원자격 유지, 관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급, 배송 등</p>    <p>② 협력사와의 협약을 통한 데이터의 수집, 보유, 이용, 삭제에 대한 처리는 아래 \"메타로지 주식회사\" 회원약관의 정책을 준수하여 처리합니다.</p>    <h2>2. 개인정보의 처리 및 보유 기간</h2>    <p>① 메타로지 주식회사는 정보주체로부터 개인정보를 수집할 때 동의 받은 개인정보 보유, 이용기간 또는 법령에 따른 개인정보 보유, 이용기간 내에서 개인정보를 취급, 보유합니다.</p>    <p>② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다.</p>    <table>      <tbody>        <tr>          <td class=\"c6\"><p>수집 및 이용 목적</p></td>          <td class=\"c13\"><p>필수/선택 항목 여부</p></td>          <td class=\"c11\"><p>수집 및 이용항목</p></td>        </tr>        <tr>          <td class=\"c6\"><p>서비스 운영</p></td>          <td class=\"c13\"><p>필수</p></td>          <td class=\"c11\">            <p>이름, 학번, 닉네임,</p>            <p>(외부 계정을 연동한 경우)플랫폼ID,</p>            <p>핸드폰번호,</p>            <p>이메일 주소, 등</p>          </td>        </tr>        <tr>          <td class=\"c6\"><p>고객 맞춤형 지원 서비스</p></td>          <td class=\"c13\"><p>선택</p></td>          <td class=\"c11\">            <p>프로필 이미지</p>            <p>나이대</p>          </td>        </tr>        <tr>          <td class=\"c6\"><p>이벤트 등 프로모션 제공</p></td>          <td class=\"c13\"><p>선택</p></td>          <td class=\"c11\"><p>이메일 주소, (필요 시) 학사업무 또는 경품 지급을 위하여 필요한 정보</p></td>        </tr>      </tbody>    </table>    <p>메타로지 주식회사는 서비스 제공 과정에서 서비스 이용 기록(방문 일시(접속기록), IP주소, 부정 이용 기록(제제 정보), 결제 기록) 및 디바이스 정보(OS 정보, 기종 및 모델명, 사용 언어, 광고 식별자 등), 채팅 기록(메시지 수·발신 내역 및 디바이스 정보), 쿠키가 생성, 수집될 수 있습니다.</p>    <p>고객지원 서비스 제공 과정에서 디바이스 정보(OS정보, 기종 및 모델명, 국가코드 및 사용 언어, 배터리 상황, 네트워크 종류, 통신사)가 생성, 수집될 수 있습니다.</p>    <h2>2. 개인정보의 처리목적</h2>    <p>회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 등 관계 법령에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</p>    <p>이용자의 메타로지 주식회사가 제공하는 서비스 이용 과정에서 생성된 데이터(건축학인증 플랫폼에 업로드 한 자료 등)를 포함한 비개인정보는 서비스 이용환경 분석 및 서비스 개선, 이용 경험 향상 등을 목적으로 이용될 수 있습니다.</p>    <h2>3. 개인정보의 제3자 제공</h2>    <p>회사는 개인정보를 \"2. 개인정보의 처리목적\"에서 고지한 범위 내에서 사용하며, 원칙적으로 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 개인정보를 외부에 공개하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.</p>    <ol>      <li>관련 법령에 따라 개인정보 제공의 의무가 있는 경우</li>      <li>이용자로부터 별도의 동의를 받은 경우</li>    </ol>    <h2>4. 개인정보의 보유 기간</h2>    <p>이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 또는 분리보관 합니다. 단, 다음의 사유에 한하여 일정기간 동안 해당 정보를 다른 정보와 분리하여 저장, 관리하며 아래에 명시된 기간 이후에 지체 없이 파기 또는 분리보관 합니다。</p>    <h3>1) 불만 및 분쟁 해결</h3>    <p>회원탈퇴를 요청하는 경우, 탈퇴 철회 지원과 이용자 불만 및 분쟁해결을 목적으로 게임서비스 운영 등을 위하여 수집한 개인정보는 요청일자로부터 7일간 보관 후 파기 또는 분리보관 합니다。</p>    <h3>2) 부정 가입 및 이용 방지</h3>    <p>메타로지 주식회사는 서비스 이용 중 발생한 부정 이용 기록은 부정 가입 및 이용 방지를 목적으로 발생일자로부터 1년간 보관 후 파기 또는 분리보관 합니다。</p>    <h3>3) 이벤트 개최 등 부가 서비스 제공</h3>    <p>이벤트 개최 등을 위하여 수집한 개인정보는 이벤트의 종류 등에 따라 보관 기간이 상이할 수 있어 각 이벤트 페이지에 기재된 보관 기간에 따르며, 수집 이용 목적 달성 시 파기 또는 분리보관 합니다。</p>    <p>이 외에 관계법령의 규정에 의하여 수집 및 이용목적 달성 후에도 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 이용자의 정보를 보관합니다。</p>    <table>      <tbody>        <tr>          <td class=\"c4\"><p>구분</p></td>          <td class=\"c4\"><p>보존 근거</p></td>          <td class=\"c4\"><p>보존 기간</p></td>        </tr>        <tr>          <td class=\"c4\"><p>컴퓨터 통신, 인터넷 로그 기록자료, 접속지 추적자료</p></td>          <td class=\"c4\"><p>통신비밀보호법</p></td>          <td class=\"c4\"><p>3개월</p></td>        </tr>        <tr>          <td class=\"c4\"><p>표시, 광고에 관한 기록</p></td>          <td class=\"c4\" rowspan=\"2\"><p>전자상거래 등에서의 소비자 보호에 관한 법률</p></td>          <td class=\"c4\"><p>6개월</p></td>        </tr>        <tr>          <td class=\"c4\"><p>소비자의 불만 또는 분쟁처리에 관한 기록</p></td>          <td class=\"c4\"><p>3년</p></td>        </tr>        <tr>          <td class=\"c4\"><p>세법이 규정하는 처리에 관한 기록</p></td>          <td class=\"c4\"><p>국세기본법, 소득세법</p></td>          <td class=\"c4\"><p>5년</p></td>        </tr>        <tr>          <td class=\"c4\"><p>전자금융 거래에 관한 기록</p></td>          <td class=\"c4\"><p>전자금융거래법</p></td>          <td class=\"c4\"><p>5년</p></td>        </tr>      </tbody>    </table>    <h2>5. 개인정보 파기절차 및 방법</h2>    <p>회사는 원칙적으로 ‘4. 개인정보의 보유 기간’에 명시된 보유 기간이 경과되는 경우 지체없이 개인정보를 파기 또는 분리보관 합니다. 파기 시, 물리적 형태로 저장된 개인정보는 파쇄하거나 소각하며, 전자적 파일 형태로 저장된 개인정보는 기록을 저장할 수 없는 기술적 방법을 사용하여 삭제합니다。</p>    <h2>6. 이용자 및 법정대리인의 권리와 그 행사방법</h2>    <ol>      <li>관련 법령에서 정하는 바에 따라, 이용자는 개인정보 처리를 거부, 제한하거나 개인정보를 열람, 수정, 삭제, 이전할 권리를 보유합니다. 개인정보 관련 업무에 대해 궁금하신 점이 있으실 경우 개인정보보호 담당자에게 이메일로 연락하시기 바라며, 담당자는 합리적인 방법을 통해 본인 여부를 확인할 것입니다. 회사는 개인정보 보호 관련 법령에 따라 이용자의 권리 행사에 성실히 응할 것입니다。</li>      <li>본 조 1)의 이용자의 각 권리는 이용자의 법정 대리인을 통하여 행사 하실 수 있습니다. 이 경우, 법정 대리인은 이용자의 모든 권리를 가집니다。</li>      <li>이용자의 법정대리인이 개인정보의 열람, 정정/삭제, 처리정지를 요구하는 경우, 회사는 정당한 대리권 여부를 확인하기 위하여 위임장 등의 필요한 추가적인 증빙을 요구할 수 있습니다。</li>      <li>회사는 이용자 및 법정대리인의 열람 요구에 대하여 10일 이내에 해당 개인정보를 열람할 수 있도록 합니다. 단, 해당 기간 내에 열람이 불가능한 정당한 사유가 있는 경우 이를 알리고 기한을 연기할 수 있으며, 그 사유가 소멸하면 지체없이 개인정보의 열람 등을 제공합니다。</li>      <li>회사는 이용자 및 법정대리인의 정정·삭제 요구에 대하여 다른 법령에서 요구하는 절차 등이 있는 경우를 제외하고 해당 개인정보에 대하여 10일 이내에 정정·삭제 등의 조치 후 그 결과를 알려드립니다. 단, 다른 법령에서 해당 개인정보가 수집 대상으로 명시되어 있는 경우와 같이 삭제가 불가능한 경우 이용자 및 법정대리인에게 통지합니다。</li>      <li>회사는 이용자 및 법정대리인의 처리정지 요구에 대하여 법률에 특별한 규정이 있거나 법적 준수 의무가 있는 경우를 제외하고 해당 개인정보에 대하여 지체없이 처리정지 등의 조치 후 그 결과를 알려드립니다。</li>    </ol>    <h2>8. 개인정보의 기술적/관리적 보호 대책</h2>    <p>회사는 이용자의 개인정보가 분실, 도난, 누출유출, 변조 또는 훼손되지 않도록 다음과 같은 최선의 관리적, 기술적, 물리적 보호대책을 마련, 이행하고 있습니다. 그러나 모든 정보의 완전한 보호를 보증하기에는 어려움이 있습니다. 이용자가 회사에 개인정보를 제공한다는 것은 이러한 어려움에 대하여 인지하였으며, 이에 동의하는 것을 의미합니다。</p>    <h3>1) 관리적 보호대책</h3>    <p>내부 관리계획의 수립·시행, 정기적 직원 교육, 수탁업체에 대한 보안 준수여부 감독 등</p>    <h3>2) 기술적 보호대책</h3>    <p>개인정보처리시스템에 대한 접근권한 관리, 접근통제 시스템 설치·운영, 개인정보의 암호화, 보안 프로그램의 설치·운영 등</p>    <h3>3) 물리적 보호대책</h3>    <p>전산실, 자료보관실 등의 접근통제 등</p>    <h3>4) 개인정보처리방침 이행 및 준수</h3>    <p>회사는 개인정보처리방침 이행사항 및 담당자의 준수여부를 확인하여 문제가 발견될 경우 즉시 수정하고 바로 잡을 수 있도록 노력하고 있습니다。</p>    <p>단, 이용자 본인의 부주의나 인터넷상의 문제로 비밀번호 등 개인정보가 유출되어 발생한 문제에 대해 회사는 일체의 책임을 지지 않습니다。</p>    <h2>9. 개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항</h2>    <p>회사는 이용자들에게 맞춤형 서비스 제공 및 서비스 이용 형태 분석 등을 목적으로 개인정보를 자동 수집하고 이용할 수 있습니다。</p>    <h2>10. 개인정보 보호책임자의 연락처</h2>    <p>회사는 개인정보에 대한 의견 및 요청을 담당하는 개인정보 보호책임자를 지정하고 있습니다。</p>    <h3>개인정보 보호책임자</h3>    <p>이름: 김정훈 팀장</p>    <p>메일: info@metalogy.co.kr</p>    <p>기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다。</p>    <ul>      <li>개인정보침해신고센터 (privacy.kisa.or.kr / (국번없이) 118)</li>      <li>개인정보 분쟁조정위원회 (www.kopico.go.kr / (국번없이) 1833-6972)</li>      <li>대검찰청 사이버수사과 (www.spo.go.kr / (국번없이) 1301)</li>      <li>경찰청 사이버안전국 (ecrm.cyber.go.kr / (국번없이) 182)</li>    </ul>    <h2>부칙</h2>    <p>본 개인정보 처리방침은 2025년 4월 10일부터 시행합니다。</p>  </div></div>'
                            : '<div id=\"contents\">  <style type=\"text/css\">    /* 기본 스타일 */    body {      font-family: \"돋움\", sans-serif;      font-size: 10pt; /* 기존 크기로 조정 */      color: #272727;      line-height: 1.6;    }    /* 제목 스타일 */    h1 {      font-size: 12pt; /* 기존 대비 축소 */      font-weight: 700;      margin: 20pt 0 10pt;      text-align: justify;    }    h2 {      font-size: 11pt; /* 기존 대비 축소 */      font-weight: 700;      margin: 15pt 0 8pt;      text-align: justify;    }    h3 {      font-size: 10pt;      font-weight: 700;      margin: 10pt 0 5pt;      text-align: justify;    }    /* 본문 스타일 */    p {      margin: 8pt 0;      text-align: justify;    }    /* 목록 스타일 */    ol, ul {      margin: 8pt 0;      padding: 0;    }    ol {      list-style-position: inside;    }    ul {      list-style-type: none;    }    li {      margin: 4pt 0;      margin-left: 20pt;      text-indent: 0pt;    }    ul li:before {      content: \"• \";      margin-left: -14pt;      white-space: nowrap;      display: inline-block;      min-width: 14pt;    }    /* 문서 컨테이너 */    .doc-content {      background-color: #ffffff;      max-width: 500pt;      padding: 20pt;    }    /* 강조 텍스트 */    .highlight {      color: #d32f2f; /* 부드러운 빨간색 */    }    /* 들여쓰기 조정 */    .indent {      margin-left: 30pt;    }  </style>  <div class=\"doc-content\">    <h1>건축학인증 플랫폼 이용 약관</h1>    <h2>제1장 총칙</h2>    <h3>제1조 [목적]</h3>    <p>이 약관은 <span class=\"highlight\">건축학인증 플랫폼</span>에서 제공하는 서비스를 이용함에 있어서 서비스 제공자와 이용자 간의 권리, 의무 및 책임 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</p>    <h2>제2장 서비스 이용계약</h2>    <h3>제2조 [용어의 정의]</h3>    <ol start=\"1\">      <li>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</li>    </ol>    <p>① “플랫폼”이란 데이터, UI, API 등을 제공하기 위하여, 데이터를 수집, 처리, 저장, 분석 및 시각화 등을 통하여 가입 회원들에게 제반 혜택을 제공하는 <span class=\"highlight\">건축학인증 플랫폼</span> 시스템을 말하며, 아울러 <span class=\"highlight\">건축학인증 플랫폼</span>을 운영하는 사업자의 의미로도 사용합니다.</p>    <p>② “서비스”란 “회원”들이 이용할 수 있는 <span class=\"highlight\">건축학인증 플랫폼</span> 관련 제반 서비스를 말합니다。</p>    <p>③ “회원”이라 함은 “플랫폼”에 회원등록을 한 자로서, 계속적으로 “플랫폼”이 제공하는 “서비스”를 이용할 수 있는 자를 말합니다。</p>    <p><span class=\"highlight\">④ “센터”란 데이터상품, 서비스 상품 등을 제공하는 자로 “계약센터”와 “참여센터”로 구분합니다。</span></p>    <p>제1항에서 정의되지 않은 용어의 의미는 관련 법령 및 일반적인 거래 관행을 따릅니다。</p>    <h3>제3조 [약관의 효력과 변경]</h3>    <ol start=\"1\">      <li>이 약관은 “서비스”를 이용하고자 하는 모든 이용자에 대하여 그 효력을 발생합니다。</li>      <li>이 약관의 내용은 “서비스”의 일부 화면 또는 기타 방법 등에 의하여 이를 공지하거나 그 내용을 이용자에게 통지함으로써 효력이 발생됩니다。</li>      <li>“플랫폼”은 필요하다고 인정되는 경우 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제2항과 같은 방법으로 공지 또는 통지하여 이용자가 직접 확인할 수 있도록 할 것입니다。</li>      <li>이용자가 이 약관의 내용에 동의하는 경우 “플랫폼”의 “서비스” 제공행위 및 이용자의 “서비스” 이용행위에는 이 약관이 우선적으로 적용될 것입니다. 이 약관에 명시되지 않은 사항에 대해서는 개인정보보호법, 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신윤리강령, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전자서명법, 전자금융거래법, 방문판매 등에 관한 법률, 소비자기본법 등 기타 대한민국의 관련법령, “플랫폼”이 별도로 정한 규정에 의합니다。</li>    </ol>    <h3>제4조 [서비스 이용계약]</h3>    <ol start=\"1\">      <li><span class=\"highlight\">서비스 이용계약은 “회원”이 되고자 하는 자가 “플랫폼”의 본 약관, 개인정보 처리방침, ‘개인정보 수집이용 동의서’에 “플랫폼”이 정한 소정의 방식(휴대폰 안심본인인증을 통한 본인인증 등)으로 동의하고, 가입양식에 회원정보(아이디, 비밀번호, 이름, 전화번호, 성별, 생년월일, 이메일, 소속기관, 기타 “플랫폼”이 필요하다고 인정하는 사항 등)을 기입하고 회원가입을 하면 “플랫폼”이 이에 대해 승낙함으로써 성립됩니다。</span></li>      <li>“회원”으로 가입하는 자는 “플랫폼”이 요구하는 개인신상정보를 성실히 제공하여야 합니다。</li>      <li>“플랫폼”은 아이디와 비밀번호를 접수받아 이를 관리하고, “서비스” 이용 시에 아이디 및 비밀번호 또는 “플랫폼”이 정한 소정의 방식(휴대폰 안심본인인증 등)으로 본인 인증을 위한 별도의 정보를 요구할 수 있습니다。</li>    </ol>    <h3>제5조 [서비스 이용신청의 승낙]</h3>    <ol start=\"1\">      <li>“플랫폼”은 이용자가 약관의 내용 및 개인정보처리방침에 대해서 동의를 하고, 이용자 인증완료 시 “서비스” 가입신청에 대한 승낙이 완료 됩니다。</li>      <li>“회원”은 “서비스”에 접속하거나 “서비스”를 이용하기 위해서는 아이디와 비밀번호 또는 “플랫폼”이 정한 소정의 인증방식에 필요한 별도의 정보를 입력하여야 하며, 이에 대해 “플랫폼”은 입력내용의 일치 여부를 확인한 후 승인한 자에 한해 “서비스”를 이용하게 할 수 있습니다。</li>      <li>“플랫폼”은 다음 각호에 해당하는 사항이 발생한 경우에는 이용신청의 승낙을 유보할 수 있습니다。</li>    </ol>    <ul>      <li>기술상 “서비스” 제공이 불가능한 경우</li>      <li>보안상 문제가 있다고 판단되는 경우</li>      <li>기타 사유로 이용 승낙이 곤란한 경우</li>    </ul>    <p class=\"indent\">“플랫폼”은 다음 각 호에 해당하는 이용신청에 대하여는 이를 승낙하지 아니할 수 있습니다。</p>    <ul>      <li>이름이 실명이 아닌 경우</li>      <li>다른 사람의 명의를 사용하여 신청한 경우</li>      <li>이용신청 시 필요한 내용을 허위로 기재하여 신청한 경우</li>      <li>기타 “플랫폼”이 정한 이용신청 요건에 미비 되었을 경우</li>    </ul>    <p class=\"indent\">“플랫폼”을 이용하여 구입한 데이터 상품 등의 대금, 기타 “플랫폼” 이용에 관련하여 회원이 부담하는 채무를 기일 내에 지급하지 않는 경우</p>    <p class=\"indent\">다른 사람의 “플랫폼” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우</p>    <p class=\"indent\">“플랫폼”을 이용하여 법령 또는 이 약관이 금지하거나 공공의 질서와 선량한 풍속에 반하는 행위를 하는 경우</p>    <h3>제6조 [서비스의 제공 및 제한]</h3>    <ol start=\"1\">      <li>“회원”은 “플랫폼”이 제공하는 모든 “서비스”의 이용이 가능합니다. 다만, 회원자격이나 유료서비스 여부에 따라 일부 “서비스” 이용이 제한될 수 있습니다。</li>      <li>만 14세 미만 아동의 “서비스” 회원 가입 및 이용은 차단하고 있습니다。</li>      <li>“서비스”의 이용은 “플랫폼”의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴 1일 24시간을 원칙으로 합니다. 다만, “서비스”의 종류 및 내용에 따라 일부 “서비스”는 별도 이용시간을 정하여 운영할 수 있으며, 이 경우 그 내용을 해당 “서비스” 이용화면에 공지함으로써 “회원”에게 통지합니다。</li>      <li>전 2항의 이용시간에도 불구하고 통신장애, 서비스 개발, 시스템 점검, 긴급조치 등 불가피한 사유에 의해 “서비스” 제공이 일정 기간 동안 제한 또는 중단될 수 있습니다。</li>      <li>“서비스” 이용에 제한을 하고자 하는 경우에는 그 사유 및 기간을 정하여 게시, 이메일 등을 통해 “회원”에게 통지할 수 있습니다。</li>      <li>“회원”에게 개별공지가 필요한 경우, “회원”이 등록한 이메일 주소를 통해 우선적으로 개별 통지합니다. 불특정 다수 “회원”에 대한 공지를 하는 경우, “플랫폼” 등에 게시함으로써 개별 통지에 갈음할 수 있습니다。</li>    </ol>    <h3>제7조 [정보 제공 및 홍보물⦁광고 게재]</h3>    <ol start=\"1\">      <li>“플랫폼”은 “회원”에게 “플랫폼”의 다양한 데이터, 서비스, 이벤트 등의 각종 정보를 홈페이지 게시, 이메일, 무선단문메시지(SMS) 및 기타의 방법을 통해 제공할 수 있습니다。</li>      <li>“회원”의 개인정보는 관련 법률이 정하는 바에 따라 엄격히 관리되며, “회원”은 원하지 않는 경우 “플랫폼”이 제공하는 정보의 수신을 거부할 수 있습니다。</li>      <li>“플랫폼”은 서비스에 적절하다고 판단되거나 공익성이 있는 홍보물을 게재할 수 있습니다。</li>      <li><span class=\"highlight\">“플랫폼”은 운용과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있다。</span></li>      <li><span class=\"highlight\">“플랫폼”은 사이트에 게재되어 있는 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않는다。</span></li>    </ol>    <h3>제8조 [서비스 이용계약의 해지]</h3>    <ol start=\"1\">      <li>“회원”이 “서비스” 이용계약을 해지할 경우, 관련 법령에서 정하는 바에 따라 일정 기간 보관이 필요한 정보를 제외하고, “회원”의 개인정보는 “서비스” 해지 후 지체 없이 삭제됩니다. 다만, 요금 정산, 분쟁 해결, 법적 의무 이행 등의 필요에 따라 일정 기간 보관될 수 있으며, 해당 기간이 경과한 후 안전하게 삭제됩니다。</li>      <li>“회원”은 이용신청 시 기재한 사항이 잘못되었거나 변경되었을 경우, 즉시 해당 사항을 수정해야 합니다. 회원정보의 변경은 “플랫폼”에서 변경할 수 있습니다. 단, 아이디(ID)는 수정할 수 없음을 원칙으로 합니다。</li>      <li>“플랫폼”은 “회원”이 다음 각 호에 해당하는 행위를 하였을 경우에는 사전 통지 없이 “서비스” 이용계약을 해지하거나 “서비스”의 이용을 중지시킬 수 있습니다。</li>    </ol>    <ul>      <li>아이디와 비밀번호 등 “회원” 고유정보를 타인에게 누설하거나 타인의 아이디 및 비밀번호를 도용한 경우</li>      <li>“서비스” 운영을 고의로 방해한 경우</li>      <li>가입한 성명이 실명이 아닌 경우</li>      <li>동일 사용자가 다른 아이디로 이중 등록한 경우</li>      <li>“회원”이 국익 또는 사회적 공익을 저해할 목적으로 “서비스” 이용을 계획 또는 실행하는 경우</li>      <li>“서비스”의 안정적 운영을 방해할 목적으로 정보를 전송하거나 광고성 정보를 전송하는 경우</li>      <li>통신설비의 오 동작이나 정보 등의 파괴를 유발시키는 컴퓨터 바이러스 프로그램 등을 유포하는 경우</li>      <li>“플랫폼”, 다른 “회원” 또는 제3자의 지적재산권을 침해하는 경우</li>      <li>“플랫폼”의 “서비스” 정보를 이용하여 얻은 정보를 “플랫폼”의 사전 승낙 없이 복제 또는 유통시키거나 상업적으로 이용하는 경우</li>      <li>본 약관을 포함하여 기타 “플랫폼”이 정한 이용조건 및 관계법령을 반해 더 이상의 “서비스” 제공이 어렵다고 판단되는 경우</li>    </ul>    <p class=\"indent\">전 3항에 해당하는 행위를 한 “회원”은 이로 인해 “플랫폼” 또는 다른 “회원”에게 발생한 손해를 배상할 책임이 있습니다。</p>    <p class=\"indent\">전 3항의 “플랫폼” 조치에 대하여 “회원”은 “플랫폼”이 정한 절차에 따라 이의신청을 할 수 있고, 이의가 정당하다고 인정하는 경우 “플랫폼”은 해당 서비스의 이용을 재개합니다。</p>    <h2>제3장 의무</h2>    <h3>제9조 [플랫폼의 의무]</h3>    <ol start=\"1\">      <li>“플랫폼”은 특별한 사정이 없는 한 “회원”이 신청한 서비스를 서비스제공 개시일에 이용할 수 있도록 합니다。</li>      <li>“플랫폼”은 시스템 점검 및 서비스 개발, 통신장애, 기타 불가항력적인 사고 등 특별한 사정이 없는 한 이 약관이 정한 바에 따라 지속적으로 안정적인 서비스를 제공할 의무가 있습니다。</li>      <li>“플랫폼”은 서비스 제공과 관련하여 알고 있는 “회원”의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다. 단, 관계법령에 의한 수사상의 목적으로 관계 기관으로부터 요구 받은 경우 등 법률의 규정에 따른 적법한 절차에 의한 경우에는 그러하지 않습니다。</li>      <li>“플랫폼”은 서비스의 관련한 “회원”의 불만사항이 접수되는 경우 이를 신속하게 처리하여야 하며, 신속한 처리가 곤란한 경우 그 사유와 처리 일정을 서비스 화면에 게재하거나 이메일 등을 통하여 동 “회원”에게 통지합니다。</li>      <li>“플랫폼”은 정보통신망 이용촉진 및 정보보호에 관한 법률, 통신비밀보호법 등 서비스의 운영, 유지와 관련 있는 법규를 준수합니다。</li>      <li>“플랫폼”은 “회원”이 안전하게 서비스를 이용할 수 있도록 개인정보 보호를 위해 보안시스템을 갖추어야 하며, 개인정보취급방침을 공시하고 준수합니다。</li>    </ol>    <h3>제10조 [회원의 의무]</h3>    <ol start=\"1\">      <li>“회원”은 “서비스”를 이용할 때 다음 각호의 행위를 하지 않아야 합니다。</li>    </ol>    <ul>      <li>다른 “회원”의 아이디 및 비밀번호를 부정하게 사용하는 행위</li>      <li>“서비스”를 이용하여 얻은 정보의 지적재산권을 침해하는 행위</li>      <li>타인의 명예를 손상시키거나 불이익을 주는 행위</li>      <li>“플랫폼” 및 제3자의 저작권, 지식재산권 등 기타 권리를 침해하는 내용인 경우</li>      <li>공공질서 및 미풍양속에 위반되는 내용의 정보, 문장, 도형, 음성 등을 타인에게 유포하는 행위</li>      <li>범죄와 결부된다고 객관적으로 인정되는 행위</li>      <li>“서비스”와 관련된 설비의 오 동작이나 정보 등의 파괴 및 혼란을 유발시키는 컴퓨터 바이러스 감염자료를 등록 또는 유포하는 행위</li>      <li>“서비스”의 안정적 운영을 방해할 수 있는 정보를 전송하거나 수신자의 의사에 반하여 광고성 정보를 전송하는 행위</li>      <li>기타 관계법령에 위배되는 행위</li>    </ul>    <p class=\"indent\">아이디와 비밀번호 관리에 관한 일체의 책임은 “회원” 본인에게 있습니다. “회원”에게 부여된 아이디와 비밀번호를 제3자에게 대여 또는 양도하거나 이와 유사한 행위를 하여서는 안되며, 아이디와 비밀번호의 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 “회원” 본인에게 있습니다。</p>    <p class=\"indent\">“회원”은 자신의 아이디가 부정하게 사용된 것을 인지한 경우, 즉시 자신의 비밀번호를 변경하고 “플랫폼”에 신고하여야 합니다. 신고를 하지 않음으로 인해 발생하는 모든 책임은 “회원” 본인에게 있습니다。</p>    <p class=\"indent\">“회원”은 본인의 신상 관련 사항이 변경되었을 때는 “플랫폼”을 통하여 수정하여야 합니다. 변경된 신상 정보를 변경하지 않음으로 인해 발생하는 모든 책임은 “회원” 본인에게 있습니다。</p>    <p class=\"indent\">“회원”은 “플랫폼”의 사전승낙 없이 “서비스”를 이용하여 영업활동을 할 수 없으며, 그 영업활동으로 인한 결과에 대하여 “플랫폼”은 책임을 지지 않습니다。</p>    <p class=\"indent\">“회원”은 이 약관 및 관계법령에서 규정한 사항과 “서비스” 이용안내 또는 주의사항을 성실히 준수하여야 합니다。</p>    <p class=\"indent\">“회원”은 내용별로 “플랫폼”이 “서비스” 공지사항에 게시하거나 별도로 공지한 이용 제한사항을 준수하여야 합니다。</p>    <p class=\"indent\">“회원”은 “플랫폼”의 사전동의 없이 “서비스”의 이용권한, 기타 이용계약상 지위를 타인에게 양도, 증여할 수 없으며 이를 담보로 제공할 수 없습니다。</p>    <h2>제4장 관리 및 책임</h2>    <h3>제11조 [게시물 등의 관리]</h3>    <ol start=\"1\">      <li>“플랫폼”은 “서비스”를 제공하는 “플랫폼”의 원활한 관리 감독을 위하여 필요한 경우, 게시되는 내용물에 대해 추가 수정 삭제할 수 있으며, “회원”에게 별도 통지 없이 “서비스”의 개편 및 내용의 추가 수정 삭제를 할 수 있습니다。</li>      <li>“플랫폼”은 “회원”이 게시하거나 전달하는 “서비스” 내의 모든 내용물이 다음의 경우에 해당한다고 판단되는 경우 별도의 사전 통지 없이 삭제할 수 있으며, 이에 대해 “플랫폼”은 어떠한 책임도 지지 않습니다。</li>    </ol>    <ul>      <li>“플랫폼”, 다른 “회원” 또는 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우</li>      <li>공공질서 및 미풍양속에 위반되는 내용인 경우</li>      <li>범죄적 행위에 결부된다고 인정되는 내용인 경우</li>      <li>“플랫폼”의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>      <li>“플랫폼”에서 규정한 게시기간을 초과한 경우</li>      <li>“플랫폼”에서 제공하는 “서비스”와 관련 없는 내용인 경우</li>      <li>불필요하거나 승인되지 않은 광고, 판촉물을 게재하는 경우</li>      <li>기타 관계법령 및 “플랫폼”의 세부지침 등에 위반된다고 판단되는 경우</li>    </ul>    <p class=\"indent\">“플랫폼”은 게시물에 관련된 세부 이용지침을 별도로 정하여 시행할 수 있으며, “회원”은 그 지침에 따라 각종 게시물을 등록, 삭제 등을 하여야 합니다。</p>    <p class=\"indent\">“회원”은 개인적인 이익을 위하여 “플랫폼”에 게시물의 추가적 게재 등의 요구를 할 수 없습니다。</p>    <h3>제12조 [링크사이트에 대한 책임]</h3>    <ol start=\"1\">      <li>“플랫폼”에 링크된 외부사이트 및 자료에 대한 아무런 통제권이 없으므로 “플랫폼”은 보증도 하지 않으며, 그에 대해 책임이 없습니다。</li>      <li>“회원”은 링크된 외부사이트의 “서비스”나 자료를 신뢰함으로써 야기되거나 야기되었다고 주장되는 어떠한 손해나 손실에 대해서는 “플랫폼”에 책임이 없습니다。</li>    </ol>    <h2>제5장 손해배상 등</h2>    <h3>제13조 [손해배상]</h3>    <p>“플랫폼”은 “서비스” 이용과 관련하여 이용자에게 어떠한 손해가 발생하더라도 손해가 “플랫폼”이 고의로 행한 범죄행위를 제외하고 이에 대하여 책임을 부담하지 아니합니다。</p>    <h3>제14조 [면책]</h3>    <ol start=\"1\">      <li>“플랫폼”은 다음 각호의 사유로 인하여 “회원”에게 발생한 손해에 대해서는 책임을 지지 않습니다。</li>    </ol>    <ul>      <li>통신기기, 회선 및 컴퓨터의 장애나 거래 폭주 등 부득이한 사정으로 “서비스”가 제공되지 못하거나 지연된 경우</li>      <li>“회원”이 아이디, 비밀번호 등을 본인의 관리소홀로 인해 제3자에게 누출한 경우</li>      <li>“회원”의 귀책사유(전산조작이나 업무처리 오류 등)로 인한 경우</li>      <li>기타 천재지변 등의 불가피한 사유로 인한 경우</li>    </ul>    <p class=\"indent\">“플랫폼”은 “회원”이 “서비스”를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며 그 밖에 “서비스”를 통하여 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다. “플랫폼”은 “회원”이 “플랫폼”에 게재한 정보, 자료의 신뢰도, 정확성 등 내용에 대하여는 책임을 지지 않습니다。</p>    <p class=\"indent\">“플랫폼”은 “회원” 상호간 또는 “회원”과 제3자 상호간에 “서비스”를 매개로 발생한 분쟁에 대해서는 개입할 의무가 없으며 이로 인한 손해를 배상할 책임도 없습니다。</p>    <h3>제15조 [개인정보 제공 동의 등]</h3>    <ol start=\"1\">      <li>“플랫폼”이 제3자에게 구매자 개인정보를 제공할 필요가 있는 경우, 개인정보를 제공받는 자, 개인정보를 제공받는 자의 개인정보 이용목적, 제공하는 개인정보의 항목, 개인정보를 제공받는 자의 개인정보 보유 및 이용기간을 구매자에게 알리고 동의를 받아야 합니다。</li>      <li>“플랫폼”이 제3자에게 구매자의 개인정보를 취급할 수 있도록 업무를 위탁하는 경우에는 개인정보 취급위탁을 받는 자, 개인정보 취급위탁을 하는 업무의 내용을 구매자에게 알리고 동의를 받아야 합니다。</li>      <li><span class=\"highlight\">회원은 상품 주문 정보를 마이페이지를 통해 확인할 수 있으며, “플랫폼”은 데이터 상품의 주문 취소 방법 및 절차를 안내합니다。</span></li>      <li>다만, 서비스제공에 관한 계약이행을 위해 필요하고 구매자의 편의증진과 관련된 경우에는 개인정보보호법에서 정하고 있는 방법으로 개인정보 취급방침을 통해 알림으로써 고지절차와 동의절차를 거치지 않아도 됩니다。</li>    </ol>    <h3>제16조 [개인정보보호정책]</h3>    <ol start=\"1\">      <li>“플랫폼”은 이용 신청 시 “회원”이 제공하는 정보를 통하여 “회원”에 관한 정보를 수집하며, “회원”의 개인정보는 본 이용계약의 이행과 본 이용계약상의 서비스제공을 위한 목적으로 이용합니다。</li>      <li>“플랫폼”은 “서비스” 제공과 관련하여 취득한 “회원”의 정보를 본인의 승낙 없이 제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 법률의 규정에 따른 적법한 절차에 의한 경우에는 제외합니다。</li>    </ol>    <h3>제17조 [저작권의 귀속 및 이용제한]</h3>    <ol start=\"1\">      <li>“플랫폼”이 제공하는 데이터, “서비스”, 그에 필요한 화면 등과 관련된 지적재산권 및 기타 관리는 “플랫폼”에 귀속됩니다。</li>      <li>“회원”은 “플랫폼”이 제공하는 “서비스”를 이용함으로써 얻은 정보 중 “플랫폼”에 지적재산권이 귀속된 정보를 사전 승낙 없이 출판, 복제, 방송 및 기타 방법에 의하여 유포하거나 제3자에게 이용하게 해서는 아니 됩니다。</li>      <li>“회원”이 “서비스” 내에 게시한 게시물의 저작권은 “회원”이 소유하며 “플랫폼”은 “서비스” 내에 이를 게시할 수 있는 권리를 갖습니다。</li>      <li>“플랫폼”은 “회원”의 동의 없이 게시물을 다른 목적으로 사용할 수 없습니다。</li>      <li>“플랫폼”은 “회원”이 “서비스” 내에 게시한 게시물이 타인의 저작권, 프로그램 저작권 등을 침해하더라도 이에 대해 민, 형사 상의 책임을 부담하지 않습니다. 만일 “회원”이 타인의 저작권, 프로그램 저작권 등을 침해하였음을 이유로 “플랫폼”이 타인으로부터 손해배상 청구 등 이의 제기를 받은 경우 “회원”은 “플랫폼”의 면책을 위하여 노력해야 하며, “플랫폼”이 면책되지 못한 경우 “회원”은 그로 인해 “플랫폼”에 발생한 모든 손해를 부담하여야 합니다。</li>      <li>“플랫폼”은 “회원”이 해지하거나 적법한 사유로 해지된 경우 해당 “회원”이 게시하였던 게시물을 삭제할 수 있습니다。</li>    </ol>    <h3>제18조 [약관위반 시 책임]</h3>    <ol start=\"1\">      <li>“플랫폼”과 “회원”은 이 약관을 위반함으로써 발생하는 모든 책임을 각자 부담하며, 이로 인하여 상대방에게 손해를 입힌 경우에는 지체 없이 배상하여야 합니다。</li>    </ol>    <h3>제19조 [분쟁해결 및 관할법원]</h3>    <ol start=\"1\">      <li>“서비스” 이용과 관련하여 “플랫폼”과 “회원” 사이에 분쟁이 발생한 경우, 우선 쌍방간에 분쟁의 해결을 위해 성실히 노력하여야 합니다。</li>      <li>“플랫폼”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 그에 준하는 기관의 조정에 따를 수 있습니다。</li>      <li>전1항의 노력에서도 분쟁이 해결되지 않을 경우, 관할법원은 “플랫폼” 운영사의 소재지를 관할하는 법원을 관할법원으로 합니다。</li>    </ol>  </div></div>',
                        width: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 550.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointMedium) {
                            return 630.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointLarge) {
                            return 730.0;
                          } else {
                            return 750.0;
                          }
                        }(),
                        height: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 550.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointMedium) {
                            return 630.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointLarge) {
                            return 730.0;
                          } else {
                            return 750.0;
                          }
                        }(),
                        verticalScroll: false,
                        horizontalScroll: false,
                        html: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: FFLocalizations.of(context).getText(
                      '8x2gdps1' /* 확인 */,
                    ),
                    options: FFButtonOptions(
                      width: 100.0,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFF284E75),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 12.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 12.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 12.0;
                                  } else {
                                    return 16.0;
                                  }
                                }(),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
