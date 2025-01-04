<%-- 
    Document   : CassetteBankNotesOnline
    Created on : Jan 14, 2018, 1:23:33 PM
    Author     : Administrator
--%>

<%@page import="Z_Framework.Manipulation.Manipulation"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Z_Framework.Infrastructure.DataTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>   وضعیت مخازن  </title>
        <script src="../ReportChart/dist/Chart.bundle.js"></script>
        <script src="../ReportChart/dist/utils.js"></script>
        <link href="../Style/Main.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        
        
     <%
     
     Z_Framework.Manipulation.Manipulation DB = new Manipulation();
     DB.SystemID= 1;
     
     DataTable CTableResult= DB.ExecuteDataTable(" select TS.FTYPE, TS.Product_Volume , TS.Product_Level , Ts.Water_Volume , Ts.Water_Level , Ts.Temperature  from  [dbo].[View_flat_Tank_status] TS ");
                                                          
     
     boolean ExistVal = false;
        if (CTableResult != null)
        {
            if (CTableResult.getRowCount() > 0 )
            {
                ExistVal = true;
            }
        }
     
    
    %>
    

        
 <div style="width:100%;align-items:center;">
            <center>
                <table cellspacing="0" style="width:100%">
                    <tr style="background-color: #ece9ff">
                        
                        <td style="width:50% " >
                            
                            <%
                                if (ExistVal)
                                {
                                    out.print("<Table cellspacing=\"0\"  class=\"ZFormTable\" style=\"width:100%;\" dir=\"rtl\" >");
                                    
                                    
                                    out.print("<Tr>");
                                           out.print("<Td Class=\"HeaderFrom\"  align=\"Center\"> <span class=\"Title\" >");
                                                        out.print("مخزن");
                                            out.print("</span></Td>");
                                            out.print("<Td Class=\"HeaderFrom\" align=\"Center\"> <span class=\"Title\" >");
                                                        out.print("حجم سوخت ");
                                            out.print("</span></Td>");
                                            out.print("<Td Class=\"HeaderFrom\" align=\"Center\"> <span class=\"Title\" >");
                                                        out.print("سطح سوخت ");
                                            out.print("</span></Td>");
                                            
                                            out.print("<Td Class=\"HeaderFrom\" align=\"Center\"> <span class=\"Title\" >");
                                                        out.print("حجم آب ");
                                            out.print("</span></Td>");
                                            out.print("<Td Class=\"HeaderFrom\" align=\"Center\"> <span class=\"Title\" >");
                                                        out.print("سطح آب ");
                                            out.print("</span></Td>");
                                            out.print("<Td Class=\"HeaderFrom\" align=\"Center\"> <span class=\"Title\" >");
                                                        out.print("دما ");
                                            out.print("</span></Td>");
                                            
                                            
                                        out.print("</Tr>");
                                    
                                    for (int a=0 ; a < CTableResult.getRowCount(); a++)
                                    {
                                        out.print("<Tr>");
                                           out.print("<Td align=\"Center\"> <span class=\"Title\" >");
                                                        
                                           
                                            
                                            DecimalFormat formatter = new  DecimalFormat("###,###");                                            
                                            out.print(CTableResult.getDataRow(a).getColumnData(0).toString());
                                                         
                                            out.print("</span></Td>");
                                            out.print("<Td align=\"Center\"> <span class=\"Title\" >");
                                             long V1 = Long.valueOf(  CTableResult.getDataRow(a).getColumnData(1).toString());                                                        
                                             String NuStr2 = formatter.format(V1);                                                         
                                             out.print(NuStr2);
                                            out.print("</span></Td>");
                                            
                                            out.print("<Td align=\"Center\"> <span class=\"Title\" >");                                                                                          
                                             out.print(CTableResult.getDataRow(a).getColumnData(2).toString());
                                            out.print("</span></Td>");
                                            out.print("<Td align=\"Center\"> <span class=\"Title\" >");                                                                                          
                                             out.print(CTableResult.getDataRow(a).getColumnData(3).toString());
                                            out.print("</span></Td>");
                                            out.print("<Td align=\"Center\"> <span class=\"Title\" >");                                                                                          
                                             out.print(CTableResult.getDataRow(a).getColumnData(4).toString());
                                            out.print("</span></Td>");
                                            out.print("<Td align=\"Center\"> <span class=\"Title\" >");                                                                                          
                                             out.print(CTableResult.getDataRow(a).getColumnData(5).toString());
                                            out.print("</span></Td>");
                                            
                                        out.print("</Tr>");
                                    }
                                    
                                    out.print("</Table>");
                                }
                          %>
                            
                        </td>
                        
                        <td style="width:50%;height:300px;" align="Center">
                            <div>
                                <span class="Title" >                
                                    میزان سوخت به تفکیک مخزن
                                </span>
                            </div>    

                            <div id="canvas-holder" style="width:80%">
                                 <canvas id="chart-area1" />                              
                            </div>
                        </td>
                        
                    </tr>
                   
                </table>
        </center>
