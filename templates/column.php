<link rel="stylesheet" type="text/css" href="{{ url_for('static',filename='css/custom.css')}}">
<link rel="stylesheet" type="text/css" href="{{ url_for('static',filename='css/style.css')}}">
<img src="{{ url_for('static',filename='img/atas.png')}}"/>
<style type="text/css">
    h1{
      display: grid;
	  	text-align: center;
	  	vertical-align: middle;
	  	border:2px solid rgba(0,0,0,.2);
      margin-left: 13cm;
      width: 7cm;
    }
    diagram{
      display: grid;
      margin-left: 9cm;
    }
</style>
<h1>DIAGRAM BATANG</h1>
<diagram>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    a={{Infodiagram[0][1]}}
    b={{Infodiagram[1][1]}}
    c={{Infodiagram[2][1]}}
    d={{Infodiagram[3][1]}}
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Nomor Ruangan', 'Kapasitas', { role: "style" }],
        ['Ruang 1',  a, "red" ],
        ['Ruang 2', b, "blue" ],
        ['Ruang 3', c, "green" ],
        ['Ruang 4', d, "yellow" ]
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "Ruang Tahanan , dalam orang",
        width: 600,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
  }
  </script>
<div id="columnchart_values" style="width: 900px; height: 300px;"></div>
</diagram>