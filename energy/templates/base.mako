<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Energy Form</title>
        <link type="text/css"
              rel="Stylesheet"
        href="${request.static_url('energy:static/jquery/css/smoothness/jquery-ui-1.8.9.custom.css')}" />
        <link type="text/css"
              rel="Stylesheet"
              href="${request.static_url('energy:static/form.css')}" />
        <!-- These scripts do form calendar, validation and UI elements -->
        <script type="text/javascript"
                src="${request.static_url('energy:static/jquery/jquery-1.4.4.js')}">
        </script>
        <script type="text/javascript"
        src="${request.static_url('energy:static/jquery/ui/jquery-ui-1.8.7.custom.js')}">
        </script>	
        <script type="text/javascript"
                src="${request.static_url('energy:static/jquery-validate/jquery.validate.js')}">
        </script>
        <script type="text/javascript"
                src="${request.static_url('energy:static/jquery/ui/ui.core.js')}">
        </script> 
        <script type="text/javascript"
                src="${request.static_url('energy:static/jquery/ui/ui.dialog.js')}">
        </script> 
        <script type="text/javascript" 
                src="assets/js/cmxform.js">
        </script>
        ${self.header()} 
    </head>
  
    <body class="oneColFixCtr">
        <div id="container">
            <div id="mainContent">
                <img src="${request.static_url('energy:static/modi_logo.png')}" 
                     width=474 height=77 border=0>
                <br>
                <h2 class="title">Energy Analysis Form.</h2>
                <br>
                ${self.content()}
            </div>
        </div>
  </body>
</html>
