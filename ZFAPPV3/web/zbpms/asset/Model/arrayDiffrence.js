export default function arrayDiffrence(array1, array2) {

    var array = [];
    var differnce = [];

    for (var i = 0; i < array1.length; i++) {
        array[array1[i]] = true;
    }

    for (var i = 0; i < array2.length; i++) {
        if (array[array2[i]]) {
            delete array[array2[i]];
        } else {
            array[array2[i]] = true;
        }
    }

    for (var element in array) {
        differnce.push(element);
    }
    
    return differnce;
}
