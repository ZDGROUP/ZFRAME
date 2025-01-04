
package ZFrame_RestApiRuleCode;

import zdg.zframe.presentation_layer.interface_rule.BaseRestServiceAction;

/*
  ZFrame Rest Api Developer Code 

   this.WebPage ;
   this.Paramlist ;
   this.CJson ;
   this.GetParamValue("Name");

*/

public  class msum extends BaseRestServiceAction
    {

            public msum()
                {

                  this.RuleID = 745745;
                }
            
            @Override
            public void manageAction()
                {

                                 
                    String  v1 = this.getParamValue("v1"); 
                    String  v2 = this.getParamValue("v2"); 
                     
                    
                    long mv1 = Long.valueOf(v1);
                    long mv2 = Long.valueOf(v2);
                    
                    long rt  = (( mv1 * mv2 ) / 2) ;
                    
                    try 
                    {
                    
                         this.ChannelContext.getHttpServletResponse().getWriter().write("[{\"RTC\":\""+String.valueOf(rt)+"\"}]" );
                                 
                    }catch (Exception ex){}

                
                }
    
    }
