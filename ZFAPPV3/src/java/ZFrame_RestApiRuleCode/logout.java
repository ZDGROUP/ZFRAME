
package ZFrame_RestApiRuleCode;

import zdg.zframe.presentation_layer.interface_rule.BaseRestServiceAction;

/*
  ZFrame Rest Api Developer Code 

   this.WebPage ;
   this.Paramlist ;
   this.CJson ;
   this.GetParamValue("Name");

*/

public  class logout extends BaseRestServiceAction
    {

            public logout()
                {

                  this.RuleID = 101;
                }
            
            @Override
            public void manageAction()
                {


                    try 
                    {
                        this.ChannelContext.getHttpServletRequest().getSession().invalidate(); // remove session 
                    }
                    catch (Exception ex){}

                
                }
    
    }
