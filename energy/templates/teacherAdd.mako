<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Energy Form</title>
    <link type="text/css"
           rel="Stylesheet"
           href="${request.static_url('energy:static/form.css')}" />
</head>
    <body class="oneColFixCtr">
        <div id="container">
        <div id="mainContent">
            <img src="${request.static_url('energy:static/modi_logo.png')}" width=474 height=77 border=0>
            <h2 class="title">Energy Analysis Form</h2><br >
            <form class="cmxform" id="commentForm" method="post" action="teacheradd2">
                <label for="name">Name</label>
                <input id="name" name="name" size="25" class="required" minlength="2" />
                <br /><br /><br />
                <input class="submit" type="submit" value="Submit"/>
            </form>
        </div></div>
    </body>
</html>