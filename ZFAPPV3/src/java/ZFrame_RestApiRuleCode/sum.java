
package ZFrame_RestApiRuleCode;


import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.presentation_layer.interface_rule.BaseRestServiceAction;
import zdg.zframe.relational_database.Manipulation;

/*
  ZFrame Rest Api Developer Code 

   this.WebPage ;
   this.Paramlist ;
   this.CJson ;
   this.GetParamValue("Name");

*/

public  class sum extends BaseRestServiceAction
    {

            public sum()
                {

                  this.RuleID = 103;
                }
            
            @Override
            public void manageAction()
                {

                            try 
                            {
                                Manipulation dbh =new Manipulation();
                                dbh.SystemID =1;
                           
                                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Call Service Sum Step 1", 1000 );
                                String  val1 = this.getParamValue("val1");
                                String  val2 = this.getParamValue("val2");
                                try
                                {
                                    long a = Long.valueOf(val1);
                                    long b = Long.valueOf(val2);
                                    long c  = a+b ;
                                    
                                    this.ChannelContext.getHttpServletResponse().getWriter().write("[{\"RTV\":\""+String.valueOf(c)+"\"}]");
                                    
                                     LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Success, "Call Service Sum Step 2 ", 1000 );
                                    return ;
                                }
                                catch (Exception ex)
                                {
                                    
                                }
                                
                                
                                this.ChannelContext.getHttpServletResponse().getWriter().write("[{\"RTV\":\""+String.valueOf(-1)+"\"}]");
                                
                            }
                            catch (IOException ex)
                            {
                                Logger.getLogger(sum.class.getName()).log(Level.SEVERE, null, ex);
                                
                            }
                
                }
            
             
             
    
    }
