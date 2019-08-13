<%-- 
    Document   : Product_Quotation
    Created on : Jun 12, 2019, 10:04:08 AM
    Author     : pakasit
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"><!--
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        -->        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script><!--
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        
        -->        <link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300|Roboto" rel="stylesheet"><!--
        
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        -->        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous"><!--
        -->        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"><!--
        -->        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma"><!--
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>-->

        <%-- Dropdown --%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <link href="css/style5.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        <script src="js/main.js" type="text/javascript"></script>


        <title>Product Quotation</title>

        <style>
            .image {

                padding: 30px;
                float: left;
            }
            .artigo_nome {
                border: 1px dotted blue;
                text-align: center;
                display: inline-block;
                max-width: 250px;
                padding: 10px;
                word-break: break-all; /* optional */
            }
            .artigo_nome1 {
                display: inline-block;
                word-break: break-all; /* optional */
            }
            .insert{
                height: auto;
                width: 100%;
                border: 1px solid;
                border-color: #5a5255;
                border-left: none;
                border-bottom: none;
                border-top: none;
                border-right: none;
                text-align: center;
            }
            .sidebar{
                width: 15%;
                height: 100%;
                /*    border: 1px solid lightgray;*/
                position: fixed;
                border: 1px solid;
                border-color: #5a5255;
                border-top: none;
                float: left;
            }

            .webname{
                font-size: 22px;
                font-weight: bold;
                float:left;
                text-align: center;
                /*    background-color: greenyellow;*/
                display:inline;
                width: 100%;
                height:54px;
                position: absolute;


            }
            .stylepic{
                width: 55px; height: 54px;

            }
            .styleloginname{
                /*    background-color: red;*/
                height:54px;
                width: 200px;
                text-align: center;
                padding-top: 20px;
                position: absolute;
                right: 0;
            }
            .mainpage{
                margin-left: 15%;
                width: 85%;
                text-align: left;
                border: 1px solid; 
                border-color: #5a5255;
                border-left: none;
                border-bottom: none;
                border-top: none;
                border-right: none;
            }
            #myTable {
                text-align: center; 
                border-collapse: collapse;
                width: 90%;
                margin-left: 30px;
                border: 1px solid #ddd;
                font-size: 18px;

            }
            .fullmain{
                width: 100%;max-width: 100%; height: 650px; min-height: 100%; margin: 57px auto auto auto;
            }
            table{
                width: 40%;
            }
            th,td{
                padding :5px;
            }
            .dataTables_length{
                margin-left: 30px;
                margin-top: 10px;
                float: left;
            }
            .dataTables_paginate{
                margin-right: 80px
            }
            .dataTables_info{
                margin-left: 30px;                
            }


            @media screen and (max-width: 650px) {
                .sidebar {
                    display: none;
                }
                .styleloginname{
                    display: none;
                }
                .webname{
                    text-align: left;
                    width: 100%;
                    position: absolute;
                }
                .mainpage{
                    width: 100%;
                    margin: 0;
                    padding: 0;
                }
                .fullmain{
                    padding: 0;
                }
                table{
                    width: 100%;
                }
                th,td{
                    padding :5px;
                }
            }



        </style>
        <script>
            function addCommas(nStr)
            {
                nStr += '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                return x1 + x2;
            }

            function chkNum(ele) {
//                                var num = parseFloat(ele.value);
//                                ele.value = addCommas(num.toFixed(2));
                var num = parseFloat(ele.value.replace(/,/g, ''));
                if (isNaN(num)) {
                    ele.value = "0.00";
                } else {
                    ele.value = addCommas(num.toFixed(2));
                }
            }
        </script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- นำเข้า  CSS จาก Bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

        <!-- นำเข้า  CSS จาก dataTables -->
        <link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.12/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.3.0/css/select.dataTables.min.css">
        
        <!-- นำเข้า  Javascript จาก  Jquery -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <!-- นำเข้า  Javascript  จาก   dataTables -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/select/1.3.0/js/dataTables.select.min.js"></script>
        
        
