<html>
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
      margin-left: 6cm;
    }
</style>
<h1>DIAGRAM PIE</h1>
<diagram>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      a={{Infodiagram[0][1]}}
      b={{Infodiagram[1][1]}}
      c={{Infodiagram[2][1]}}
      d={{Infodiagram[3][1]}}
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Nomor Ruangan', 'Kapasitas'],
          ['Ruang 1',  a ],
          ['Ruang 2', b ],
          ['Ruang 3', c ],
          ['Ruang 4', d ]
        ]);

      var options = {
        legend: 'none',
        pieSliceText: 'label',
        title: 'Ruang Tahanan',
        pieStartAngle: 100,
      };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="piechart" style="width: 900px; height: 500px;"></div>
  </body>
    </diagram>
</html>