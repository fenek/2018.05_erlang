$("#add-device-form").submit(function(event) {
    var snNode = $("input[name='device-sn']");
    var descNode = $("input[name='device-desc']");
    var erlangNode = $("input[name='device-node']");

    var data = {
        sn: snNode.val(),
        desc: descNode.val(),
        node: erlangNode.val()
    };
    
    var onSuccess = function(data) {
    };

    var onFail = function() {
        alert("Error");
    };

    jQuery.post(Config.backendBase + "/device", JSON.stringify(data), onSuccess)
        .fail(onFail)
        .done(onDone);

    event.preventDefault();
});
