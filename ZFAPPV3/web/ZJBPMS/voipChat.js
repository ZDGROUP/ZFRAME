var websocket = null;
var oMediaRecorder = null;
var bMediaRecorderReady = true
var audioContext = null;
var meter = null;

function OnLoad() {
    DisplayConfig();

    if (navigator.userAgent.indexOf("(iPhone;") != -1) {
        _("idContainer").style.padding = "50px"
    }    
}

function DisplayConfig() {
    for (var id in config) {
        if (_("id_" + id)) {
            _("id_" + id).innerHTML = config[id];
            _("txt_" + id).value = config[id];
        }
    }
}

function SoundSettings() {
    var b = _("chkSoundSettings").checked;
    if (b) DisplayConfig();
    _("tblSoundSettings").style.display = b ? "" : "none";
}

function _(id) {
    return document.getElementById(id)
}

function ShowAudioControls() {
    _("tdSound").style.display = chkSendAudio.checked ? "" : "none"; 
}

function RecordStart() {
    _("btnPushToTalk").style.backgroundColor = "red";
    
    if (oMediaRecorder) {
        oMediaRecorder.start();
    } else {
        SetupAudio(true);
    }    
}

function RecordEnd() {
    if (_("btnPushToTalk").style.backgroundColor != "red") return;

    _("btnPushToTalk").style.backgroundColor = "";
    if (oMediaRecorder && oMediaRecorder.state == 'recording') {
        bMediaRecorderReady = true;
        oMediaRecorder.stop()
    }
}

function SetupAutoSound() {
    if (chkSendAudio.checked == false) { chkSoundSettings.checked = false; SoundSettings()};
    SetupAudio(false);
    ShowAudioControls();
}

function SetupAudio(bStartMediaRecorder) {

    if (audioContext) {
        if (bStartMediaRecorder == false) AudioDetection();
        return null; //setup once
    } else {
        audioContext = new AudioContext();
    }

    var oUserMediaConfig = {'audio': {'mandatory': {
                'googEchoCancellation': 'false',
                'googAutoGainControl': 'false',
                'googNoiseSuppression': 'false',
                'googHighpassFilter': 'false'
            }, 'optional': []
        }
    }

    try {
        navigator.mediaDevices.getUserMedia(oUserMediaConfig).then(function (stream) {

            var mediaStreamSource = audioContext.createMediaStreamSource(stream);
            meter = CreateAudioMeter(audioContext);
            mediaStreamSource.connect(meter);
            dBegin = Date.now();
            AudioDetection();

            oMediaRecorder = new MediaRecorder(stream);
            oMediaRecorder.addEventListener('dataavailable', OnMediaRecorderReady);
            if (bStartMediaRecorder) oMediaRecorder.start();

        })
    } catch (e) {
        alert('getUserMedia threw exception :' + e);
    }
}

document.addEventListener('prespeechstart', event => {
    if (oMediaRecorder.state != 'inactive') {
        oMediaRecorder.stop()
    }        

    bMediaRecorderReady = false
    oMediaRecorder.start()
})

document.addEventListener('signal', event => {
    if (oMediaRecorder.state == 'inactive') {
        oMediaRecorder.start()
    }
})

document.addEventListener('speechstop', event => {

    if (oMediaRecorder.state == 'inactive') {
        LogOutput('Cannot stop MediaRecorder because it is inactive');
    } else {
        oMediaRecorder.stop()
    }

    bMediaRecorderReady = true
})

document.addEventListener('speechabort', event => {

    if (oMediaRecorder.state != 'inactive') {
        oMediaRecorder.stop()
    }        

    bMediaRecorderReady = false
})

function OnMediaRecorderReady(e) {
    if (bMediaRecorderReady && websocket.readyState == 1) {
        if (e.data && e.data.size > 0) {
            e.data.arrayBuffer().then(buffer => {
                LogOutput("Audio sent [" + e.data.size.toLocaleString('en-US') + "] "); // + e.data.type
                websocket.send(buffer);                
            })
        }
    }
}

