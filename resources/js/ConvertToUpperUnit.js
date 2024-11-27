// export default function convertToUpperUnit(quantity, unit_label, unit_relation){
//     let relation = unit_relation.split('/')
//     let labels = unit_label.split('/')
//     let last = labels.length - 1;
//     let recordWithCleanUnit = [];

//     for (let i = last; i >= 0; i--) {
//         let divisor = parseFloat(relation[i])
//         let remainder = (quantity % divisor);
//         quantity = (quantity) / divisor;

//         if(i === 0) {
//             if (last > 0) {
//                 recordWithCleanUnit.push(Math.floor(quantity) + ' ' + labels[i]);
//             }else{
//                 recordWithCleanUnit.push(quantity + ' ' + labels[i]);
//             }
//         } else {
//             remainder = Number.parseFloat(remainder).toFixed(2);
//             if (remainder != 0 ) {
//                 recordWithCleanUnit.push(remainder + ' ' + labels[i]);
//             }
//         }
//     }
//     let reverseUnit = recordWithCleanUnit.reverse();
//     return reverseUnit.join(' ');
// }

export default function convertToUpperUnit(
    quantity,
    unit_label,
    unit_relation
) {
    let relation = unit_relation.split("/");
    let labels = unit_label.split("/");
    let last = labels.length - 1;
    let recordWithCleanUnit = [];

    for (let i = last; i >= 0; i--) {
        let divisor = parseFloat(relation[i]);
        let remainder = quantity % divisor;
        quantity = (quantity - remainder) / (divisor ? divisor : 1);

        if (i === 0) {
            if (last > 0) {
                recordWithCleanUnit.push(
                    Math.floor(quantity) + " " + labels[i]
                );
            } else {
                recordWithCleanUnit.push(quantity + " " + labels[i]);
            }
        } else {
            remainder = Number.parseFloat(remainder).toFixed(2);
            if (remainder != 0) {
                recordWithCleanUnit.push(remainder + " " + labels[i]);
            }
        }
    }

    let reverseUnit = recordWithCleanUnit.reverse();
    return reverseUnit.join(" ");
}

