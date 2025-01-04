export default async function call_delete_process_step(P_source_id) {
    var param = [];
    param.push({ name: 'source_id', value: P_source_id });

    let result = await callZf_jslib('process/', 'delete_step', param, 2);
    return result;
}
