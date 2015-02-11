<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfServices.aspx.cs" Inherits="WebApplication4.ProfServices" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Professional Services</title>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://handsontable.com/dist/handsontable.full.js"></script>
    <link rel="stylesheet" media="screen" href="http://handsontable.com/dist/handsontable.full.css">
    <link rel="stylesheet" media="screen" href="http://handsontable.com/demo/css/samples.css">
    <link rel="stylesheet" media="screen" href="http://handsontable.com/demo/css/samples.css">
    <link rel="stylesheet" media="screen" href="http://handsontable.com/demo/css/samples.css">

    <script type="text/javascript">
        $(document).ready(function () {

            var data = [
              ["", "Computech Corp", "", "", "", "", "", "", "", "", "", "", "", "", ""],
              ["", "Visions Information Technology", "", "", "", "", "", "", "", "", "", "", "", "", ""],
              ["", "Partners Consulting", "", "", "", "", "", "", "", "", "", "", "", "", ""],
              ["", "Nothbound", "", "", "", "", "", "", "", "", "", "", "", "", ""],
              ["", "TT Media", "", "", "", "", "", "", "", "", "", "", "", "", ""],

            ];

            var accounts = ["5115510", "5116000", "5116001", "5116002", "5116100", "5116400", "5120856", "5120857", "5131000", "5133000", "5133200", "5133230", "5133300", "5133800", "5134000", "5134200", "5135000", "5136100", "5143000", "5143100", "5143200", "5143250", "5143500", "5143600", "5143700", "5144000", "5144010", "5144020", "5144100", "5144300", "5144400", "5144600", "5144900", "5145100", "5145400", "5145600", "5145650", "5149000", "5149550", "5149600", "5149650", "5149700", "5149850", "5190000", "5190100", "6111000", "6114000", "6118000", "6120051", "6120052", "6121100", "6121950", "6121970", "6131000", "6133000", "6133100", "6133200", "6133300", "6133400", "6134000", "6134100", "6134200", "6135000", "6136100", "6136200", "6136300", "6136400", "6136500", "6137000", "6138000", "6138100", "6142000", "6142100", "6142200", "6142300", "6143000", "6143100", "6143200", "6143250", "6143500", "6143600", "6143700", "6143800", "6144000", "6144010", "6144020", "6144040", "6144050", "6144100", "6144300", "6144400", "6144500", "6144550", "6144600", "6144900", "6145100", "6145400", "6145600", "6145650", "6149000", "6149100", "6149200", "6149400", "6149500"];

            var yellowRenderer = function (instance, td, row, col, prop, value, cellProperties) {
                Handsontable.renderers.TextRenderer.apply(this, arguments);
                td.style.backgroundColor = 'yellow';
            };
            var container = document.getElementById('example');
            var hot = new Handsontable(container, {
                data: data,
                //startRows: 10,
                //maxRows: 10000,
                //startCols: 13,
                manualColumnResize: true,
                minSpareRows: 1,
                colHeaders: ["Account Number", "Description", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Rate", "Hours"],
                columns: [
                  {
                      type: 'dropdown',
                      source: accounts
                  },
                  { type: 'text' },
                  {
                      type: 'numeric'
                  },
                  {
                      type: 'numeric'
                  }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric', renderer: yellowRenderer }, { type: 'numeric', renderer: yellowRenderer }
                ]
            });


            function bindDumpButton() {

                Handsontable.Dom.addEvent(document.body, 'click', function (e) {

                    var element = e.target || e.srcElement;

                    if (element.nodeName == "BUTTON" && element.name == 'dump') {

                        hot.getData().forEach(function (element, index) {
                            var sql = "INSERT INTO tbl_Other VALUES(";
                            hot.getDataAtRow(index).forEach(function (element) {
                                if (element != undefined && element != null && element != "" && element != " " ) {
                                    sql = sql + element + ", ";
                                }
                                else {
                                    sql = sql + "0, ";
                                }
                            });
                            sql = sql.substring(0, sql.length - 2) + ");";

                            console.log(sql);
                        });
                    }
                });
            }
            bindDumpButton();

            function bindCalcButton() {
                
                Handsontable.Dom.addEvent(document.body, 'click', function (e) {
                    var element = e.target || e.srcElement;
                    if (element.nodeName == "BUTTON" && element.name == 'calc') {
                        hot.getData().forEach(function (element, index) {
                            var rate = 0
                            var hours = 0
                            hot.getDataAtRow(index).forEach(function (element, index) {
                                if (index == 14 && element != "" && element != undefined && element != null && element != " ") {
                                    rate = element
                                }
                                if (index == 15 && element != "" && element != undefined && element != null && element != " ") {
                                    hours = element
                                }
                            }); //end for each cell
                            for (i = 2; i < 14; i++) {
                                hot.setDataAtCell(index, i, rate * hours / 12);
                            }
                        }); //end for each row
                    } //end if
                }); //add event

            } //end fucntion
            
            bindCalcButton();

        });
    </script>
</head>
<body>
    
    <p><h1>Professional Services</h1></p>
    <p>
        <a href="Other.aspx">Other</a> | <a href="ProfServices.aspx">Professional Services</a>
    <div id="example" class="handsontable"></div>
    </p> 
        
    
    <button name="dump" data-dump="#example1" data-instance="hot" title="Submit Data">
    Submit
  </button>
    <button name="calc" data-dump="#example1" data-instance="hot" title="Calc Data">
    Calc Data
  </button>
</body>
</html>
