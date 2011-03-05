<%inherit file="base.mako"/>
<%def name="header()">
</%def>
<%def name="content()">
    <%
    context.write('<img src="http://chart.apis.google.com/chart?&cht=lc&chs=750x330&chxr=1,0,1')
    context.write('&chds=0,1&chg=9,10&chco=4d89f9&chxt=x,y&chxl=0:|')
    context.write(str(chart_month[0]))
    for unit in range(1,len(chart_month)):
      context.write('|')
      context.write(str(chart_month[unit]))
    context.write('&chls=3,2,0|3,3,3|3,3,3&chco=FF0000,00FF00,0000FF&chd=t:')
    context.write(str(chart_useage[0]))
    for unit in range(1,len(chart_useage)):
      context.write(',')
      context.write(str(chart_useage[unit]))
    context.write('|')
    context.write(str(chart_electricity[0]))
    for unit in range(1,len(chart_electricity)):
      context.write(',')
      context.write(str(chart_electricity[unit]))
    context.write('|')
    context.write(str(chart_cooling[0]))
    for unit in range(1,len(chart_cooling)):
      context.write(',')  
      context.write(str(chart_cooling[unit]))
    context.write('">')
    %>
    <br clear =all />
    <%
    weighted = ((average - ny_average)/20)+50
    if weighted < 0:
        weighted = 0
    if weighted > 100:
        weighted = 100
    %>
    <img src="${request.static_url('energy:static/legend.png')}" 
         width=288 height=59 border=0 align="left">
    <br clear=all />
    Your average monthly consumption is :<b> ${average} kilowatt hours.</b><br>
    The average monthly consumption in New York for your building type is: 
    <b>${ny_average} kilowatt hours.</b><br>
    <br><br>
    The chart above shows your electricity use per square foot compared with 
    the average in New York. The red line shows your electricity usage. 
    Green line shows electrical usage without cooling. The blue line shows 
    total electricity use including cooling.
    <br clear=all /><br>
    <p style="text-align: center; color:red;">&gt; &gt; 
    <a href="${request.application_url}/results2?&average=${average}&ny_average=${ny_average}">
        See how you could reduce your energy use</a> &gt; &gt;</p>
    <br><br>
</%def>