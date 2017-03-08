CREATE OR REPLACE PROCEDURE P_SMAIL IS
  P_FROM     VARCHAR2(200) := 'fqiyou'; --������name
  P_FROMA    VARCHAR2(200) := '1522105005@qq.com'; --������Mail
  P_TO       VARCHAR2(200) := 'lys'; --�ռ���name
  P_TOA      VARCHAR2(200) := 'yc@fqiyou.com'; --�ռ���Mail
  P_CC       VARCHAR2(200) := 'yangchao'; --������name
  P_CCA      VARCHAR2(200) := 'yc.fqiyou@gmail.com'; --������Mail
  P_SUBJ     VARCHAR2(200) := 'ORACLE�з����ʼ�����'; --����
  P_MESS     VARCHAR2(200) := 'ORACLE�з����ʼ����ԣ�ʱ��' ||
                              TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') ||
                              '�ﵽĿ�ģ���ORACLE�洢�����з����ʼ�'; --����
  P_USER     VARCHAR2(200) := '1522105005@qq.com'; --�����˺�
  P_ASS      VARCHAR2(200) := 'edimoapxjmxahifj'; --��������
  P_MAILHOST VARCHAR2(200) := 'smtp.qq.com'; --����smtp
  V_PORT     NUMBER := 25; --����smtp�˿�
  V_CONN     UTL_SMTP.CONNECTION;
  V_MSG      VARCHAR2(4000);

BEGIN
  --�ʼ����� ע�ⱨͷ��Ϣ���ʼ�����֮��Ҫ��һ��
  V_MSG := 'Date:' || TO_CHAR(SYSDATE, 'yyyymmdd hh24:mi:ss') ||
           UTL_TCP.CRLF || 'From: ' || P_FROM || '<' || P_FROMA || '>' ||
           UTL_TCP.CRLF || 'To: ' || P_TO || '<' || P_TOA || '>' ||
           UTL_TCP.CRLF || 'Cc: ' || P_CC || '<' || P_CCA || '>' ||
           UTL_TCP.CRLF || 'Subject: ' || P_SUBJ || UTL_TCP.CRLF ||
           UTL_TCP.CRLF || P_MESS;

  V_CONN := UTL_SMTP.OPEN_CONNECTION(P_MAILHOST, V_PORT);
  UTL_SMTP.HELO(V_CONN, P_MAILHOST);
  UTL_SMTP.COMMAND(V_CONN, 'AUTH LOGIN');
  UTL_SMTP.COMMAND(V_CONN,
                   UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(P_USER))));
  UTL_SMTP.COMMAND(V_CONN,
                   UTL_RAW.CAST_TO_VARCHAR2(UTL_ENCODE.BASE64_ENCODE(UTL_RAW.CAST_TO_RAW(P_ASS))));
  UTL_SMTP.MAIL(V_CONN, '<' || P_FROMA || '>');

  IF P_CCA IS NOT NULL THEN
    UTL_SMTP.RCPT(V_CONN, P_CCA); --���ʼ�
  END IF;

  UTL_SMTP.OPEN_DATA(V_CONN);
  UTL_SMTP.WRITE_RAW_DATA(V_CONN, UTL_RAW.CAST_TO_RAW(V_MSG));
  UTL_SMTP.CLOSE_DATA(V_CONN);
  UTL_SMTP.QUIT(V_CONN);

EXCEPTION
  WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
    BEGIN
      utl_smtp.quit(V_CONN);
    EXCEPTION
      WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
        NULL;
    END;
  WHEN OTHERS THEN
    raise_application_error(-20000,
                            DBMS_UTILITY.FORMAT_ERROR_STACK || sqlerrm);
END;
/
