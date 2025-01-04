/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ZFrame_InitRule;

import zdg.zmq.aspect.ZPrint;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.infrastructure.Metadata_DataBase_Handler;
import zdg.zframe.relational_database.Manipulation;
import java.util.logging.Level;
import java.util.logging.Logger;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.engine_interface_rule.Engine_Init_Rule;

/**
 *
 * @author eskandari.hesam
 */
public class InitApplication extends Engine_Init_Rule {

    public InitApplication() {

    }

    @Override
    public void start() {

        zdg.zframe.relational_database.Manipulation Dbh = new Manipulation();
        Dbh.SystemID = zdg.zframe.configuration.ApplicationInformation.SystemList.get(0).Sys_System_ID;
        DataTable TblData = null;
        if (zdg.zframe.configuration.ApplicationInformation.SystemList.get(0).Sys_DataBase_Type_ID == 2)
        {
              TblData = Dbh.executeDataTable(" select 1 from dual  ");
        }
        else 
        {
              TblData = Dbh.executeDataTable(" select 1   ");
        }
        
        if (TblData != null)
        {
            zdg.zframe.aspect.log.LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Success, "Check DataBase With Connection pool Success ", 0);
        }
        
            //        if (TblData != null && TblData.getRowCount() > 0) {
            //            LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Success, " Vendor Portal Application Start  : Start Connection Pool In Vendor Portal  ", 2000);
            //            StartThreadWorkFlowCheck();
            //        } else {
            //           LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Error, " Error  Vendor Portal INIT RULE : Start Connection Pool In Vendor Portal  ", 2000);
            //        }
    }

    private void StartThreadWorkFlowCheck() {

        int SleepTime = 1000 * 60 * 5;
        Runnable serverTask;
        serverTask = new Runnable() {
            @Override
            public void run() {
                zdg.zmq.aspect.ZPrint.zPrintD(ZPrint.ViewMode.View, " WorkFlow Engine Start Thread  ", 2);
                zdg.zframe.infrastructure.Metadata_DataBase_Handler Dp = new Metadata_DataBase_Handler();

                while (true) {

                    try {

                        try {

                            zdg.zmq.aspect.ZPrint.zPrintD(ZPrint.ViewMode.View, " Start Excute WorkFlow Check Status   ", 2);
                            Dp.executeNoneQuery(" EXEC [WFM].[AUTOMATIC_CONFIRMATION_PROCESS_TASKS] ");
                            zdg.zmq.aspect.ZPrint.zPrintD(ZPrint.ViewMode.View, " End  Excute WorkFlow Check Status   ", 2);

                        } catch (Exception ex) {
                            //  ZAspectDev.ZPrint.zPrintD(ZPrint.ViewMode.Error, " Error In Check Workflow Status   " + ex.getMessage(), 100);
                        }

                        Thread.sleep(SleepTime);
                    } catch (InterruptedException ex) {
                        Logger.getLogger(InitApplication.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        };

        Thread serverThread = new Thread(serverTask);
        serverThread.start();

    }

}
