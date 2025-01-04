<%-- 
    Document   : import
    Created on : Feb 2, 2023, 12:16:30 PM
    Author     : Administrator
--%>

<%@page import="zdg.zframe.aspect.log.LIB_ASPECT.ViewMode"%>
<%@page import="zdg.zframe.aspect.log.LIB_ASPECT"%>
<%@page import="zdg.zframe.context.ZContext"%>
<%@page import="zdg.zframe.relational_database.Manipulation"%>
<%@page import="zdg.zframe.infrastructure.DataConvertor"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Import_Date"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Import_Sheet"%>
<%@page import="zdg.zframe.infrastructure.DataTable"%>
<%@page import="zdg.zframe.presentation_layer.web.ZWebPage"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Accessibility_Level1"%>
<%@page import="zdg.zframe.cache.CoreStruct"%>
<%@page import="zdg.zframe.dal.structure.table.Sys_Object"%>
<%@page import="zdg.zframe.infrastructure.Metadata_DataBase_Handler"%>
<%@page import="zdg.zframe.Dictionary"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.apache.poi.ss.usermodel.Row" %>
<%@page import="org.apache.poi.ss.usermodel.Cell" %>
<%@page import="javax.servlet.http.Part" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Style/Main.css" rel="stylesheet" type="text/css"/> 
        <title>Import Data </title>
        <style>



            body {
                font-family: sans-serif;
                background-color: #eeeeee;
            }

            .file-upload {
                background-color: #ffffff;
                width: 600px;
                margin: 0 auto;
                padding: 20px;
                height: 180px;
            }

            .file-upload-btn {
                width: 100%;
                margin: 0;
                color: #fff;
                background: #1FB264;
                border: none;
                padding: 10px;
                border-radius: 4px;
                border-bottom: 4px solid #15824B;
                transition: all .2s ease;
                outline: none;
                text-transform: uppercase;
                font-weight: 700;
            }

            .file-upload-btn:hover {
                background: #1AA059;
                color: #ffffff;
                transition: all .2s ease;
                cursor: pointer;
            }

            .file-upload-btn:active {
                border: 0;
                transition: all .2s ease;
            }

            .file-upload-content {
                display: none;
                text-align: center;
            }

            .file-upload-input {
                position: absolute;
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100px;
                outline: none;
                opacity: 0;
                cursor: pointer;
            }

            .image-upload-wrap {
                margin-top: 20px;
                border: 4px dashed #1FB264;
                position: relative;
                height: 50px;
            }

            .image-dropping,
            .image-upload-wrap:hover {
                background-color: #1FB264;
                border: 4px dashed #ffffff;
                height: 50px;
            }

            .image-title-wrap {
                padding: 0 15px 15px 15px;
                color: #222;
            }

            .drag-text {
                text-align: center;
            }

            .drag-text h3 {
                font-weight: 100;
                text-transform: uppercase;
                color: #15824B;

            }

            .file-upload-image {
                max-height: 100px;
                max-width: 200px;
                margin: auto;
                padding: 20px;
            }

            .remove-image {
                width: 200px;
                margin: 0;
                color: #fff;
                background: #cd4535;
                border: none;
                padding: 10px;
                border-radius: 4px;
                border-bottom: 4px solid #b02818;
                transition: all .2s ease;
                outline: none;
                text-transform: uppercase;
                font-weight: 700;
            }

            .remove-image:hover {
                background: #c13b2a;
                color: #ffffff;
                transition: all .2s ease;
                cursor: pointer;
            }

            .remove-image:active {
                border: 0;
                transition: all .2s ease;
            }



            .upload-cmd {
                width: 200px;
                margin: 0;
                color: #fff;
                background: #999999;
                border: none;
                padding: 10px;
                border-radius: 4px;
                border-bottom: 4px solid #666666;
                transition: all .2s ease;
                outline: none;
                text-transform: uppercase;
                font-weight: 700;
            }

            .upload-cmd:hover {
                background: #c13b2a;
                color: #ffffff;
                transition: all .2s ease;
                cursor: pointer;
            }

            .upload-cmd:active {
                border: 0;
                transition: all .2s ease;
            }



        </style>

        <script>



            function readURL(input) {
                if (input.files && input.files[0]) {

                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('.image-upload-wrap').hide();

                        $('.file-upload-image').attr('src', e.target.result);
                        $('.file-upload-content').show();

                        $('.image-title').html(input.files[0].name);
                    };

                    reader.readAsDataURL(input.files[0]);

                } else {
                    removeUpload();
                }
            }

            function removeUpload() {
                $('.file-upload-input').replaceWith($('.file-upload-input').clone());
                $('.file-upload-content').hide();
                $('.image-upload-wrap').show();
            }
            $('.image-upload-wrap').bind('dragover', function () {
                $('.image-upload-wrap').addClass('image-dropping');
            });
            $('.image-upload-wrap').bind('dragleave', function () {
                $('.image-upload-wrap').removeClass('image-dropping');
            });


        </script>


    </head>
    <body>
        `
        <form id="frmimport" method="post" enctype="multipart/form-data"  >


            <%

                ArrayList<ArrayList<String>> ErrorList = new ArrayList<ArrayList<String>>();
                ArrayList<ArrayList<String>> UpdateList = new ArrayList<ArrayList<String>>();
                ArrayList<ArrayList<String>> InsertList = new ArrayList<ArrayList<String>>();
                int FormID = 0;
                try {
                    FormID = Integer.valueOf(request.getParameter("id").toString());
                } catch (Exception exx) {
                }

            %>

            <center>

                <a href="DownloadTemplate.xlsx?id=<%out.write(String.valueOf(FormID));%>" target="blank"> Download Template  </a>
            </center>
            <script class="jsbin"  src="ZJBPMS/zfjquery.js"></script>
            <div class="file-upload">
                <button class="file-upload-btn" type="button" onclick="$('.file-upload-input').trigger('click')"> اضافه کردن فایل اکسل </button>

                <div class="image-upload-wrap">
                    <input class="file-upload-input" type='file' name="filedata" id="filedata" onchange="readURL(this);" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" />
                    <div class="drag-text">
                        <h3>Drag and drop Excel File </h3>
                    </div>
                </div>
                <div class="file-upload-content">
                    <img class="file-upload-image" src="#" alt="your data" />
                    <div class="image-title-wrap">
                        <button type="button" onclick="removeUpload()" class="remove-image">Remove <span class="image-title">Uploaded Image</span></button>
                    </div>
                </div>
                <br>
                <input class="upload-cmd" type="submit"  value="ارسال به سرور " id="cmdimport" name="cmdimport"> 
            </div>



            <%

                String keyid = request.getParameter("keyid");

                if (FormID > 0) {

                    boolean Do = true;

                    Metadata_DataBase_Handler CDataProvider = new Metadata_DataBase_Handler();
                    String QueryGetObjectData = "select * from Sys_Import_Date where Sys_Object_ID = @lngID ";
                    ArrayList<Dictionary> Param = new ArrayList<Dictionary>();
                    Param.add(new Dictionary("ID", FormID));
                    Sys_Object NowObject = CoreStruct.getSysObjectWithID(FormID);

                    if (NowObject != null && NowObject.Authentication) {
                        Do = false;
                        try {
                            int MUSERIDFORSECURITYCHECK = Integer.valueOf(request.getSession().getAttribute("USER_ID").toString());

                            Sys_Accessibility_Level1 level1access = CoreStruct.getAccessLevelToForm(new ZWebPage(request, response), NowObject, MUSERIDFORSECURITYCHECK);
                            if (level1access != null) {
                                if (level1access.CanInsert) {
                                    Do = true;
                                }
                            }

                        } catch (Exception exxx) {
                            Do = false;
                        }
                    }

                    if (Do) {

                        DataTable CtableFile = CDataProvider.executeDataTableByDictionery(QueryGetObjectData, Param);
                        if (CtableFile != null) {

                            if ("POST".equalsIgnoreCase(request.getMethod())) {
                                // Show Import Data

                                // btn Upload Click 
                                ArrayList<Sys_Import_Sheet> SheetData = new ArrayList<Sys_Import_Sheet>();
                                if (CtableFile.getRowCount() > 0) {
                                    Sys_Import_Date Sys_import = new Sys_Import_Date();
                                    DataConvertor<Sys_Import_Date> Convert = new DataConvertor<Sys_Import_Date>();
                                    ArrayList<Sys_Import_Date> classimportdata = Convert.convert(CtableFile, Sys_Import_Date.class);
                                    if (classimportdata.size() > 0) {
                                        Sys_import = classimportdata.get(0);
                                        String QuerySheetData = " select * from Sys_Import_Sheet where Sys_Import_Data_ID = @lngID ";
                                        ArrayList<Dictionary> Paramdata = new ArrayList<Dictionary>();
                                        Paramdata.add(new Dictionary("ID", Sys_import.Sys_Import_Data_ID));
                                        DataTable SheetTable = CDataProvider.executeDataTableByDictionery(QuerySheetData, Paramdata);
                                        DataConvertor<Sys_Import_Sheet> ConvertSheet = new DataConvertor<Sys_Import_Sheet>();
                                        SheetData = ConvertSheet.convert(SheetTable,Sys_Import_Sheet.class);
                                    }
                                }

                                try {
                                    Part PartData = request.getPart("filedata");
                                    int lenofbyte = PartData.getInputStream().available();
                                    
                                    InputStream DataFileStream = PartData.getInputStream();
                                    XSSFWorkbook myWorkBook = new XSSFWorkbook(DataFileStream);

                                    Manipulation Dbh = new Manipulation();
                                    Dbh.SystemID = NowObject.Sys_System_ID;
                                    Dbh.WebPage = new ZContext(request, response);

                                    for (int a = 0; a < SheetData.size(); a++) {

                                        XSSFSheet mySheet = myWorkBook.getSheetAt(SheetData.get(a).Sheet_Number - 1);

                                        Iterator<org.apache.poi.ss.usermodel.Row> rowIterator = mySheet.iterator();

                                        StringBuilder RecordData = new StringBuilder();

                                        String[][] Records = new String[1][SheetData.get(a).Column_Count];

                                        int columnNumber = 0;
                                        int Rowsnumber = 0;
                                        ArrayList<Dictionary> SheetColumnToDic = new ArrayList<Dictionary>();
                                        int StartRowForReadData = 0;
                                        if (SheetData.get(a).Active_Header) {
                                            StartRowForReadData = 1;
                                        }

                                        Sys_Import_Sheet nowSheet = new Sys_Import_Sheet();
                                        nowSheet = SheetData.get(a);

                                        String QueryGetColumns = " select Cell_Number, Parameter_Name from Sys_Import_Sheet_Cell where Sys_Import_Sheet_ID = @LNGID order by Cell_Number  ";
                                        ArrayList<Dictionary> ParamdataGetCell = new ArrayList<Dictionary>();
                                        ParamdataGetCell.add(new Dictionary("ID", nowSheet.Sys_import_Sheet_ID));
                                        DataTable Columns = CDataProvider.executeDataTableByDictionery(QueryGetColumns, ParamdataGetCell);

                                        while (rowIterator.hasNext()) {
                                            Row row = (Row) rowIterator.next();
                                            columnNumber = 0;
                                            Rowsnumber++;
                                            SheetColumnToDic = new ArrayList<Dictionary>();
                                            ArrayList<String> nowRec = new ArrayList<String>();

                                            if (Rowsnumber > StartRowForReadData) {
                                                Iterator<Cell> cellIterator = row.cellIterator();

                                               int ColumnsCountValue = Columns.getRowCount();
                                                for (int i = 0; i < ColumnsCountValue; i++) {
                                                    try 
                                                    {
                                                        Cell cell = row.getCell(i);
                                                        nowRec.add(cell.toString());
                                                        String value = cell.toString();
                                                        String ParameterName = Columns.getDataRow(columnNumber).getColumnData(1).toString();
                                                       
                                                        if (value == null)
                                                        {
                                                            value = "";
                                                        }
                                                        
                                                        value = value.replace("\"", "");
                                                        
                                                        try
                                                        {
                                                              double  F  = Double.valueOf(value.trim());
                                                              long ValueCastToLong  =(long)F ;
                                                              SheetColumnToDic.add(new Dictionary(ParameterName, String.valueOf(ValueCastToLong) ));
                                                        }
                                                        catch(Exception  exx)
                                                        {
                                                             SheetColumnToDic.add(new Dictionary(ParameterName, value.trim().replace(".0", "")));
                                                        }
                                                    }
                                                    catch (Exception ex)
                                                    {
                                                        String value = "";
                                                        String ParameterName = Columns.getDataRow(columnNumber).getColumnData(1).toString();
                                                        SheetColumnToDic.add(new Dictionary(ParameterName, value));
                                                    }
                                                    columnNumber++;
                                                }

//                                                while (cellIterator.hasNext()) {
//                                                    Cell cell = cellIterator.next();
//                                                   
//                                                    nowRec.add(cell.toString());
//                                                    String value = cell.toString();
//                                                    String ParameterName = Columns.getDataRow(columnNumber).getColumnData(1).toString();
//                                                    SheetColumnToDic.add(new Dictionary(ParameterName, value.trim().replace(".0", "")));
//                                                    
//                                                    columnNumber++;
//                                                }
                                                SheetColumnToDic.add(new Dictionary("keyid", keyid));
                                                // End Off Read Row 
                                                // Start Processing
                                                StringBuilder DataForSaving = new StringBuilder();
                                                for (int q = 0; q < SheetColumnToDic.size(); q++) {
                                                    DataForSaving.append("[" + SheetColumnToDic.get(q).Name + "," + SheetColumnToDic.get(q).Value + "]");
                                                }
                                                boolean Updated = false;
                                                LIB_ASPECT.zPrintD(ViewMode.Information, DataForSaving.toString(), 100);

                                                if (nowSheet.Can_Update) {
                                                    String QueryCheckExist = nowSheet.CheckExistQuery;
                                                    DataTable CtableExist = Dbh.executeDataTableByDictionery(QueryCheckExist, SheetColumnToDic);
                                                    if (CtableExist != null && CtableExist.getRowCount() > 0) {
                                                        if (Dbh.executeByDictionery(nowSheet.Update_Query, SheetColumnToDic)) {
                                                            Updated = true;
                                                            UpdateList.add(nowRec);
                                                            //ok log 
                                                        } else {
                                                            Updated = true;
                                                            ErrorList.add(nowRec);
                                                            // error log 
                                                        }
                                                    }
                                                }
                                                if (!Updated) {

                                                    DataTable InsertAction_Table = Dbh.executeDataTableByDictionery(nowSheet.Insert_Query, SheetColumnToDic);
                                                    if (InsertAction_Table != null && InsertAction_Table.getRowCount() > 0) {
                                                        String ID = InsertAction_Table.getDataRow(0).getColumnData(0).toString();
                                                        String Message = InsertAction_Table.getDataRow(0).getColumnData(1).toString();
                                                        nowRec.add(Message);
                                                        String RowNumStr = "شماره ردیف" + String.valueOf(Rowsnumber);
                                                        String OpStr = "شماره عملکرد" + String.valueOf(ID);
                                                        nowRec.add(RowNumStr);
                                                        nowRec.add(OpStr);
                                                        if (ID.equals("0")) {
                                                            InsertList.add(nowRec);
                                                        } else {
                                                            ErrorList.add(nowRec);
                                                        }
                                                        // ok Log Insert 
                                                        //
                                                    } else {

                                                        String AddWithNoCode = "جوابی از سرور گرفته نشده ";
                                                        String RowNumStr = "شماره ردیف" + String.valueOf(Rowsnumber);
                                                        nowRec.add(RowNumStr);
                                                        nowRec.add(AddWithNoCode);
                                                        ErrorList.add(nowRec);
                                                    }
                                                }
                                                //End Process

                                            }
                                        }

                                    }

                                } catch (Exception exxx) {
                                    LIB_ASPECT.zPrintD(ViewMode.Error, exxx.getMessage(), 100, exxx);
                                }

                            }
                        }
                    } else {
                        out.write("<br><br><center><span> zframe engine can't find import rule for this form or you need access for import  </span></center>");
                    }

                } else {
                    out.write("<br><br><center><span> zframe engine can't find import rule for this form  </span></center>");
                }
            %>

            <br>
            <br>
            <br>
            <br>
            <center>
                <div style="width: 90%;background-color: #ffffff" >

                    <div><span class="Title"> لیست رکورد های ثبت شده در سیستم  </span></div>
                    <div>
                        <textarea type="Text" id="txtimportinsertdata" name="txtsucess" cols="20" rows="2" class="InputText" >
                    
                            <%
                                for (int a = 0; a < InsertList.size(); a++) {
                                    for (int c = 0; c < InsertList.get(a).size(); c++) {

                                        out.print(InsertList.get(a).get(c).trim() + ",");

                                    }
                                    out.print("\n");
                                }

                            %>
                        </textarea>

                    </div>


                    <div><span class="Title"> لیست رکورد های ویرایش  شده در سیستم  </span></div>
                    <div>

                        <textarea type="Text" id="txtimportupdatedata" name="txtupdate" cols="20" rows="2" class="InputText" >
                    

                            <%     for (int a = 0; a < UpdateList.size(); a++) {
                                    for (int c = 0; c < UpdateList.get(a).size(); c++) {
                                        out.print(UpdateList.get(a).get(c).trim() + ",");
                                    }
                                    out.print("\n");
                                }

                            %>
                        </textarea>

                    </div>



                    <div><span class="Title"> لیست رکورد های خطا دارد در سیستم  </span></div>
                    <div>

                        <textarea type="Text" id="txtimporterror" name="txterror" cols="20" rows="2" class="InputText" >
                            <%                                   for (int a = 0; a < ErrorList.size(); a++) {
                                    for (int c = 0; c < ErrorList.get(a).size(); c++) {

                                        out.print(ErrorList.get(a).get(c).trim() + ",");

                                    }
                                    out.print("\n");
                                }

                            %>
                        </textarea>

                    </div>
                </div>
            </center>
        </form>

    </body>
</html>
