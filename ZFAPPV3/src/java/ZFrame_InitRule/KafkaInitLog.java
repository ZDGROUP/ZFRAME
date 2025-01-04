package ZFrame_InitRule;




import org.apache.log4j.Logger;
import zdg.zframe.engine_interface_rule.Log_Tracer;
import zdg.zframe.queue.log.Z_Log_Structure;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Administrator
 */
public class KafkaInitLog extends  Log_Tracer{

    public final static Logger LOGGER = Logger.getLogger(IPGLogic.class.getName());
    
    @Override
    public void onGetLog(Z_Log_Structure log)
    {

        String msg=log.Message
                .replace("\u001B[0;","")
                .replace("\u001B[1;","")
                .replace("\n" + "T[","T[");
       
        switch (log.View_Mode){
            case Reset:
            case MetaData:
            case Success:
                LOGGER.trace(msg);
                break;
            case Default:
            case View:
            case Information:
            case Log_File:
                LOGGER.info(msg);
                break;
            case Error:
            case IllegalStateError:
                LOGGER.error(msg);
                break;
            case Warning:
                LOGGER.warn(msg);
                break;

        }
    }

    
    
}