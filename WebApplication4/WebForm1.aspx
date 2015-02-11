<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication4.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Other</title>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://handsontable.com/dist/handsontable.full.js"></script>
    <link rel="stylesheet" media="screen" href="http://handsontable.com/dist/handsontable.full.css">
    <link rel="stylesheet" media="screen" href="http://handsontable.com/demo/css/samples.css">
    <link rel="stylesheet" media="screen" href="http://handsontable.com/demo/css/samples.css">
    <link rel="stylesheet" media="screen" href="http://handsontable.com/demo/css/samples.css">

    <script type="text/javascript">
        $(document).ready(function () {

            var data = [
              ["Account and Description", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"],
              [6144000, 0, 2941, 4303, 354, 5814],
              ["2010", 5, 2905, 2867, 412, 5284],
              ["2011", 4, 2517, 4822, 552, 6127],
              ["2012", 2, 2422, 5399, 776, 4151]
            ];

            var accounts = ["6111000 Kaizen Implementation", "6114000 Advertising - Admin.", "6118000 Import Duty", "6121950 Expense Recovery", "6121970 Benefit Enrollment and Adm Fee", "6131000 Research and Development", "6133000 Contracted Cleaning", "6133100 Grounds Maintenance", "6133200 Maintenance", "6134000 Rental Expense - Admin.", "6134100 TMC Trainers Expenses -Admin.", "6134200 NA Tech Assist & Trainer Exp", "6136100 Safety Supplies", "6136200 Fire Protection Equip. and Sup", "6136300 Security Equipment and Sup.", "6136400 Medical Fac.Equip.and Sup.", "6136500 Café.Sup. & Services", "6137000 Electricity Expense", "6138000 Water & Sewer Expense", "6138100 Gas Expense", "6142000 License Taxes", "6143200 Employee Relocation Exp.", "6143250 Employee Assignment Exp.", "6143500 Office Supplies", "6143800 Insurance", "6144100 Training Expenses - Admin.", "6144300 Subs./Pub.-Admin.", "6144400 Membership Fees - Admin.", "6144500 Public Relations Expense", "6144550 Sponsorships", "6144600 Courier Freight", "6144900 Recruiting & Interviewing", "6145100 Sample/Pilot Parts", "6145400 SG&A: Permits & Licenses", "6145600 Employee Relations", "6145650 Employee Recognition", "6149000 Automobile Expenses - Admin.", "6149100 Company Home Expenses", "6149200 Donations", "6149400 Other Expenses", "6149500 Management Fee"];

            var container = document.getElementById('example');
            var hot = new Handsontable(container, {
                //data: data,
                //startRows: 10,
                //maxRows: 10000,
                //startCols: 13,
                manualColumnResize: true,
                minSpareRows: 1,
                colHeaders: ["Account", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"],
                columns: [
                  {
                      type: 'dropdown',
                      source: accounts
                  },
                  { type: 'numeric' },
                  {
                      type: 'numeric'
                  },
                  {
                      type: 'numeric'
                  }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }, { type: 'numeric' }
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

        });
    </script>
</head>
<body>
    <h1>Other</h1>
    <div id="example" class="handsontable"></div>
        
    
    <button name="dump" data-dump="#example1" data-instance="hot" title="Submit Data">
    Submit
  </button>
</body>
</html>
