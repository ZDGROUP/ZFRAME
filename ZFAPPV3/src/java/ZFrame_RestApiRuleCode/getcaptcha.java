
package ZFrame_RestApiRuleCode;

import BaseClass.GenerateCaptcha;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import zdg.zframe.aspect.log.LIB_ASPECT;

import zdg.zframe.presentation_layer.interface_rule.BaseRestServiceAction;

/*
  ZFrame Rest Api Developer Code 

   this.WebPage ;
   this.Paramlist ;
   this.CJson ;
   this.GetParamValue("Name");

*/

public  class getcaptcha extends BaseRestServiceAction
    {

            public getcaptcha()
                {

                  this.RuleID = 111111;
                }
            
            @Override
            public void manageAction()
                {

                try { 
                    
                    try {
                        
                        
                                String  value = this.getParamValue("value");
                                if (value != null && value.length() > 8)
                                {
                                    GenerateCaptcha CCh = new GenerateCaptcha();
                                   
                                    String CaptchValue  =  CCh.GenerateCaptchString();
                                    String data =  CCh.GetImage(CaptchValue);
                                    this.ChannelContext.getHttpServletRequest().getSession().setAttribute("CAPTCHA", CaptchValue);                                    
                                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "@@@@@@@@@@@@@@ => Cptcha Code is  " + CaptchValue , 100);
                                    String h =  "{\"chimage\":\""+data+"\"}";
                                    this.ChannelContext.getHttpServletResponse().getWriter().write(h);
                                    this.ChannelContext.getHttpServletResponse().getWriter().flush();
                                    return;
                                }

                            } catch (IOException ex) {
                                Logger.getLogger(getcaptcha.class.getName()).log(Level.SEVERE, null, ex);
                            }
                    
                    
                    this.ChannelContext.getHttpServletResponse().sendError(404, " HTTP 404, 404 Not Found HTTP Methods");
                    return;
                    
                    
                } catch (IOException ex) {
                    Logger.getLogger(getcaptcha.class.getName()).log(Level.SEVERE, null, ex);
                }

                
                }
    
    }
