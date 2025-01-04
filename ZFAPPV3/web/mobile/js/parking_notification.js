

setInterval(checknotify, 5000);
var c = 0;

async function checknotify() {
    c++;
    var data = await nativecallZf_jslib("park_service.aspx?id=user", null, 1);
    if (data != null) {
        
        if (data.length > 0) {
            Show_Message("Stop! Hammer time","HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
        }

    }
    
}



function Show_Message(Title, message) {
    if (message.trim().length > 4) {
        var c = $.dialog({
            title: Title,
            content: message,
            boxWidth: '500px',
            useBootstrap: false,
            draggable: true,
            theme: 'dark',

            rtl: true,
            backgroundDismiss: true,
            onDestroy: function () {
                b = 1;
            }
        });
    }
}
