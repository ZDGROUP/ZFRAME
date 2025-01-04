/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BaseClass;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.DataOutputStream;
import java.nio.charset.StandardCharsets;
import myReport.TestServlet;
import org.json.*;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.aspect.log.LIB_ASPECT.ViewMode;

/**
 *
 * @author Administrator
 */
public class ERPLogin {

    
    private static String Last_Token = "";
    private static String Last_DateTime ="";
    public static long DefValue = 1000000;
    public static String GetADFSToken() {
        
        try 
        {
              LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, " Start Get Token From ADFS ", 0);
             if ( Last_DateTime.trim().length() != 0)
             {
                  String NowDateTime  = TestServlet.getCurrentTimeStamp();
                  long Def = TestServlet.differenceTime(Last_DateTime, NowDateTime);
                  if (Def < DefValue)
                  {
                    return Last_Token;
                  }
                  
             }
                String urlParameters = "client_id=" + ERPConfig.client_id + "&client_secret=" + ERPConfig.client_secret + "&resource=" + ERPConfig.resource + "&tenant_id=" + ERPConfig.tenant_id + "&grant_type=" + ERPConfig.grant_type;
                byte[] postData = urlParameters.getBytes(StandardCharsets.UTF_8);
                int postDataLength = postData.length;
                String request = ERPConfig.ADFSAddress;
                URL url = new URL(request);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setDoOutput(true);
                conn.setInstanceFollowRedirects(false);
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                conn.setRequestProperty("charset", "utf-8");
                conn.setRequestProperty("Content-Length", Integer.toString(postDataLength));
                conn.setUseCaches(false);
                try (DataOutputStream wr = new DataOutputStream(conn.getOutputStream())) {
                    wr.write(postData);
                }

                BufferedReader in = new BufferedReader(
                        new InputStreamReader(
                                conn.getInputStream()));

                StringBuilder FullData = new StringBuilder();
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    FullData.append(decodedString);
                }
                in.close();
                String rt = conn.getResponseMessage();
                JSONObject tokenjson = new JSONObject(FullData.toString());
                String access_token =  tokenjson.getString("access_token");
                String token_type = tokenjson.getString("token_type");
                String expires_in =  tokenjson.getString("expires_in"); 
                DefValue = Long.valueOf(expires_in);
                Last_Token = access_token;
                Last_DateTime =  TestServlet.getCurrentTimeStamp();
                return access_token;
                
        }
        catch (Exception ex) {
             LIB_ASPECT.zPrintD( ViewMode.Error, "Error On Get Token From ADFS ", 0, ex);
        }
        
        return "error";
    }

}