function LogOutput(s) {
    if (txtOutput.value != "") txtOutput.value += "\n";
    var d = new Date();
    txtOutput.value += d.toLocaleString() + "\n" + s;
}

function HandleReceiveAudio(e) {

    const buffer = e.data
    var sBlobType = "audio/webm;codecs=opus";
    if (MediaRecorder.isTypeSupported(sBlobType) == false) {
        if (navigator.userAgent.indexOf("(iPhone;") != -1 || navigator.userAgent.indexOf("(iPad;") != -1) {
            const data = new Uint8Array(buffer);

            if (data[0] === 26 && data[1] === 69 && data[2] === 223) {
               
            }
        }

        sBlobType = "audio/mp4"
    }

    LogOutput("Audio received [" + buffer.byteLength.toLocaleString('en-US') + "]");

    var oBlob = new Blob([buffer], { "type": sBlobType });
    var audioURL = window.URL.createObjectURL(oBlob);

    var audio = _("idAudio");
    //var audio = new Audio();

    audio.src = audioURL;
    audio.play();
}

function OpenSocket() {

    var sProtocol = window.location.protocol == "https:" ? "wss" : "ws";
    var uri = sProtocol + '://' + window.location.hostname + "/ZFN/VOIP?user=" + escape(txtUser.value);
    websocket = new WebSocket(uri);
    websocket.binaryType = "arraybuffer";

    websocket.onopen = function () {
        //Connected   
        chkSendAudio.disabled = false;
        btnSend.disabled = false;
        btnRing.disabled = false;
        btnPushToTalk.disabled = false;
        btnClose.disabled = false;
        btnOpen.disabled = true;
        spStatus.style.color = "green";
        RefreshUsers();
    };

    websocket.onclose = function () {
        if (document.readyState == "complete") {
            //Connection lost
            chkSendAudio.disabled = false;
            btnSend.disabled = true;
            btnRing.disabled = true;
            btnPushToTalk.disabled = true;
            btnClose.disabled = true;
            btnOpen.disabled = false;
            spStatus.style.color = "red";
            tdOtherUsers.innerHTML = "";
            RefreshUsers();
            chkSendAudio.checked = false;
            chkSoundSettings.checked = false;
            ShowAudioControls();
            SoundSettings();
        }
    };

    websocket.onmessage = function (event) {

        if (typeof event.data == "object" && event.data.toString() == "[object ArrayBuffer]") {
            setTimeout(function () {
                HandleReceiveAudio(event);
            }, 1000);

        } else {
            var sData = event.data;

            if (sData == "{{RefreshUsers}}") {
                RefreshUsers();
                return;
            } else if (sData.indexOf("{{Ring}}") != -1) {
                PlayFile("mp3/Ring.mp3", 10000);
                //return;
            }

            LogOutput(sData);
        }
    };

    websocket.onerror = function (event) {
        alert('Could not connect.  Please try another name.');
    };

    setTimeout(function () { RefreshUsers() }, 1000);
}

function Send() {
    if (txtMsg.value == "") return;
    websocket.send(txtMsg.value);
    txtMsg.value = "";
}

function CloseSocket() {
    websocket.close();
}

function RefreshUsers() {
    var oHttp = new XMLHttpRequest();
    oHttp.open("POST", "?getUsers=1", false);
    oHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    oHttp.onreadystatechange = function () { // Call a function when the state changes.
        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
            tdOtherUsers.innerHTML = oHttp.responseText;
        }
    }
    oHttp.send();
}

function ResetUsers() {
    var oHttp = new XMLHttpRequest();
    oHttp.open("POST", "?resetUsers=1", false);
    oHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    oHttp.onreadystatechange = function () { // Call a function when the state changes.
        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
            tdOtherUsers.innerHTML = "";
        }
    }
    oHttp.send();
}

function Ring() {
    if (websocket) websocket.send("{{Ring}}");
    PlayFile("mp3/PhoneLong.mp3", 10000);
}

