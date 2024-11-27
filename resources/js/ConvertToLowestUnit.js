export default function convertToLowestUnit(quantity, unit_relation) {
    const unitRelation = unit_relation.split("/");
    let lowestUnit = 0;
    for (let i = 0; i < unitRelation.length; i++) {
        lowestUnit += parseFloat(quantity[i] || "0");
        lowestUnit *= parseFloat(unitRelation[i + 1] || "1");
    }
    return lowestUnit;
}
