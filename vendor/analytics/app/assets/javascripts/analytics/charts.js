$(function () {
    var visits_options = {
        chart: {
            renderTo: 'visits'
        },
        title: {
            text: 'Visits by days'
        },
        yAxis: {
            title: {
                text: 'Number of visits'
            }
        },
        xAxis: {
            type: 'datetime'
        },
        series: [{ name: 'Visits', data: [] }]
    };
    $.getJSON('/analytics/charts/visits', function(data) {
        var visits = {};
        data.forEach(function (item) {
            var date = new Date(item.started_at);
            var time = new Date(
                date.getFullYear(),
                date.getMonth(),
                date.getDay()
            ).getTime();
            visits[time] = visits[time] || [];
            visits[time].push(item);
        });

        for (var item in visits) {
            visits_options.series[0].data
                .push([parseInt(item) , visits[item].length]);
        }

        new Highcharts.Chart(visits_options);
    });

    var events_options = {
        chart: {
            renderTo: 'events'
        },
        title: {
            text: 'Events by days'
        },
        yAxis: {
            title: {
                text: 'Number of events'
            }
        },
        xAxis: {
            type: 'datetime'
        },
        series: []
    };
    $.getJSON('/analytics/charts/events', function(data) {
        var events = {};
        data.forEach(function (item) {
            var date = new Date(item.time);
            var time = new Date(
                date.getFullYear(),
                date.getMonth(),
                date.getDay()
            ).getTime();
            events[item.name] = events[item.name] || [];
            events[item.name][time] = events[item.name][time] || [];
            events[item.name][time].push(item);
        });

        for (var event in events) {
            var series = { name: event, data: [] };
            for (var item in events[event]) {
                series.data.push([parseInt(item), events[event][item].length]);
            }
            events_options.series.push(series);
        }

        new Highcharts.Chart(events_options);
    });
});