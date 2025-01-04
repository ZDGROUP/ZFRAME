export default async function call_update_process_step_maps(P_from_step_id, P_to_step_idwhere, P_process_step_defintion_id) {
    var param = [];
    param.push({ name: 'from_step_id', value: P_from_step_id });
    param.push({ name: 'to_step_idwhere', value: P_to_step_idwhere });
    param.push({ name: 'process_step_defintion_id', value: P_process_step_defintion_id });

    let result = await callZf_jslib('process/', 'update_process_step_maps', param, 2);
    return result;
}