<!--        <link type="text/css" href="//gyrocode.github.io/jquery-datatables-checkboxes/1.2.11/css/dataTables.checkboxes.css" rel="stylesheet" />
        <script type="text/javascript" src="//gyrocode.github.io/jquery-datatables-checkboxes/1.2.11/js/dataTables.checkboxes.min.js"></script>-->

        <script type="text/javascript">

            $(document).ready(function () {

                var table = $('#myTable').DataTable({
//                    "dom": 'ltipr',
                    "dom": '<"top"i>rt<"bottom"lp><"clear">',
                    "lengthMenu": [[5, 10, 20, 50, -1], [5, 10, 20, 50, "All"]],
                    "pagingType": "full_numbers",
                    select: {
                        select:true,
                        style: 'multi'
                    },
                    "language": {
                        "lengthMenu": 'Display <select>' +
                                '<option value="5">5</option>' +
                                '<option value="10">10</option>' +
                                '<option value="20">20</option>' +
                                '<option value="50">50</option>' +
                                '<option value="-1">All</option>' +
                                '</select> records',
                        "info": "Showing _START_ to _END_ of _TOTAL_ records"
                    },
                    'columnDefs': [
                        {
                           targets: 0,
                           data: null,
                           className: 'select-checkbox',
                           defaultContent: '',
                           checkboxes: {
                                selectRow: true,
                                selectAll:false
                             }
                        }
                     ],
                     'order': [[1, 'asc']]
                    
                }); 
                
                $('#myTable tbody').on( 'click', 'tr', function () {
                    $(this).toggleClass('selected');
                } );

                $('#buttontable').click( function () {
                    var rowdata = table.rows('.selected').data();     
                    var msg = '';
                    var countforif = parseInt(rowdata.length -1);
                     for (var i = 0; i < rowdata.length; i++) {
                       if(rowdata.length===1){
                           msg += rowdata[i][1];
                       }else{
                           if(i === countforif){
                                msg += rowdata[i][1];   
                           }else{
                                msg += rowdata[i][1]+",";
                           }
                       }
                       
                   }
                    alert(msg);
                    window.location.href = "Insert_Product_Quotation.jsp?selectPro=" + msg;
               } );
               
            });

        </script>
    </head>


    <body>
        <%
            String User = String.valueOf(session.getAttribute("User"));

            if (session.getAttribute("User") == null) {
        %>
        <meta http-equiv= refresh content= 1;URL=Login.jsp>
        <%
        } else {
        %>

        <nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px" id="mySidebar">
            <a href="javascript:void(0)" onclick="w3_close()"
               class="w3-bar-item w3-button">Close Menu</a>
            <a class="w3-bar-item" style="font-size: 22px; font-weight: bold;">Sales Management</a>
            <ui>
                <li style=" list-style-type: none;"><a  class=" w3-button" href="Quotation.jsp" style="margin-left: 30px">Quotation</a></li>
                <li style=" list-style-type: none;"><a  class=" w3-button" href="#" style="margin-left: 30px">Sales Order</a></li>   
                <li style=" list-style-type: none;"><a  class=" w3-button" href="#" style="margin-left: 30px">Delivery</a></li>
                <li style=" list-style-type: none;"><a  class=" w3-button" href="#" style="margin-left: 30px">Invoice</a></li> 
                <li style=" list-style-type: none;"><a  class=" w3-button" href="#" style="margin-left: 30px">Accounts Receivables</a></li>


            </ui>
            <a class="w3-bar-item" style="font-size: 22px; font-weight: bold;">Master Maintenance</a>
            <ui>
                <li style=" list-style-type: none;"><a  class=" w3-button" href="Customer_Master.jsp" style="margin-left: 30px">Customer Master</a></li>
                <li style=" list-style-type: none;"><a class=" w3-button" href="Product_Master.jsp" style="margin-left: 30px">Product Master</a></li>   

            </ui>
        </nav>
        <div class=" w3-top" style="max-width: 100%; width: 100%; ">
            <div class="navbars">
                <span class="w3-button w3-padding-16 w3-left" onclick="w3_open()" style=" margin: auto">☰</span>
                <span class="stylepic"><img src="image/jpsLogo.png" class="stylepic"></span>
                <span class="webname">ERP for Manufacturing</span>        
                <span class="styleloginname">
                    <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                        <%
                            out.print(User);
                        %> </a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li><a href="#" class="dropdown-item" onclick="open_Account()">My Account</a></li>
                        <li><a href="RemoveS.jsp" class="dropdown-item" onclick="logout()">Logout</a></li>    
                    </ul>
                </span>


            </div>
        </div>

        <div class="fullmain">
            <div class="sidebar">
                <button class="w3-button w3-block w3-left-align " onclick="mydrop1()"><b>Sales Management</b> <span class="fa fa-chevron-down" ></span></button>
                <div id="drop1" class="w3-bar-block w3-hide w3-white w3-card-4">
                    <a href="Quotation.jsp" class="w3-bar-item w3-button">Quotation</a>
                    <a href="Sales Order.jsp" class="w3-bar-item w3-button">Sales Order</a>
                    <a href="Delivery.jsp" class="w3-bar-item w3-button">Delivery</a>
                    <a href="Invoice.jsp" class="w3-bar-item w3-button">Invoice</a>
                    <a href="Accounts Receivables.jsp" class="w3-bar-item w3-button">Accounts Receivables</a>
                </div>
                <button class="w3-button w3-block w3-left-align" onclick="mydrop2()"><b>Master Maintenance</b> <span class="fa fa-chevron-down" aria-hidden="true"></span></button>
                <div id="drop2" class="w3-bar-block w3-hide w3-white w3-card-4">
                    <a href="Customer_Master.jsp" class="w3-bar-item w3-button">Customer Master</a>
                    <a href="Product_Master.jsp" class="w3-bar-item w3-button">Product Master</a>
                </div>
            </div>

            <div class="mainpage">
                <h2 style=" text-align: left ;padding-left: 5px">Select Product</h2>
                <%
                    String driverName = "com.mysql.jdbc.Driver";
                    String connectionUrl = "jdbc:mysql://localhost:3306/";
                    String dbName = "erp1";
                    String userId = "root";
                    String password = "1234";

                    try {
                        Class.forName(driverName);
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    }

                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;
                    
                    Statement statementCus = null;
                    ResultSet resultCus = null;

                    Statement statementCur = null;
                    ResultSet resultCur = null;
                %>
                <%
                    try {
                        connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);
                        
                        statementCus = connection.createStatement();
                        statementCur = connection.createStatement();

                        String sqlcus = "SELECT * FROM customer";
                        String sqlcur = "SELECT * FROM currency";

                        resultCus = statementCus.executeQuery(sqlcus);
                        resultCur = statementCur.executeQuery(sqlcur);
                        
                        statement = connection.createStatement();
                        String sql = "SELECT * FROM product where FLG2 = 0";

                        resultSet = statement.executeQuery(sql);
                %>
                <table class="table table-hover" id="myTable">
                    <thead>
                        <tr>
                            <th></th>
                            <th style="text-align: center;">Item No</th>
                            <th style="text-align: center;">Item Name EN</th>
                            <th style="text-align: center;">Item Name TH</th>
                            <th style="text-align: center;">Std Price</th>
                            <th style="text-align: center;">Registration</th>
                        </tr>
                    </thead >

                    <tbody> 

                        <%
                            while (resultSet.next()) {
                                String currency = resultSet.getString("CURR_ID");
                                Statement stwhereCur = null;
                                stwhereCur = connection.createStatement();
                                String sqlwhereCur = "SELECT * FROM currency where CRR_ID=" + currency;
                                ResultSet resultwhereCur = null;
                                resultwhereCur = stwhereCur.executeQuery(sqlwhereCur);
                                while (resultwhereCur.next()) {
                        %>
                        <tr>
                            <td></td>
                            <td><%out.print(resultSet.getString("ITEM_NO"));%></td>
                            <td><%=resultSet.getString("ITEM_NAME_EN")%></td>
                            <td><%=resultSet.getString("ITEM_NAME_TH")%></td>
                            <% DecimalFormat formatcomma = new DecimalFormat("#,##0.00");
                                Double douStprice = resultSet.getDouble("ST_PRICE");
                                String strStprice = formatcomma.format(douStprice);

                                String symbol = resultwhereCur.getString("CRR_SYM");
                            %>
                            <td><% out.print(symbol + strStprice); %></td>
                            <% SimpleDateFormat formatter = new SimpleDateFormat("dd MMM yyyy");
                                String strDate = formatter.format(resultSet.getDate("REG_DATE"));%>
                            <td><% out.print(strDate); %></td>
                        </tr>
                        <%      }
                            }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                         %>
                    </tbody>
                </table>
                
                    <button type="button" id="buttontable">Select</button>
                    <span id="test_name"></span>
                    <p><b>Selected rows data:</b></p>
                    <pre id="example-console-rows"></pre>
                
                <% try { %>
                <br>
                <br>
                <form  method="post" action="Insert_Product.jsp">
                    
                    <table>
                        <!--<tr><th style="padding-left:40px;">item No.</th><td><input class="form-control" type="text" name="item_no" required onkeyup="this.setCustomValidity('Type in English or numbers 0-9')" pattern="[A-Za-z0-9]{1,30}" /></td></tr>-->
                        <tr><th style="padding-left:40px;">item No.</th><td><input class="form-control" type="text" name="item_no" required pattern="[A-Za-z0-9]{1,}" title="Please Type in English or Number" maxlength="30" /></td></tr>
                        <tr><th style="padding-left:40px;">item Name English</th><td><input class="form-control" type="text" name="item_eng" maxlength="30" /></td></tr>
                        <tr><th style="padding-left:40px;">item Name Thai</th><td><input class="form-control" type="text" name="item_th" maxlength="30" /></td></tr>
                        <tr><th style="padding-left:40px;">Size</th><td><input class="form-control" type="text" name="size" maxlength="30" /></td></tr>
                        <tr><th style="padding-left:40px;">Specification</th><td><input class="form-control" type="text" name="spec" maxlength="50" /></td></tr>
                        <tr><th style="padding-left:40px;">Customer ID</th>
                            <td>
                                <script>
                                    $(document).ready(function () {
                                        $("#cus_id").on('change', function () {
                                            var id = this.options[this.selectedIndex].id;
                                            document.getElementById("readcus").innerHTML = id;
                                        });
                                    });
                                    $(document).ready(function () {
                                        $("#currency_id").on('change', function () {
                                            var id = this.options[this.selectedIndex].id;
                                            var sym = $(this).find('option:selected').attr("symbol");
                                            document.getElementById("readcur").innerHTML = id;
                                            document.getElementById("readsym1").innerHTML = sym;
                                            document.getElementById("readsym2").innerHTML = sym;
                                            document.getElementById("readsym3").innerHTML = sym;

                                        });
                                    });
                                    $(document).ready(function () {
                                        var idcust = $('#cus_id').find(":selected").attr("id");
                                        document.getElementById("readcus").innerHTML = idcust;

                                        var idcur = $('#currency_id').find(":selected").attr("id");
                                        var sym = $('#currency_id').find(":selected").attr("symbol");
                                        document.getElementById("readcur").innerHTML = idcur;
                                        document.getElementById("readsym1").innerHTML = sym;
                                        document.getElementById("readsym2").innerHTML = sym;
                                        document.getElementById("readsym3").innerHTML = sym;
                                    });


                                </script>

                                <select id="cus_id" name="cus_id" class="form-control" style="height:20%;" >
                                    <% while (resultCus.next()) {%>
                                    <option id="<%=resultCus.getString("CUST_ID")%>" value="<%=resultCus.getString("CUST_ID")%> " ><%=resultCus.getString("CUST_NAME_EN") + " " + resultCus.getString("CUST_NAME")%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td> 
                            <td colspan="2"><span id="readcus"></span></td>


                        <tr><th style="padding-left:40px;">Currency</th>
                            <td colspan="2">
                                <select id="currency_id" name="currency" required="" class="form-control" style="height:20%;">
                                    <%
                                        while (resultCur.next()) {
                                    %>
                                    <option symbol="<%=resultCur.getString("CRR_SYM")%>" id="<%=resultCur.getString("CRR_SYM")%>"  value="<%=resultCur.getString("CRR_ID")%>" ><%=resultCur.getString("CRR_NAME") + " " + resultCur.getString("CURR_CD") + " " + resultCur.getString("CRR_SYM")%></option>
                                    <%
                                        }
                                    %>
                                </select>

                            <td colspan="2"><span id="readcur"></span></td>
                            </td>
                        </tr>
                        <tr><th style="padding-left:40px;">Standard Price</th><td colspan="2"><input class="form-control" style="text-align: right;" type="text" name="standard_price" required pattern="[0-9.,]{1,}" onchange="chkNum(this)" value="0" /></td><td colspan="2"><span id="readsym1"></span></td></tr>
                        <tr><th style="padding-left:40px;">Material Unit Price</th><td colspan="2"><input class="form-control" style="text-align: right;" type="text"  name="mt_unit_price" required pattern="[0-9.,]{1,}"  onchange="chkNum(this)" value="0"/></td><td colspan="2"><span id="readsym2"></span></td></tr>
                        <tr><th style="padding-left:40px;">Process Price</th><td colspan="2"><input class="form-control" style="text-align: right;" type="text" name="process_price" required pattern="[0-9.,]{1,}" onchange="chkNum(this)" value="0"/></td><td colspan="2"><span id="readsym3"></span></td></tr>

                        <tr>
                        <div class="form-submit">
                            <td><button class="btn btn-primary" id="submit" name="Save" type="submit" value="Save" style="float: right;">Save</button></td>
                            <td>
                                <button class="btn btn-danger" id="cancel" name="Cancel" type="button" onclick="window.location.href = 'Product_Master.jsp';">Cancel</button>
                            </td>
                        </div>
                        </tr>
                    </table>

                </form>

                <%      
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>





        <div class="footer">
            <p align="center">2019 @Japan System(Thailand) Co.,Ltd.</p>
        </div>


        <script>
            function mydrop1() {
                var x = document.getElementById("drop1");
                if (x.className.indexOf("w3-show") == -1) {
                    x.className += " w3-show";
                    x.previousElementSibling.className += " w3-light-blue";
                } else {
                    x.className = x.className.replace(" w3-show", "");
                    x.previousElementSibling.className =
                            x.previousElementSibling.className.replace(" w3-light-blue", "");
                }
            }
            function mydrop2() {
                var y = document.getElementById("drop2");
                if (y.className.indexOf("w3-show") === -1) {
                    y.className += " w3-show";
                    y.previousElementSibling.className += " w3-light-blue";
                } else {
                    y.className = y.className.replace(" w3-show", "");
                    y.previousElementSibling.className =
                            y.previousElementSibling.className.replace(" w3-light-blue", "");
                }
            }
            function w3_open() {
                document.getElementById("mySidebar").style.display = "block";
            }

            function w3_close() {
                document.getElementById("mySidebar").style.display = "none";
            }
            function myFunction1() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("myInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("myTable");
                tr = table.getElementsByTagName("tr");
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[2];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            function deletet(cid) {


                var r = confirm("Are you sure you want to delete it?");
                if (r === true) {
                    document.location.href = "Del.jsp?CusID=" + cid;

                } else {
                    document.location.href = "Customer_Master.jsp";
                }

            }
            function goBack() {
                window.history.back();
            }

        </script>
        <!-- JS -->
<!--        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/nouislider/nouislider.min.js"></script>
        <script src="vendor/wnumb/wNumb.js"></script>
        <script src="vendor/jquery-validation/dist/jquery.validate.min.js"></script>
        <script src="vendor/jquery-validation/dist/additional-methods.min.js"></script>-->
<!--        <script src="js/main.js"></script>-->

        <%
            }
        %>
    </body>


</html>