</div>
      <script>
    
    
    
    var config1 = {
        type: 'pie',
        data: {
            datasets: [{
                data: [
                    <%
                      if (ExistVal)
                      {
                          for (int a=0 ; a < CTableResult.getRowCount(); a++)
                          {
                              out.print( "'"+ CTableResult.getDataRow(a).getColumnData(1).toString()+"',");
                          }
                      }
                    %>
                ],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow,
                    window.chartColors.green, 
                    window.chartColors.grey,
                ],
                label: 'Dataset 1'
            }],
            labels: [
                 <%
                      if (ExistVal)
                      {
                          for (int a=0 ; a < CTableResult.getRowCount(); a++)
                          {
                              out.print("'"+ CTableResult.getDataRow(a).getColumnData(0).toString()+" مخزن  ',");
                          }
                      }
                    %>
            ]
        },
        options: {
            responsive: true
        }
    };
    
    
     var config2 = {
        type: 'pie',
        data: {
            datasets: [{
                data: [
                    <%
                      if (ExistVal)
                      {
                          for (int a=0 ; a < CTableResult.getRowCount(); a++)
                          {
                              long V = Long.valueOf(CTableResult.getDataRow(a).getColumnData(1).toString()) ;
                                      
                              out.print( "'"+ String.valueOf(V)+"',");
                          }
                      }
                    %>
                ],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow,
                    window.chartColors.green, 
                    window.chartColors.grey,
                ],
                label: 'Dataset 1'
            }],
            labels: [
                 <%
                      if (ExistVal)
                      {
                          for (int a=0 ; a < CTableResult.getRowCount(); a++)
                          {
                              out.print("'"+ CTableResult.getDataRow(a).getColumnData(0).toString()+" مخزن  ',");
                          }
                      }
                    %>
            ]
        },
        options: {
            responsive: true
        }
    };

    window.onload = function() {
        var ctx1 = document.getElementById("chart-area1").getContext("2d");
        //var ctx2 = document.getElementById("chart-area2").getContext("2d");
        window.myPie1 = new Chart(ctx1, config1);
        //window.myPie2 = new Chart(ctx2, config2);
    };

    document.getElementById('randomizeData').addEventListener('click', function() {
        config.data.datasets.forEach(function(dataset) {
            dataset.data = dataset.data.map(function() {
                return randomScalingFactor();
            });
        });

        window.myPie1.update();
       // window.myPie2.update();
    });

    var colorNames = Object.keys(window.chartColors);
    document.getElementById('addDataset').addEventListener('click', function() {
        var newDataset = {
            backgroundColor: [],
            data: [],
            label: 'New dataset ' + config.data.datasets.length,
        };

        for (var index = 0; index < config.data.labels.length; ++index) {
            newDataset.data.push(randomScalingFactor());

            var colorName = colorNames[index % colorNames.length];;
            var newColor = window.chartColors[colorName];
            newDataset.backgroundColor.push(newColor);
        }

        config.data.datasets.push(newDataset);
        window.myPie1.update();
        window.myPie2.update();
    });

    
    
     <%
                
                
                    try 
                        {
                     String Timerv= "1000";
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
                     
                    
              
            %>
    
    </script>
        
        
    </body>
</html>
