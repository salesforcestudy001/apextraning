const cont=()=>{
    //var idArray=Math.floor(Math.random()*10+1);
    var nameArray = ['xiaowang','lucy','lina','xiaohong'];
    var titleArray = ['shucue','vvv','ff','gg'];
    var i = parseInt(3* Math.random());
    var namee = nameArray[i];
    var titleee = titleArray[i];
    var addRecord={Name:namee,Title:titleee};
    return addRecord;
    
}

export { cont };