/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.zframe.request.preparation;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.context.ZContext;
import zdg.zframe.engine_interface_rule.Request_Preparation;

/**
 *
 * @author zframe developer 
 */
public class JWT_PROCESS extends  Request_Preparation{

    static int CounterRequest = 0 ;
    
    
    
    @Override
    public boolean processOnInitRequest(ZContext Context) {
        
        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information,"Start Request Propration ", 100 );
         //Context.m_HttpServletRequest.getSession(false);
         //Context.m_HttpServletRequest.getSession().invalidate();
         
         CounterRequest++;        
         //String G = Context.GetRequestData();
         //Context.SetJWTSessionBagData("FULLDATA", G);
            
         try 
         {
                 String TokenData = Context.m_HttpServletRequest.getHeader("CCTOKEN");
                 if (TokenData != null)
                 {
                        String ContentDataHeader  =  "TEST" ; // Token_Management.AES.decrypt(TokenData, JWTTOKENKEY.JWTTOKENKEYVALUE.TOKNKEY);
                        Object obj = new JSONParser().parse(ContentDataHeader);
                        JSONObject jo =  (JSONObject) obj;
                        String Version =  jo.get("Version").toString();         // Version
                        String Enc =  jo.get("Enc").toString();                 // Encryption Key 
                        String MID =  jo.get("MID").toString();                 // Member ID 
                        String DID =  jo.get("DID").toString();                 // Device ID 
                        String CDATE =  jo.get("CDATE").toString();  
                        String MobileNumber =  jo.get("MO").toString();
                        // CDATE
                        Context.setJWTSessionBagData("KEYENC", Enc);
                        Context.setJWTSessionBagData("MEMBER_ID", MID);
                        Context.setJWTSessionBagData("DEVICE_ID", DID);
                        Context.setJWTSessionBagData("TOKENDATE", CDATE);                        
                        Context.setJWTSessionBagData("MOBILENO", MobileNumber);                        
                        Context.setJWTSessionBagData("JWTVERSION", Version);                        
                        
                        if (!Version.equals("1"))
                        {
                            // GET OTHER PARAMETER 
                            // LIKE AS USER_ID AND E_ID 
                            
                            String OTPCODE =  jo.get("OTP").toString();
                            Context.setJWTSessionBagData("OTP", OTPCODE);                                                    
                            if (Version.equals("3"))
                            {
                              //  if (CC_Redis.OnlineToken.CheckExistToken(MID, DID, TokenData))
                               // {
                                
                                if ( true )// IS_ACTIVE_TOKEN.Check_IS_ACTIVE_TOKEN(Long.valueOf(DID)))
                                {
                                    Context.setJWTSessionBagData("USER_ID", MID);                        
                                    Context.setJWTSessionBagData("USID", MID);                        
                                    Context.setJWTSessionBagData("ENID", MID);                        
                                    Context.setJWTSessionBagData("CMID", MID);                        
                                    Context.setJWTSessionBagData("UGL",".2.");                                                                
                                }
                                 else
                                {
                                   Context.getHttpServletResponse().sendError(403, " 403 Forbidden vs 401 Unauthorized HTTP responses ");                        
                                   return false;
                                }
                                    
                                //}
                               
                            }
                            
                        }
                        
                 }
         }
         catch (Exception exx)
         {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, " Error In JWT Requet "+ exx.getMessage() , 100, "Request_Preparation" , exx);
                
         }
         
                                 
         return true;
    }
    
    
}
