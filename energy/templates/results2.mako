<%inherit file="base.mako"/>
<%def name="header()">
    <script language="javascript">
        function fmult()
        {
            var first, sec, res;
            first = parseFloat(document.forms[0].txt1st.value);
            mult = parseFloat(document.forms[0].electricity.value);
            mult2 = parseFloat(document.forms[0].electricity2.value);
            mult = mult - mult2
            res = first * 8 * 30 * mult / 1000;
            document.forms[0].txtres.value = res + ' Kwh';
        }
    </script>
</%def>

<%def name="content()">
    <table width=500 align="center" padding="1">
        <form>
            <tr>
                <td width= "250" >
                <p style="text-align: center">
                <b>How many light bulbs do you have?</b></p></td>
                <td width="250"><p style="text-align: center">
                <input name="txt1st" id="txt1st" type="text"></p></td>
            </tr>
            <tr>
                <td width=250><b><p style="text-align: center">
                What type of light bulb do you have?</b></p></td>
                    <td width=250><p style="text-align: center">
                    <select name="electricity" id="electricity">
                        <option value="74" selected="selected">100 Watt incandescent</option>
                        <option value="47">60 Watt incandescent</option></select></td>
            </tr>
            <tr>
                <td width=250><b><p style="text-align: center">
                What type of light bulb do you want to change to?</b></p></td>
                    <td width=250><p style="text-align: center">
                    <select name="electricity2" id="electricity2">
                        <option value='42'>42 Watt Compact Fluorescent</option>
                        <option value='23'>23 Watt Compact Fluorescent</option>
                    </select></td>
            </tr>
            <tr>
                <td width="250">&nbsp;</td>
                <td width=250><p style="text-align: center">
                <input name="btnmul" id="btnmul" type="button" 
                       value="Calculate" onclick="fmult()"></p></td>
            </tr>
            <tr>
                <td colspan=2><p style="text-align: center">
                Assuming you are using the light bulbs 8 hours a day, 
                you could decrease your monthly bill by 
                <input name="txtres" id="txtres" type="text"> 
                if you replaced them with compact fluorescents.
                </td>
            </tr>
            <tr>
                <td colspan = "2">
        </form>
    </td></tr>
    </table>
</%def>





