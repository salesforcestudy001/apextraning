const fetchDataHelper=()=> {
    const contast = [{
        name :'a'+Math.floor((Math.random()*10)+1),
        phone : Math.floor((Math.random()*1000)+1)+Math.floor((Math.random()*100)+1)+Math.floor((Math.random()*10)+1),
    }]
    return contast;
}
export {fetchDataHelper}

