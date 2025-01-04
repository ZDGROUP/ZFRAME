/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.zframe.disposeaction;


import javax.servlet.http.HttpSession;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.context.ZContext;
import zdg.zframe.engine_interface_rule.Base_Dispose_Trigger_Action;

/**
 *
 * @author S_Rafiei
 */
public class ZFTestDisposeAction extends Base_Dispose_Trigger_Action
{

    @Override
    public void closeTrigger(ZContext Context, String FormId, String ChainID, String SessionID) {
                    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "######### Close Form ID("+ FormId+"),ChainID("+ChainID+")Session("+SessionID+")" ,2000);
    }

    @Override
    public void closeSession(String SessionID, String Sys_user_ID, HttpSession SessionContext) {
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "######### Close Session ("+ SessionID+"),User_ID("+ Sys_user_ID +")" ,2000);
    }

    
    
}
