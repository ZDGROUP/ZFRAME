/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tools;

import com.google.common.io.ByteStreams;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.aspect.log.LIB_ASPECT.ViewMode;



public class REST_Client {


   
     
     
     public byte[] CallRestApiPost(String Url,String Contenet , ArrayList< zdg.zframe.Dictionary> Parameter )
     {
         try {
		URL url = new URL(Url);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setDoOutput(true);
                
                        conn.setRequestMethod("POST");
                        conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
                         for (int a=0 ;a < Parameter.size() ; a++)
                         {
                             conn.setRequestProperty(Parameter.get(a).Name, Parameter.get(a).Value);
                         }
                        
                        
                         // System.out.println(input.toString());
        		OutputStream os = conn.getOutputStream();
                        DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
                        BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(wr, "UTF-8"));
                        writer.write(Contenet);
                        writer.close();
                        wr.close();
                        
                        //writer.write(input.toString().getBytes ("UTF-8"));
                	//os.write(
                        //os.flush();
                

		byte[] buffer = ByteStreams.toByteArray(conn.getInputStream());                                
		conn.disconnect();                
                return buffer;
                        

	  } catch (MalformedURLException e) {

		           LIB_ASPECT.zPrintD(ViewMode.Error,"Error In  CallRestApiPost"+e.getMessage(), 0,e);

	  } catch (IOException e) {

		LIB_ASPECT.zPrintD(ViewMode.Error,"Error In  CallRestApiPost"+e.getMessage(), 0,e);

	 }
         
         return null;

	}
     
     
     }
    
