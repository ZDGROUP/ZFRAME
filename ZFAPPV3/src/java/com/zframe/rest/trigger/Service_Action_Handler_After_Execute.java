/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.zframe.rest.trigger;



import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.dal.structure.table.Sys_REST_Function;
import zdg.zframe.engine_interface_rule.After_Action_Service;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.relational_database.Manipulation;
import zdg.zframe.rpc.websocket.session_management.Z_Socket_Session;

/**
 *
 * @author zframe developer 
 */
public class Service_Action_Handler_After_Execute extends After_Action_Service{
    
    
    public static ArrayList<Integer> Service_list = null ;
    
    public  Service_Action_Handler_After_Execute()
    {
        
    }

    @Override
    public boolean After_Service_Execute(boolean Error, Sys_REST_Function Function, String OutputData) {
        
        long Sys_Rest_Function_ID = 0 ;
        Sys_Rest_Function_ID = Function.Sys_REST_Function_ID ;
        
        
        
        if (Service_list == null  || Sys_Rest_Function_ID == 6321  )
        {
            Manipulation DBH = new Manipulation();
            DBH.SystemID= 1;
            DataTable CTable = DBH.executeDataTable("SELECT SYS_REST_FUNCTION_ID FROM NOTIFICATION_SERVICE");
            if (CTable != null )
            {
                Service_list = new ArrayList<>();
                for (int a=0 ; a < CTable.getRowCount() ; a++)
                {
                    Service_list.add(Integer.valueOf(CTable.getDataRow(a).getColumnData(0).toString()));
                    
                }
                
                LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information,"****************** Reload Notification Service  ************************************* ", 100 );
                
            }
            
        }
        
        if ( Service_list != null && Service_list.size() > 0 )
        {
            
            for (int a= 0 ;a  <Service_list.size() ; a++ )
            {
                int Now_Service= Service_list.get(a);
                if (  Now_Service == Function.Sys_REST_Function_ID )
                {
                     //  Send_Notification();
                       break;
                }
            }
           
        }
        
        return true;
         
        
    }
    
    
    public static Object lock = new Object();
    
    public void Send_Notification()
    {
       synchronized (lock)
       {
            Manipulation DBH = new Manipulation();
            DBH.SystemID = 1 ;
            DataTable Ctable = DBH.executeDataTable("SELECT * FROM NOTIFICATION_QUEUE WHERE DELIVERY_STATUS = 0 ");
            for (int a=0; a< Ctable.getRowCount() ; a++)
            {
                
                    String ID = Ctable.getDataRow(a).getColumnData(0).toString();
                    String User_ID = Ctable.getDataRow(a).getColumnData(2).toString();
                    String Message = Ctable.getDataRow(a).getColumnData(3).toString();
                    String Session_id =   "test"; //Session_pointer.get(User_ID);
                   if ( Session_id != null )
                   {
                     boolean Send  = false;
                     int Update_status = 2 ;
                       Z_Socket_Session nowc =  null; //Notification.ZF_NOTIFICATION.User_LIST.get(Session_id);
                     if (nowc != null)
                     {
                        try {
                            nowc.Session.getBasicRemote().sendText(Message);
                             Send = true;
                             Update_status = 3 ;
                        } catch (IOException ex) {
                            Logger.getLogger(Service_Action_Handler_After_Execute.class.getName()).log(Level.SEVERE, null, ex);
                        }
                     }
                     
                     DBH.executeNonQuery(" UPDATE NOTIFICATION_QUEUE  SET  DELIVERY_STATUS =  "+ String.valueOf(Update_status) + "  WHERE NOTIFICATION_QUEUE_ID = "+ ID);
                     
                   }
                
            }
       }
    }

    
    

       
}
