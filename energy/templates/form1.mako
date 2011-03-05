<%inherit file="base.mako"/>
<%def name="header()">
    <!-- These are parameters for form validation -->
    <script>
        $(document).ready(function(){
            $("#commentForm").validate({
                rules: {
                    zip: {
                        required: true,
                    },
                    stories: {
                        required: false,
                        range: [1, 99]
                    },
                    sqfoot: {
                        required: true,
                        digits: true
                    },
                    date_1: {
                        required: true,
                        date: true
                    },
                    date_2: {
                        required: true,
                        date: true
                    }
                }
            });
        });
    </script>
</%def>

<%def name="content()">
    <!-- This divs are for popup help windows -->
    <div id="myDialog" 
         title="Square Footage Help" 
         style="display:none">
         Here are some example sizes of apartment layouts in New York. 
         <br /><br />You may be able to estimate your square footage. 
         <br /><br />Also, ask your parents to look on your lease agreement 
         for an accurate square foot number.<br />
         <img src="${request.static_url('energy:static/apartment_layouts.png')}" width=576 height=296 >
     </div>
     <div id="myDialog2" 
          title="Monthly Bill Help" 
          style="display:none">
          <p style="text-align: left">Look for this section of your Con Edison 
          Billing Statement online. You'll find the starting date here. </p>
          <img src="${request.static_url('energy:static/conedison1.png')}" width=236 height=400 >
      </div>
      <div id="myDialog3" 
           title="Monthly Bill Help" 
           style="display:none">
           To find the ending date, look at the last date in the 'To Date' column 
           on your Con Edison Billing Statement online <br /><br />
           <img src="${request.static_url('energy:static/conedison2.png')}" width=236 height=400 >
       </div>
    <!-- Popup Window 1 -->  
    <script type="text/javascript">
        jQuery(document).ready( function(){
          jQuery("#myButton").click( showDialog );
          // variable to reference window
          $myWindow = jQuery('#myDialog');
          // instantiate the dialog
          $myWindow.dialog({ height: 420,
              width: 620,
              modal: true,
              position: 'center',
              autoOpen:false,
              title:'Square Footage Help',
              overlay: { opacity: 0.5, background: 'black' }
              });
          }
        );
        // function to show dialog
        var showDialog = function() {
          // if the contents have been hidden with css
          $myWindow.show();
          // open the dialog
          $myWindow.dialog("open");
        }
        var closeDialog = function() {
          $myWindow.dialog("close");
        }
    </script>
    <!-- Popup window 2 -->
    <script type="text/javascript">
        jQuery(document).ready( function(){
          jQuery("#myButton2").click( showDialog2 );
          // variable to reference window
          $myWindow2 = jQuery('#myDialog2');
          // instantiate the dialog
          $myWindow2.dialog({ height: 550,
              width: 300,
              modal: true,
              position: 'center',
              autoOpen:false,
              title:'Monthly Bill Help',
              overlay: { opacity: 0.5, background: 'black' }
              });
          }
        );
        // function to show dialog
        var showDialog2 = function() {
          // if the contents have been hidden with css
          $myWindow2.show();
          // open the dialog
          $myWindow2.dialog("open");
        }
        var closeDialog2 = function() {
          $myWindow2.dialog("close");
        }
    </script>
    <!-- Popup Window 3 -->
    <script type="text/javascript">
        jQuery(document).ready( function(){
          jQuery("#myButton3").click( showDialog3 );
          // variable to reference window
          $myWindow3 = jQuery('#myDialog3');
          // instantiate the dialog
          $myWindow3.dialog({ height: 550,
              width: 300,
              modal: true,
              position: 'center',
              autoOpen:false,
              title:'Monthly Bill Help',
              overlay: { opacity: 0.5, background: 'black' }
              });
          }
        );
        // function to show dialog
        var showDialog3 = function() {
          // if the contents have been hidden with css
          $myWindow3.show();
          // open the dialog
          $myWindow3.dialog("open");
        }
        var closeDialog3 = function() {
          $myWindow3.dialog("close");
        }
    </script>
    <form class="cmxform" id="commentForm" method="post" action="form2">
        <table width=600 align="center" padding="1">
            <tr>
                <td width = 200 >
                <label for="name">First Name</label></td>
                <td width = 400>
                <input id="name" name="name" size="25" class="required" 
                       minlength="2" /><em>*</em>
                </td>
            </tr>
            <tr>
                <td>
                <label for="group">Group</label></td>
                <td>
                <select name="group" id="group">
                <%
                for teacher in teachers:
                    context.write('<option value="')
                    context.write(teacher.key().name())
                    if teacher.full_name == 'None':
                        context.write('" selected="selected">')
                    else:
                        context.write('">')
                        context.write(teacher.full_name)
                        context.write('</option>')
                %>
                </select></td>
            </tr>
            <tr>
                <td><label for="czip">ZipCode</label></td>
                <td>
                <input id="zip" name="zip" size="6" class="number" 
                       maxlength="5" minlength="5" />
                <em>*</em></td>
            </tr>
            <tr>
                <td><label for="sqfoot">Square Footage of Residence</label></td>
                <td>
                <input id="sqfoot" name="sqfoot" size="6"  class="number"  />*
                <input id="myButton" name="myButton" 
                       value=">> I need help with this step >>" 
                       class="btn" type="button" /></td>
            </tr>
            <tr>
                <td><label for="residence">Type of Residence</label></td>
                <td>
                <select name="residence" id="residence">
                    <option value="none" selected="selected">Optional</option>
                    <option value="studio">Studio apartment</option>
                    <option value="1bdroom">1 bedroom apartment</option>
                    <option value="2bdroom">2 bedroom apartment</option>
                    <option value="3bdroom">3 bedroom apartment</option>
                    <option value="1bdroomhouse">1 bedroom home</option>
                    <option value="2bdroomhouse">2 bedroom home</option>
                    <option value="duplex">Duplex</option>
                    <option value="other">Other</option>
                </select>
                </td>
            </tr>
                <td>
                <label for="stories">
                How many stories is the building where you reside?</label></td>
                <td>
                <input id="stories" name="stories" size="3"  
                       class="number" value="" /></td>
            </tr>
            <tr>
                <td><label for="electricity">
                Is your home heated by electricity?</label></td>
                <td>
                <select name="electricity" id="electricity">
                    <option value="dontknow" selected="selected">Don't Know</option>
                    <option value="yes">Yes</option>
                    <option value="no">No</option></select></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>      
            <tr>
                <td class="bordered">1st Monthly Statement.</td>
                <td class="bordered">&nbsp;</td>
            </tr>
            <tr>
                <td><label for="cdate">Beginning Date</label></td>
                <td><input type="text" class="datepick" name="date_1" id="date_1" />
                <script type="text/javascript">
             	    $(function() 
             	    {           
            	        $('.datepick').each(function(){
                            $(this).datepicker();
                        });
            	    });
            	</script>
            	<input id="myButton2" name="myButton2" 
            	       value=">> I need help with this step >>" 
            	       class="btn" type="button" />
            	</td>
            </tr>
            <tr>
                <td class="bordered">Last Monthly Statement.</td>
                <td class="bordered">&nbsp;</td>
            </tr>
            <tr>
                <td><label for="cbill">End Date</label></td>
                <td><input type="text" class="datepick" name="date_2" id="date_2" /> 
                    <input id="myButton3" name="myButton3" 
                           value=">> I need help with this step >>"
                           class="btn" type="button" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td><td>     
                <input class="submit" type="submit" value="Submit"/>
                </td>
            </tr>
        </table>
    </form>
    <br />
    <br />
    All data received is anonymized and aggregated to an average energy use 
    within a zip code. No explicit user data will be used outside of this 
    Columbia University research project.
    <br /><br /><br />
</%def>