const rand=()=>{
    var phoneArray = ['130','131','132','133','134','135','136','137','138','139'];
    var nameArray = ['ccc','ddd','eee','fff','ggg','hhh','iii','jjj','kkk','lll'];
    var i = parseInt(10 * Math.random());
    var namee = nameArray[i];
    var phonee = phoneArray[i];
    var addRecord=[{name:namee,phone:phonee}];
    return addRecord;
}

export { rand };