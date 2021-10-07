const charFunction=()=> {    
    const contast = [{
        id:'id'+Math.floor((Math.random()*100)+1)+Math.floor(Math.random()*10),
        name:'boy'+Math.floor((Math.random()*1000)+1)+Math.floor((Math.random()*100)+1)+Math.floor((Math.random()*10)+1),
        title:'number'+Math.floor((Math.random()*10000)+1)+Math.floor((Math.random()*1000)+1)+Math.floor((Math.random()*100)+1)+Math.floor((Math.random()*10)+1),
    }]
    return contast;
}
export {charFunction}