



<%@page import="Z_Framework.Manipulation.Manipulation"%>
<%@page import="Z_Framework.Infrastructure.DataTable"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
  <head >
    <title>MAP</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <link rel="stylesheet" type="text/css" href="leaflet.css" />
    <script src="../ZJBPMS/jquery.min.js" type="text/javascript"></script>   
    <script src="../ZJBPMS/zbpms.js" type="text/javascript"></script>  
    <script type='text/javascript' src='leaflet.js'></script>
  </head>

  <body onload="loadsize()">
      
      
  <script type='text/javascript' >
        
         function loadsize()
         {
               var mappanel = document.getElementById("map"); 
               var HightV = screen.height -200; 
               var HV = "height:" + HightV.toString() + "px"; 
                mappanel.setAttribute("style", HV.toString()); 
         }
          
      </script>

      
    <div id="grouplis">


    </div>
      
    <div id="errorlist">


    </div>
      
            
    <div id="map" style="width: 100%; height:800px; border: 1px solid #AAA;"></div>
    
    <%
        
        
        /*
                String MarkerData  = " // No Data For Show In Map ";
      
                try 
                {
                    Z_Framework.Manipulation.Manipulation DAL = new Manipulation();
                    DAL.SystemID = 1 ;
                    
                    String UserID = request.getSession ().getAttribute ( "User_ID").toString ();                   
                    
                    String BaseQuery = " SELECT DISTINCT V.* FROM VIEW_FLAT_ATMS_STATUS  V " +
                              "     INNER JOIN AC_ATM_GROUPS_ATMS GA ON  V.ATM_ID = GA.ATM_ID " +
                              "     INNER JOIN AC_USERS_ATM_GROUPS UAG ON UAG.ATM_GROUP_ID = GA.ATM_GROUP_ID " +                   
                              "     WHERE UAG.SYS_USER_ID = "+ UserID + " ";
           
                                        
                    DataTable CResult =    DAL.ExecuteDataTable( BaseQuery );
                                        
                     
                      if (CResult != null)
                      {                          
                          if (CResult.getRowCount () > 0)
                                    {
                                
                                    
                                            Z_Framework.Infrastructure.DataConvertor<VIEW_FLAT_ATMS_STATUS> CCONVERTOR = new Z_Framework.Infrastructure.DataConvertor<VIEW_FLAT_ATMS_STATUS>();
                                            ArrayList<VIEW_FLAT_ATMS_STATUS>  AtmStatusList =   CCONVERTOR.Convert(CResult, BusinessRule.Structure.Table.VIEW_FLAT_ATMS_STATUS.class);                                                                                                                                                   
                                              
                                            int SizeList = AtmStatusList.size ();
                            
                                                MarkerData  = "markers = [";
                                                
                                                 for (int a=0 ;a < SizeList ; a++)
                                                 {

                                                       String Name =  "{\"name\": \""+AtmStatusList.get ( a).ATM_NAME+"\",";
                                                       String url =  "\"url\": \"../ZBPMS.bpm?ID=461&KeyID="+ String.valueOf(AtmStatusList.get(a).ATM_ID ) +"\","; // Navigate Page 
                                                       String Stausatm = "\"status\": \""+String.valueOf ( AtmStatusList.get ( a).STATUS) +"\","; // Status
                                                       String lat =  "\"lat\": \""+AtmStatusList.get ( a).LATITUDE+"\",";                                
                                                       String lng =  "\"lng\": \""+AtmStatusList.get ( a).LONGITUDE+"\"}";                          

                                                       MarkerData += Name +  url+ Stausatm+ lat+ lng;
                                                                      if (a < SizeList-1 )
                                                                      {
                                                                          MarkerData+=",";
                                                                      }


                                
                                             }
                            
                                    }
                      
                          MarkerData+="];";    
                      }
                }
                      catch (Exception ex){}

        */
    %>
    
    <script type='text/javascript' >               
        <%                                  
           /*
            try 
            {
                    out.write(MarkerData);
            }
            catch (Exception ex){}
            */
        %>       
            
            <%
                /*
                AC_Business.Business_Information CB = new Business_Information ();
                BusinessRule.Structure.Table.AC_SETTING CSetting = CB.GetSetting ();
                
                if (CSetting != null)
                    {
                    try 
                        {
                     String Timerv= String.valueOf ( (CSetting.MAP_RELOAD_TIME)*(60*1000));    
                        if (Timerv.trim ().length () > 0 ) 
                            {
                                 out.print ( " var myVar = setInterval(myTimer, "+Timerv+");");
                                 out.print ( " function myTimer()");
                                 out.print ( " { ");
                                    out.print ( " location.reload();"); 
                                 out.print ( " }");
                                 
                                 
                            }
                        }
                    catch (Exception ex)
                        {
                        
                        }
                     
                    }
               */
            %>
            
    </script>
    
    <script type='text/javascript' src='maps/leaf-demo.js'></script>
  </body>
</html>
