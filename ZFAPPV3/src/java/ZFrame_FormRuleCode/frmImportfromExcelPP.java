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
import zdg.zframe.configuration.ApplicationInformation;
import zdg.zframe.dal.structure.table.Sys_Object_Control;
import zdg.zframe.infrastructure.DataTable;
import zdg.zframe.presentation_layer.interface_rule.BaseCommandRule;
import zdg.zframe.relational_database.Manipulation;

public class frmImportfromExcelPP extends BaseCommandRule {

    public frmImportfromExcelPP() {
        this.RuleID = 2330;
    }

      /* Control List */ 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_recId = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_TemplateFile = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_FileData = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_cmdimport = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_systemMessageForImport = new Sys_Object_Control (); 

        
        public void FillClassData()
            {
               /* Load Control Data From Request Form */ 
                     Control_recId = this.getControlByName ("recId"); 
                     Control_TemplateFile = this.getControlByName ("TemplateFile"); 
                     Control_FileData = this.getControlByName ("FileData"); 
                     Control_cmdimport = this.getControlByName ("cmdimport"); 
                     Control_systemMessageForImport = this.getControlByName ("systemMessageForImport"); 

               
            }
            

    public void manageAction() {

        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel Init Manage Action ", 1000 );
        FillClassData();

        if (this.CommandType == StandardCommandType.BackCommand) {
            OnBackButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.DeleteCommand) {
            OnDeleteButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.EndCommand) {
            OnEndButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.FindCommand) {
            OnFindButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.FirstCommand) {
            OnFirstCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.NewCommand) {
            OnNewButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.NextCommand) {
            OnNextCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.OtherCommand) {
            OnOtherCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.PrintCommand) {
            OnPrintCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.SaveCommand) {
            OnSaveCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.SearchQuery) {
            OnSearchQueryCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.StartPrint) {
            OnStartPrintCommandButtonClick();
            return;
        } else if (this.CommandType == StandardCommandType.OnLoadPage) {
            PageLoad();
        }

    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    private void PageLoad() {

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
    private void OnBackButtonClick() {

    }

    private void OnDeleteButtonClick() {

    }

    private void OnEndButtonClick() {

    }

    private void OnFindButtonClick() {

    }

    private void OnFirstCommandButtonClick() {

    }

    private void OnNewButtonClick() {

    }

    private void OnNextCommandButtonClick() {

    }

    private void OnPrintCommandButtonClick() {

    }

    private void OnSaveCommandButtonClick() {

    }

    private void OnSearchQueryCommandButtonClick() {

    }

    private void OnStartPrintCommandButtonClick() {

    }

    private void OnOtherCommandButtonClick() {
        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel Step 1", 1000 );

        if (this.senderControl.equals(this.Control_cmdimport.Control)) {
            Insert_New_From_Excle();
        }
    }

    
    
    
  private   String QueryInsert =   " INSERT INTO DBO.PRICE_PROPOSAL_LINE_IMPORT_FROM_EXCEL " +
                                            "  (   " +
                                            "          PRICE_PROPOSAL_ID " +
                                            "        , ROWNUMBER  " +
                                            "        , PRODUCTCODE " +
                                            "        , UNIT  " +
                                            "        , AMOUNT " +
                                            "        , NET_PURCH_PRICE " +
                                            "        , SALE_PRICE " +
                                            "        , NET_SALE_PRICE " +
                                            "        , PRD_PRICE " +
                                            "        , VAT_AMOUNT " +
                                            "        , RETAILER_SHARE_PERCENT " +
                                            "        , DISTRBUTOR_SHARE_PERCENT " +
                                            "        , MARGINE  " +
                                            "        , DISCOUNT_PERCENTAGE_1 " +
                                            "        , DISCOUNT_PERCENTAGE_2 " +
                                            "        , OTHER_DISCOUNT_1 " +
                                            "        , OTHER_DISCOUNT_2 " +
                                            "        , OTHER_DISCOUNT_3 " +
                                            "        , OTHER_DISCOUNT_4 " +
                                            "  )  " +
                                            "   VALUES  " +
                                            "  (  " +
                                            "          @LNGPRICE_PROPOSAL_ID " +
                                            "        , @STRROWNUMBER " +
                                            "        , @STRPRODUCTCODE " +
                                            "        , @STRUNIT " +
                                            "        , @STRAMOUNT " +
                                            "        , @STRNET_PURCH_PRICE " +
                                            "        , @STRSALE_PRICE " +
                                            "        , @STRNET_SALE_PRICE " +
                                            "        , @STRPRD_PRICE " +
                                            "        , @STRVAT_AMOUNT  " +
                                            "        , @STRRETAILER_SHARE_PERCENT " +
                                            "        , @STRDISTRBUTOR_SHARE_PERCENT " +
                                            "        , @STRMARGINE  " +
                                            "        , @STRDISCOUNT_PERCENTAGE_1 " +
                                            "        , @STRDISCOUNT_PERCENTAGE_2 " +
                                            "        , @STROTHER_DISCOUNT_1 " +
                                            "        , @STROTHER_DISCOUNT_2 " +
                                            "        , @STROTHER_DISCOUNT_3 " +
                                            "        , @STROTHER_DISCOUNT_4 " +
                                            "  ) " ;
     
     
    private void Insert_New_From_Excle() {
        
        LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel Step 2", 1000 );
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

            Part PartData = this.FormManager.getWebPartData(this.Control_FileData.Control.Name);

            int lenofbyte = PartData.getInputStream().available();
            
            InputStream DataFileStream =  PartData.getInputStream();
            XSSFWorkbook myWorkBook = new XSSFWorkbook(DataFileStream);
            XSSFSheet mySheet = myWorkBook.getSheetAt(0);
            Iterator<org.apache.poi.ss.usermodel.Row> rowIterator = mySheet.iterator();

            StringBuilder RecordData = new StringBuilder();

            String[][] Records = new String[1][18];
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
                    String ProductCode = Records[0][1];
                    String UNIT = Records[0][2];
                    String Amount = Records[0][3];
                    String NET_PURCH_PRICE = Records[0][4];
                    String SALE_PRICE = Records[0][5];
                    String NET_SALE_PRICE = Records[0][6];
                    String PRD_PRICE = Records[0][7];
                    String VAT_AMOUNT = Records[0][8];
                    String RETAILER_SHARE_PERCENT = Records[0][9];
                    String DISTRBUTOR_SHARE_PERCENT = Records[0][10];
                    String MARGINE = Records[0][11];
                    String DISCOUNT_PERCENTAGE_1 = Records[0][12];
                    String DISCOUNT_PERCENTAGE_2 = Records[0][13];
                    String OTHER_DISCOUNT_1 = Records[0][14];
                    String OTHER_DISCOUNT_2 = Records[0][15];
                    String OTHER_DISCOUNT_3 = Records[0][16];
                    String OTHER_DISCOUNT_4 = Records[0][17];
                    
                    
                    if (ProductCode.trim().length() > 1 )
                    {
                        String PRICE_PROPOSAL_ID = this.FormManager.WebPage.getHttpServletRequest().getParameter("KeyID");
                        ArrayList<zdg.zframe.Dictionary> CParam = new ArrayList<zdg.zframe.Dictionary>();
                        CParam.add(new Dictionary("PRICE_PROPOSAL_ID" ,PRICE_PROPOSAL_ID));
                        CParam.add(new Dictionary("ROWNUMBER" ,RowNumber)); 
                        CParam.add(new Dictionary("PRODUCTCODE" ,ProductCode)); 
                        CParam.add(new Dictionary("UNIT" , UNIT)); 
                        CParam.add(new Dictionary("AMOUNT",Amount)); 
                        CParam.add(new Dictionary("NET_PURCH_PRICE",NET_PURCH_PRICE)); 
                        CParam.add(new Dictionary("SALE_PRICE" ,SALE_PRICE)); 
                        CParam.add(new Dictionary("NET_SALE_PRICE" ,NET_SALE_PRICE)); 
                        CParam.add(new Dictionary("PRD_PRICE" ,PRD_PRICE)); 
                        CParam.add(new Dictionary("VAT_AMOUNT" ,VAT_AMOUNT)); 
                        CParam.add(new Dictionary("RETAILER_SHARE_PERCENT" ,RETAILER_SHARE_PERCENT)); 
                        CParam.add(new Dictionary("DISTRBUTOR_SHARE_PERCENT" ,DISTRBUTOR_SHARE_PERCENT)); 
                        CParam.add(new Dictionary("MARGINE" ,MARGINE)); 
                        CParam.add(new Dictionary("DISCOUNT_PERCENTAGE_1" ,DISCOUNT_PERCENTAGE_1)); 
                        CParam.add(new Dictionary("DISCOUNT_PERCENTAGE_2",DISCOUNT_PERCENTAGE_2)); 
                        CParam.add(new Dictionary("OTHER_DISCOUNT_1" ,OTHER_DISCOUNT_1)); 
                        CParam.add(new Dictionary("OTHER_DISCOUNT_2" ,OTHER_DISCOUNT_2)); 
                        CParam.add(new Dictionary("OTHER_DISCOUNT_3" ,OTHER_DISCOUNT_3)); 
                        CParam.add(new Dictionary("OTHER_DISCOUNT_4" ,OTHER_DISCOUNT_4)); 
                       if ( DBM.executeByDictionery(QueryInsert, CParam))
                       {
                           RecordData.append("Insert Data Into DataBase Success \n");
                           LIB_ASPECT.zPrintD(LIB_ASPECT.ViewMode.Information, "Start Application Import Excel Step 4 ", 1000 );
                       }
                        
                        
                    }
                    
                                           

                    for (int a = 0; a < Records[0].length; a++) {
                        RecordData.append(Records[0][a] + ",");
                    }

                    RecordData.append("\n");

//                             
//                             SP_Command = "EXEC ZDEV_Insert_Commodity_Form_Excel " + Warehouse_ID + ", " + Goods_Code + ", " + Order_point + ", " + Minimum_Balance + ", " + Maximum_Availability + ", " + UserIDV + ", " + FormIDV;            
//                             tbl1 = DBM.ExecuteDataTableWithPureSQL(SP_Command );
//                             h = tbl1.getDataRow(0).getColumnData(0).toString();
                }

            }

            this.Control_systemMessageForImport.Control.Value = RecordData.toString();

        } catch (IOException ex) {
            // 
        }

    }

}
