function initChart(ctx, model, title, maxY, unit) {
    return new Chart(ctx, {
        type: 'line',
        data: model,
        options: {
            maintainAspectRatio: false,
            title: {
					display: true,
					text: title
				},
            scales: {
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: unit
                    },
                    ticks: {
                        type: 'linear',
                        beginAtZero: true,
                        precision: 0,
                        max: maxY
                    }
                }]
            }
        }
    });
}

function emptyModel() {
    var model = {
        datasets: []
    };
    return model;
}

function replaceData(chart, labels, datasets) {
    chart.data.labels = [];
    chart.data.datasets = [];

    labels.forEach((label) => {
        chart.data.labels.push(label);
    });
    datasets.forEach((dataset) => {
        chart.data.datasets.push(dataset);
    });
    chart.update(0);
}

tempModel = emptyModel();
humidModel = emptyModel();

tempCtx = document.getElementById('temp-chart').getContext('2d');
window.tempChart = initChart(tempCtx, tempModel, "Temperatura", undefined, "°C");
humidCtx = document.getElementById('humid-chart').getContext('2d');
window.humidChart = initChart(humidCtx, humidModel, "Wilgotność", 100, "%");
