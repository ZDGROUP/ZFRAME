package ZFrame_FormRuleCode;


import java.io.IOException;
import java.util.Iterator;
import javax.servlet.http.Part;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


import zdg.zframe.Dictionary;
import java.io.InputStream;
import java.util.ArrayList;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.aspect.log.LIB_ASPECT.ViewMode;
import zdg.zframe.configuration.ApplicationInformation;
import zdg.zframe.dal.structure.table.Sys_Object_Control;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.presentation_layer.interface_rule.BaseCommandRule;
import zdg.zframe.relational_database.Manipulation;


public class frmImportFromExcelTO extends BaseCommandRule
    {
    
    
    
        public frmImportFromExcelTO()
            {
                    this.RuleID = 2331;
            }
        
        
        /* Control List */ 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_RecID = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_TemplateFile = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_FileData = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_cmdimport = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_systemMessageForImport = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_PRODUCTCODE = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_ROWNUMBER = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_AddToPP = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_DeleteFromPP = new Sys_Object_Control (); 
                  zdg.zframe.dal.structure.table.Sys_Object_Control Control_IMPORTMessage = new Sys_Object_Control (); 

        
        public void FillClassData()
            {
               /* Load Control Data From Request Form */ 
                     Control_RecID = this.getControlByName ("RecID"); 
                     Control_TemplateFile = this.getControlByName ("TemplateFile"); 
                     Control_FileData = this.getControlByName ("FileData"); 
                     Control_cmdimport = this.getControlByName ("cmdimport"); 
                     Control_systemMessageForImport = this.getControlByName ("systemMessageForImport"); 
                     Control_PRODUCTCODE = this.getControlByName ("PRODUCTCODE"); 
                     Control_ROWNUMBER = this.getControlByName ("ROWNUMBER"); 
                     Control_AddToPP = this.getControlByName ("AddToPP"); 
                     Control_DeleteFromPP = this.getControlByName ("DeleteFromPP"); 
                     Control_IMPORTMessage = this.getControlByName ("IMPORTMessage"); 

               
            }
            
        public void manageAction()
            {
                  LIB_ASPECT.zPrintD(ViewMode.Information, "Start Application Import Excel Init Manage Action ", 1000 );
            FillClassData ();
            
                if (this.CommandType == StandardCommandType.BackCommand)
                    {
                           OnBackButtonClick ();
                           return;
                    }
                else if (this.CommandType == StandardCommandType.DeleteCommand)
                    {
                        OnDeleteButtonClick();
                        return;
                    }
                else if (this.CommandType == StandardCommandType.EndCommand)
                    {
                        OnEndButtonClick();
                        return;
                    }
                else if (this.CommandType == StandardCommandType.FindCommand)
                    {
                        OnFindButtonClick();
                        return;
                    }
                 else if (this.CommandType == StandardCommandType.FirstCommand)
                    {
                        OnFirstCommandButtonClick();                        
                        return;
                    }
                 else if (this.CommandType == StandardCommandType.NewCommand)
                    {
                        OnNewButtonClick();                        
                        return;
                    }
                 else if (this.CommandType == StandardCommandType.NextCommand)
                    {
                        OnNextCommandButtonClick();                        
                        return;
                    }
                else if (this.CommandType == StandardCommandType.OtherCommand)
                    {
                        OnOtherCommandButtonClick();                        
                        return;
                    }
                else if (this.CommandType == StandardCommandType.PrintCommand)
                    {
                        OnPrintCommandButtonClick();                        
                        return;
                    }
                else if (this.CommandType == StandardCommandType.SaveCommand)
                    {
                        OnSaveCommandButtonClick();                        
                        return;
                    }
                 else if (this.CommandType == StandardCommandType.SearchQuery)
                    {
                        OnSearchQueryCommandButtonClick();                        
                        return;
                    }
                else if (this.CommandType == StandardCommandType.StartPrint)
                    {
                        OnStartPrintCommandButtonClick();                        
                        return;
                    }
		      else if (this.CommandType == StandardCommandType.OnLoadPage)
                    {
                        PageLoad ();
                    }
                                
            }

			/////////////////////////////////////////////////////////////////////////////////////////////////////////

			private void PageLoad()
			{

			  /*
			      if (this.FormManager.WebPage.Ispostback)
				  {
				  
				  }
				  else
				  {
				  
				  
				  }			
               */ 
			}

			//////////////////////////////////////////////////////////////////////////////////////////////////////////
			    
            private void OnBackButtonClick()
                    {

                    }

            private void OnDeleteButtonClick ()
                {

                }

            private void OnEndButtonClick ()
                {

                }

            private void OnFindButtonClick ()
                {

                }

            private void OnFirstCommandButtonClick ()
                {

                }

            private void OnNewButtonClick ()
                {

                }

            private void OnNextCommandButtonClick ()
                {

                }


            private void OnPrintCommandButtonClick ()
                {

                }

            private void OnSaveCommandButtonClick ()
                {

                }

            private void OnSearchQueryCommandButtonClick ()
                {

                }

            private void OnStartPrintCommandButtonClick ()
                {

                }

				
            private void OnOtherCommandButtonClick ()
                {

	    LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel TO Step 1", 1000 );
            if (this.senderControl.equals(this.Control_cmdimport.Control)) 
            {
            Insert_New_From_Excle();
             }	      
					 
                }

            
            private String QueryInsert="INSERT INTO dbo.TRANSFER_ORDER_IMPORT_FROM_EXCEL\n" +
                            "           (TRANSFER_ORDER_ID\n" +
                            "           ,ROWNUMBER\n" +
                            "           ,ORIGIN_LOCATION\n" +
                            "           ,DESTINATION_LOCATION\n" +
                            "           ,DELIVERY_DATE\n" +
                            "           ,PRODUCT_CODE\n" +
                            "           ,QUANTITY\n" +
                            "           ,ORDER_DATE)\n" +
                            "     VALUES\n" +
                            "           (@LNGTRANSFER_ORDER_ID\n" +
                            "           ,@STRROWNUMBER\n" +
                            "           ,@STRORIGIN_LOCATION\n" +
                            "           ,@STRDESTINATION_LOCATION\n" +
                            "           ,@STRDELIVERY_DATE\n" +
                            "           ,@STRPRODUCT_CODE\n" +
                            "           ,@STRQUANTITY\n" +
                            "           ,@STRORDER_DATE) ";
            

    private void Insert_New_From_Excle() 
    {
        
        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel TO Step 2", 1000 );
        int Warehouse_ID = 0;
        String Goods_Code = null;
        int Order_point = 0;
        int Minimum_Balance = 0;
        int Maximum_Availability = 0;
        
        
       try {

            String FormIDV = String.valueOf(this.FormManager.Sys_Object.Sys_Object_ID);
            String UserIDV = this.FormManager.WebPage.getHttpServletRequest().getSession().getAttribute("User_ID").toString();

            String SP_Command;

            zdg.zframe.relational_database.Manipulation DBM = new Manipulation();
            DBM.SystemID = Integer.valueOf(ApplicationInformation.System_ID);

            DataTable tbl1;
            String h;

            Part PartData = this.FormManager.getWebPartData(this.Control_TemplateFile.Control.Name);

            int lenofbyte = PartData.getInputStream().available();
            
            InputStream DataFileStream =  PartData.getInputStream();
            XSSFWorkbook myWorkBook = new XSSFWorkbook(DataFileStream);
            XSSFSheet mySheet = myWorkBook.getSheetAt(0);
            Iterator<org.apache.poi.ss.usermodel.Row> rowIterator = mySheet.iterator();

            StringBuilder RecordData = new StringBuilder();

            String[][] Records = new String[1][9];
            int columnNumber = 0;
            int Rowsnumber = 0;
            while (rowIterator.hasNext()) {
                Row row = (Row) rowIterator.next();
                columnNumber = 0;
                Rowsnumber++;
                if (Rowsnumber > 1) {
                    Iterator<Cell> cellIterator = row.cellIterator();
                    while (cellIterator.hasNext()) {
                        Cell cell = cellIterator.next();
                        Records[0][columnNumber] = cell.toString();
                        String Show = Records[0][columnNumber].toString();

                        columnNumber++;
                    }

                    String RowNumber = Records[0][0];
                    String SourceLocation = Records[0][1];
                    String DestinationLocation = Records[0][2];                   
                    String DeliveryDate = Records[0][3];
                    String ProductCode = Records[0][4];
                    String Quantity = Records[0][5];
                    String OrderDate = Records[0][6];

                    if (ProductCode.trim().length() > 1 )
                    {
                        String TRANSFER_ORDER_ID = this.FormManager.WebPage.getHttpServletRequest().getParameter("KeyID");
                        ArrayList<zdg.zframe.Dictionary> CParam = new ArrayList<zdg.zframe.Dictionary>();
                        
                        CParam.add(new Dictionary("TRANSFER_ORDER_ID" ,TRANSFER_ORDER_ID));
                        CParam.add(new Dictionary("ROWNUMBER" ,RowNumber)); 
                        CParam.add(new Dictionary("PRODUCTCODE" ,ProductCode)); 
                        CParam.add(new Dictionary("ORIGIN_LOCATION" , SourceLocation)); 
                        CParam.add(new Dictionary("DESTINATION_LOCATION",DestinationLocation)); 
                        CParam.add(new Dictionary("DELIVERY_DATE",DeliveryDate)); 
                        CParam.add(new Dictionary("QUANTITY" ,Quantity)); 
                        CParam.add(new Dictionary("ORDER_DATE" ,OrderDate)); 
                       
                       if ( DBM.executeByDictionery(QueryInsert, CParam))
                       {
                           RecordData.append("Insert Data Into DataBase Success \n");
                           LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel TO Step 4 ", 1000 );
                       }
                        
                        
                    }
                    
                                           

                    for (int a = 0; a < Records[0].length; a++) 
                    {
                        RecordData.append(Records[0][a] + ",");
                    }

                    RecordData.append("\n");


                }

            }

            this.Control_systemMessageForImport.Control.Value = RecordData.toString();

        } catch (IOException ex) {
            // 
        }
        
    }

    
    }

