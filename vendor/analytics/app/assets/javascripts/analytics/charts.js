$(function () {
    var visits_options = {
        chart: {
            renderTo: 'visits',
            type: 'spline'
        },
        title: {
            text: 'Visits'
        },
        series: [{}]
    };
    $.getJSON('/analytics/charts/visits', function(data) {
        visits_options.series[0].data = data;
        new Highcharts.Chart(visits_options);
    });

});