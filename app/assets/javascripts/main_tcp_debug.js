
$(document).on('turbo:load', function (event) {
    hideLoader();

    console.log("Into TCP Debug");
    // Action cable Websocket
    App.cable.subscriptions.create("ActivityLogChannel", {
        connected() {
            console.log("Connected to the channel:", this);
            this.send({ message: 'TCP Debug Client is connected', topic: "tcp_debug", namespace: "subscriptions" });
        },
        disconnected() {
            console.log("Disconnected");
        },
        received(data) {
            if(data["topic"] == "tcp_debug")
                console.log("TCP DEBUG", data);
        }
    });

    $("#ping-host").keypress(function(event){if(event.keyCode == 13){$('#ping').click();}});
    $("#telnet-host").keypress(function(event){if(event.keyCode == 13){$('#telnet').click();}});
    $("#telnet-port").keypress(function(event){if(event.keyCode == 13){$('#telnet').click();}});
});

function hideLoader() {
    $(".loader").hide();
    $(".tcp-debug-response").show();
}

function showLoader() {
    $(".loader").show();
    $(".tcp-debug-response").hide();
}

function startTest(element) {
    $("#response").empty();
    typeOfTest = $(element).attr("id");
    host = $(`#${typeOfTest}-host`).val();
    port = $(`#${typeOfTest}-port`).val();
    // console.log(typeOfTest)
    // console.log(host)
    // console.log(port)
    showLoader();
    $.get("#{rails_admin.send('tcp_debug_path')}", {
        test: typeOfTest,
        host: host,
        port: port
    }).then(function (params) {
        // console.log("OK", params)
        $("#response").html(params["debug_status"]).removeClass("bg-danger").addClass("bg-success");
    }).catch(function (params) {
        // console.log("KO", params)
        $("#response").html(params["responseJSON"]["debug_status"]).removeClass("bg-success").addClass("bg-danger");
    }).always(hideLoader);
}