function PlayFile(sFile, iStopMsec) {
    var oAudio = _("idAudio");  
    //var oAudio = new Audio(sFile);
    oAudio.src = sFile;

    oAudio.play();
    setTimeout(function () {
        oAudio.pause()
    }, iStopMsec)
}

//===============
//Code based on: https://github.com/solyarisoftware/webad
let volumeState = 'mute'
let speechStarted = false
let silenceItems = 0
let signalItems = 0
let speechstartTime
let prerecordingItems = 0
let speechVolumesList = []
const dispatchEvent = (eventName, eventData) => document.dispatchEvent(new CustomEvent(eventName, eventData))
var oVolumeList = [];
var dBegin = Date.now();
var iMinAvg = null;

var config = {
    timeoutMsecs: 50, //SAMPLE_POLLING_MSECS
    prespeechstartMsecs: 300, //PRERECORDSTART_MSECS 600
    silence: 300, //MAX_INTERSPEECH_SILENCE_MSECS 600
    signalDuration: 200, //MIN_SIGNAL_DURATION 400
    maxSignalDuration: 8000, //stop recording and send signal if it is more than 8 seconds
    averageSignalValue: 0.02, //MIN_AVERAGE_SIGNAL_VOLUME 0.04 -- to calculate if a signal block contains speech or just noise
    speakingMinVolume: 0.01, //VOLUME_SIGNAL 0.02
    muteVolume: 0.0001 //VOLUME_MUTE
};

