package ZFrame_RestApiRuleCode;

import zdg.zframe.Dictionary;

import java.util.ArrayList;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.infrastructure.Metadata_DataBase_Handler;
import zdg.zframe.presentation_layer.interface_rule.BaseRestServiceAction;


/*
  ZFrame Rest Api Developer Code 

   this.WebPage ;
   this.Paramlist ;
   this.CJson ;
   this.GetParamValue("Name");

 */
public class login extends BaseRestServiceAction {

    public login() {

        this.RuleID = 100;
    }

    @Override
    public void manageAction() {

        try {
            String username = this.getParamValue("username");
            String password = this.getParamValue("password");
            if (username.trim().length() > 3 && password.trim().length() > 3) {

               Metadata_DataBase_Handler Dbh = new Metadata_DataBase_Handler();
                String QueryForGetUserWithPassWord = "select Sys_User_ID from sys_user where UserName = @strusername and Password = @strpassword and Active = 1 ";
                ArrayList<zdg.zframe.Dictionary> Param = new ArrayList<>();
                Param.add(new Dictionary("username", username));
                Param.add(new Dictionary("password", password));
                DataTable Ctable = Dbh.executeDataTableByDictionery(QueryForGetUserWithPassWord, Param);
                if (Ctable != null && Ctable.getRowCount() == 1) {

                    String TrueAccess = "{\n"
                            + "  \"Autentication\":\"True\"\n"
                            + "}";

                    String User_ID = Ctable.getDataRow(0).getColumnData(0).toString();
                    this.ChannelContext.setTokenValue("USER_ID", User_ID); // create session in application server 
                    this.ChannelContext.setTokenValue("RULE_ID", 1); // create session in application server 
                    
                    this.ChannelContext.getHttpServletResponse().getWriter().write(TrueAccess);
                    this.ChannelContext.getHttpServletResponse().getWriter().flush();

                    return;
                }
            }

            String FalseAccess = "{\n"
                    + "  \"Autentication\":\"False\"\n"
                    + "}";
            this.ChannelContext.getHttpServletResponse().getWriter().write(FalseAccess);
            this.ChannelContext.getHttpServletResponse().getWriter().flush();

        } catch (Exception ex) {
        }
    }

}
