export default async function call_insert_process_step_maps(P_process_step_defintion_id, P_from_step_id, P_to_step_id) {
    var param = [];
    param.push({ name: 'process_step_defintion_id', value: P_process_step_defintion_id });
    param.push({ name: 'from_step_id', value: P_from_step_id });
    param.push({ name: 'to_step_id', value: P_to_step_id });

    let result = await callZf_jslib('process/', 'insert_process_step_maps', param, 2);
    return result;
}