function AudioDetection() {

    if (chkSendAudio.checked == false) {
        return
    }

    setTimeout(function() {
            prerecording();
            sampleThresholdsDecision();

            if (meter) {
                if ((Date.now() - dBegin) / 1000 <= 60) {
                    //witin the first minute, setup speakingMinVolume and averageSignalValue based on min avarage of 100 volume points 

                    oVolumeList.push(meter.volume);
                    var iAvg = GetListAvg(oVolumeList);
                    if (oVolumeList.length > 100) {
                        oVolumeList.shift(); // removes the first item of an array
                        var iAvg = GetListAvg(oVolumeList);
                        if (iMinAvg == null) {
                            iMinAvg = iAvg;
                        } else {
                            iMinAvg = Math.min(iMinAvg, iAvg);
                        }

                        if (config.speakingMinVolume < iMinAvg) {
                            config.speakingMinVolume = parseFloat(iMinAvg.toFixed(4));
                            config.averageSignalValue = config.speakingMinVolume * 2;
                        }
                    }                    
                }               

                _("idVolume").innerHTML = meter.volume.toFixed(4);
                _("idProgress").style.width = (meter.volume * 1000) + "px";
                _("idMediaRecorderState").innerHTML = oMediaRecorder.state
            }

        AudioDetection();
        }, config.timeoutMsecs
    )

    function prerecording() {
        ++prerecordingItems

        const eventData = {
            detail: {
                volume: meter.volume,
                timestamp: Date.now(),
                items: prerecordingItems
            }
        }

        if ((prerecordingItems * config.timeoutMsecs) >= config.prespeechstartMsecs) {
            if (!speechStarted)
                dispatchEvent('prespeechstart', eventData)
            prerecordingItems = 0
        }
    }

    function sampleThresholdsDecision() {
        const timestamp = Date.now()
        const duration = timestamp - speechstartTime
        var div = document.getElementById("idVolumeState");

        if (meter.volume < config.muteVolume) {
            mute(timestamp, duration);
            div.innerHTML = "mute"
            div.style.backgroundColor = "";
        } else if (meter.volume > config.speakingMinVolume) {
            signal(timestamp, duration);
            div.innerHTML = "signal " + duration.toLocaleString();
            div.style.backgroundColor = "lightgreen";
        } else {
            silence(timestamp, duration);
            div.innerHTML = "silence"
            div.style.backgroundColor = "";
        }
    }

    function mute(timestamp, duration) {
        const eventData = {
            detail: {
                event: 'mute',
                volume: meter.volume,
                timestamp,
                duration
            }
        }

        dispatchEvent('mute', eventData)

        if (volumeState !== 'mute') {
            dispatchEvent('mutedmic', eventData)
            volumeState = 'mute'
        }

    }

    function signal(timestamp, duration) {

        silenceItems = 0

        const eventData = {
            detail: {
                event: 'signal',
                volume: meter.volume,
                timestamp,
                duration,
                items: ++signalItems
            }
        }

        if (duration > config.maxSignalDuration) {
            dispatchEvent('speechstop', eventData);
            speechstartTime = Date.now();
            speechStarted = false;
            return;
        }

        if (!speechStarted) {
            dispatchEvent('speechstart', eventData)
            speechstartTime = timestamp
            speechStarted = true
            speechVolumesList = []
        }

        speechVolumesList.push(meter.volume)
        dispatchEvent('signal', eventData)

        if (volumeState === 'mute') {
            dispatchEvent('unmutedmic', eventData)
            volumeState = 'signal'
        }
    }

    function silence(timestamp, duration) {
        signalItems = 0
        const eventData = {
            detail: {
                event: 'silence',
                volume: meter.volume,
                timestamp,
                duration,
                items: ++silenceItems
            }
        }

        dispatchEvent('silence', eventData)

        if (volumeState === 'mute') {
            dispatchEvent('unmutedmic', eventData)
            volumeState = 'silence'
        }

        var maxSilenceItems = Math.round(config.silence / config.timeoutMsecs);

        if (speechStarted && (silenceItems === maxSilenceItems)) {

            const signalDuration = duration - config.silence
            const averageSignalValue = GetListAvg(speechVolumesList).toFixed(4)

            if (signalDuration < config.signalDuration) {
                eventData.detail.abort = `signal duration (${signalDuration}) < config.signalDuration (${config.signalDuration})`
                dispatchEvent('speechabort', eventData)
            }

            else if (averageSignalValue < config.averageSignalValue) {

                eventData.detail.abort = `signal average volume (${averageSignalValue}) < config.averageSignalValue (${config.averageSignalValue})`
                dispatchEvent('speechabort', eventData)
            }

            else {
                dispatchEvent('speechstop', eventData)
            }

            speechStarted = false
        }
    }

    function GetListAvg(oList) {
        if (oList.length == 0) return 0;
        return (oList.reduce((a, b) => a + b) / oList.length);
    }
}

function CreateAudioMeter(audioContext, clipLevel, averaging, clipLag) {
    var processor = audioContext.createScriptProcessor(512);
    //The ScriptProcessorNode is deprecated. Use AudioWorkletNode instead. 
    //https://developer.chrome.com/blog/audio-worklet/

    processor.onaudioprocess = volumeAudioProcess;
    processor.clipping = false;
    processor.lastClip = 0;
    processor.volume = 0;
    processor.clipLevel = clipLevel || 0.98;
    processor.averaging = averaging || 0.95;
    processor.clipLag = clipLag || 750;
    processor.connect(audioContext.destination);

    processor.checkClipping =
        function () {
            if (!this.clipping)
                return false;
            if ((this.lastClip + this.clipLag) < window.performance.now())
                this.clipping = false;
            return this.clipping;
        };

    processor.shutdown =
        function () {
            this.disconnect();
            this.onaudioprocess = null;
        };

    return processor;

    function volumeAudioProcess(event) {
        var buf = event.inputBuffer.getChannelData(0);
        var bufLength = buf.length;
        var sum = 0;
        var x;

        for (var i = 0; i < bufLength; i++) {
            x = buf[i];
            if (Math.abs(x) >= this.clipLevel) {
                this.clipping = true;
                this.lastClip = window.performance.now();
            }
            sum += x * x;
        }

        var rms = Math.sqrt(sum / bufLength);
        this.volume = Math.max(rms, this.volume * this.averaging);
    }
}
