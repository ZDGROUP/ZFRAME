import call_get_process_step_id from "./APIs/get_process_step_id.js";
import call_get_step_count from "./APIs/get_step_count.js";


(async function () {
    let step_id = GetUrlParameter("step_id");
    let process_id = GetUrlParameter("process_id");
    let length = await call_get_step_count(step_id, process_id);
    if (parseInt(length[0].count) == 1) {
        let response = await call_get_process_step_id(step_id);
        let data = response[0].PROCESS_STEP_ID;
        document.getElementById("bpms_setting").innerHTML = data + "<br>" + "<span id='exist-db'><span>";
    } else {
        document.getElementById("bpms_setting").innerHTML = step_id + "<br>" + "<span id='not-exist-db'><span>";
    }
})();
