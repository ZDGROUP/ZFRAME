
package ZFrame_FormRuleCode;

import zdg.zframe.dal.structure.table.Sys_Object_Control;
import zdg.zframe.presentation_layer.interface_rule.BaseCommandRule;




public class frmPerson extends BaseCommandRule
    {
    
        public frmPerson()
            {
                    this.RuleID = 1880;
            }
        
        
        /* Control List */ 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_Person_ID = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_Gender_ID = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_Person_Name = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_Person_Family = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_BDate = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_Address = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_IS_Active = new Sys_Object_Control (); 
                     zdg.zframe.dal.structure.table.Sys_Object_Control Control_NewClientButton = new Sys_Object_Control (); 

        
        public void FillClassData()
            {
               /* Load Control Data From Request Form */ 
                     Control_Person_ID = this.getControlByName ("Person_ID"); 
                     Control_Gender_ID = this.getControlByName ("Gender_ID"); 
                     Control_Person_Name = this.getControlByName ("Person_Name"); 
                     Control_Person_Family = this.getControlByName ("Person_Family"); 
                     Control_BDate = this.getControlByName ("BDate"); 
                     Control_Address = this.getControlByName ("Address"); 
                     Control_IS_Active = this.getControlByName ("IS_Active"); 
                     Control_NewClientButton = this.getControlByName ("NewClientButton"); 

               
            }
            
        @Override
        public void manageAction()
            {
                
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

                    
                    
                    
				      
					   //this.Control_NewClientButton.Control.Value = "ZFrame Application  ";  //Test Code 
				       
					   int c= 1;
                                           int b = 2;
                                           int y = c+b;
						              
						 if (this.senderControl.equals(this.Control_NewClientButton.Control))
						 {
								this.Control_Person_Family.Control.Value = "From JAVA Code ";
						 }

					   
                }

    
    }
