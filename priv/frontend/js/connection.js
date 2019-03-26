function padZero(num) {
    if(num < 10)
        return '0' + num.toString();
    else
        return num.toString();
}

function extractLabels(inDatasets) {
    var labels = [];
    inDatasets[0].data.forEach((dataPoint) => {
        var date = new Date(dataPoint.tstamp);
        var hours = padZero(date.getHours());
        var minutes = padZero(date.getMinutes());
        labels.push(hours + ":" + minutes);
    });
    return labels;
}

function handleDatasets(chart, inDatasets, colorFun) {
    var outDatasets = [];
    for(var i = 0; i < inDatasets.length; i++) {
        var inDataset = inDatasets[i];
        var inData = inDataset.data;
        var outDataset = { label: "", data: [] };
        outDataset.label = inDataset.devname;
        outDataset.borderColor = colorFun(i, inDatasets.length);
        outDataset.fill = false;
        var outData = outDataset.data;
        
        for(var j = 0; j < inData.length; j++)
            outData.push(inData[j].value);

        outDatasets.push(outDataset);
    }

    labels = extractLabels(inDatasets);
    replaceData(chart, labels, outDatasets);
}

function updateStats() {
    jQuery.get(Config.backendBase + "/stats", "", handleStats, "json");
    setTimeout(updateStats, Config.updateInterval);
};

function makeColorFun(r, g, b) {
    return function(i, count) {
        i++;
        var cr = 255 - Math.floor((255-r) * (i/count));
        var cg = 255 - Math.floor((255-g) * (i/count));
        var cb = 255 - Math.floor((255-b) * (i/count));
        return 'rgba(' + cr.toString() + ', ' + cg.toString() + ', ' + cb.toString() + ', 1)';
    };
}

function handleStats(data, textStatus, jqXHR) {
    handleDatasets(window.tempChart, data.temp, makeColorFun(255, 0, 0));
    handleDatasets(window.humidChart, data.humidity, makeColorFun(0, 0, 255));
};

updateStats();

