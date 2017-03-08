CREATE OR REPLACE PROCEDURE P_SMAIL IS
  P_FROM     VARCHAR2(200) := 'fqiyou'; --发件人name
  P_FROMA    VARCHAR2(200) := '1522105005@qq.com'; --发件人Mail
  P_TO       VARCHAR2(200) := 'lys'; --收件人name
  P_TOA      VARCHAR2(200) := 'yc@fqiyou.com'; --收件人Mail
  P_CC       VARCHAR2(200) := 'yangchao'; --抄送人name
  P_CCA      VARCHAR2(200) := 'yc.fqiyou@gmail.com'; --抄送人Mail
  P_SUBJ     VARCHAR2(200) := 'ORACLE中发送邮件测试'; --主题
  P_MESS     VARCHAR2(200) := 'ORACLE中发送邮件测试：时间' ||
                              TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') ||
                              '达到目的：在ORACLE存储过程中发送邮件'; --内容
  P_USER     VARCHAR2(200) := '1522105005@qq.com'; --邮箱账号
  P_ASS      VARCHAR2(200) := 'edimoapxjmxahifj'; --邮箱密码
  P_MAILHOST VARCHAR2(200) := 'smtp.qq.com'; --邮箱smtp
  V_PORT     NUMBER := 25; --邮箱smtp端口
  V_CONN     UTL_SMTP.CONNECTION;
  V_MSG      VARCHAR2(4000);

BEGIN
  --邮件内容 注意报头信息和邮件正文之间要空一行
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
    UTL_SMTP.RCPT(V_CONN, P_CCA); --主邮件
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
