package ZFrame_RestApiRuleCode;

import zdg.zframe.Dictionary;
import java.io.IOException;
import java.util.ArrayList;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.presentation_layer.interface_rule.BaseRestServiceAction;
import zdg.zframe.relational_database.Manipulation;

/*
  ZFrame Rest Api Developer Code 

   this.WebPage ;
   this.Paramlist ;
   this.CJson ;
   this.GetParamValue("Name");

 */
public class loginuser extends BaseRestServiceAction {

    public loginuser() {

        this.RuleID = 102;
    }

    @Override
    public void manageAction() {
        try {
           Manipulation DBH = new Manipulation();
            DBH.SystemID = 1;
            DBH.WebPage = this.ChannelContext;

            String mobileno = this.getParamValue("mobileno");
            String password = this.getParamValue("password");
            String captha = this.getParamValue("captha");

            String rtCode = "-5";
            String Message = "کد امنیتی درست نیست";
            try {
                String Server_Captcha = this.ChannelContext.getHttpServletRequest().getSession().getAttribute("CAPTCHA").toString();
                if (Server_Captcha.equals(captha)) {
                    
                    String Query_Select_SYS_USER ="SELECT COUNT(*) FROM SYS_USER WHERE USERNAME=@STRMOBILENO AND PASSWORD=@STRPASSWORD";
                     ArrayList<zdg.zframe.Dictionary> ParamListEntity = new ArrayList<>();
                                                     ParamListEntity.add(new Dictionary("STRMOBILENO", mobileno));
                                                     ParamListEntity.add(new Dictionary("STRPASSWORD", password));
                    DataTable _Ctable = DBH.executeDataTableByDictionery(Query_Select_SYS_USER,ParamListEntity);
                    if (_Ctable != null && _Ctable.getRowCount() == 0) {
                        rtCode="-4";
                        Message = "کاربر در سیستم موجود نمی باشد";
                    }
                    else if(_Ctable != null && _Ctable.getRowCount() == 0)
                        rtCode="200";
                        Message = "خوش آمدید";
                }

            } catch (Exception ex) {

            }
            this.ChannelContext.getHttpServletResponse().getWriter().write("{\"sys_code}\":\""+rtCode+"\"Message\" :\""+Message+"\"}");
            this.ChannelContext.getHttpServletResponse().getWriter().flush();
        } catch (IOException ex) {
            LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, " reguser Service Error ", 400, " Rest Service  ", ex);
        }

    }

}
