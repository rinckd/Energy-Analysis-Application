<%inherit file="base.mako"/>
<%def name="header()">
    <div id="myDialog" 
         title="Monthly Bill Help" 
         style="display:none">
         To find the ending date, look at the last date in the 'To Date' column on your Con Edison 
         Billing Statement online <br /><br />
         <img src="${request.static_url('energy:static/conedison3.png')}" width=300 height=191 >
     </div>
     <script type="text/javascript">
        jQuery(document).ready( function(){
            jQuery("#myButton").click( showDialog );
            // variable to reference window
            $myWindow = jQuery('#myDialog');
            // instantiate the dialog
            $myWindow.dialog({ height: 300,
                width: 350,
                modal: true,
                position: 'center',
                autoOpen:false,
                title:'Billing Help',
                overlay: { opacity: 0.5, background: 'black' }
              });
        });
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
</%def>

<%def name="content()">
    <form class="cmxform" id="commentForm" method="post" action="results"> 
        <input type="hidden" name="name" value="${params['name']}">
        <input type="hidden" name="group" value="${params['group']}">
        <input type="hidden" name="zip" value="${params['zip']}">
        <input type="hidden" name="sqfoot" value="${params['sqfoot']}">
        <input type="hidden" name="residence" value="${params['residence']}">
        <%
            try:
                stories = int(request.params['stories'])
            except ValueError:
                stories = 0
        %>
        <input type="hidden" name="stories" value="${stories}">
        <input type="hidden" name="electricity" value="${params['electricity']}">
        <input type="hidden" name="date_1" value="${params['date_1']}">
        <input type="hidden" name="date_2" value="${params['date_2']}">
        <input type="hidden" name="month_entries" value="${month_entries}">
        <br />
        <table width=500 align="center" padding="1">
            <tr>
                <td colspan="4"><p>Now, starting from the last billing period, please enter 
                the electricity use figures for each month in the fields below. 
                <br /><br />The Beginning and ending dates are based on typical billing periods. 
                If they do not match your records, please edit the billing dates in the fields below.
                <p style="text-align:right" >
                <input id="myButton" name="myButton" value=">> I need help with this step >>" 
                       class="btn" type="button" /></p></td>
            </tr>
            <script type="text/javascript">
             	    $(function() {           
            	      $('.datepick').each(function(){
                            $(this).datepicker();
                            });
            	      });

            </script>
            <tr>
                <td width= "50">&nbsp;</td>
                <td width= "200" >
                <p style="text-align: center"><b>Billing Period</b></p></td>
                <td width="200"><p style="text-align: center"><b>Electricity Use (Kwh)</b></p></td>
                <td width="50">&nbsp;</td>
            </tr>	
            <%
            from datetime import date, timedelta
            date_range = date_1
            month = int(date_1.month) - 1
            m_count = 0
            for item in range(month_entries):
              m_count += 1
              billing = [31,28,31,30,31,30,31,31,30,31,30,31]
              context.write('<tr><td width="50">&nbsp;</td><td width="200"><label for=cname><b><p>')  
              context.write(str(item + 1))
              context.write('. </b>')
              context.write(date_range.strftime("%B %Y"))
              context.write('</label></p></td>')
              date_range = date_range + timedelta(billing[month])
              context.write('<td width="200"><input name="bill')
              context.write(str(item + 1))
              context.write('" id=bill size=25 class=required minlength=2 />')
              context.write('</td><td width="50">&nbsp;</td></tr>')
              month += 1
              if (month == 12) :
                month = 0
            %>
            <tr>
                <td colspan = "4"><p style="text-align: right">
                <input class="submit" type="submit" value="Submit"/>
                </p></td>
            </tr>
        </table>
    </form>
</%def>
