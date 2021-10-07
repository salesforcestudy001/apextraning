const selData=()=>
{
    var names=['sam','luther','joe','david'];
    const contacts = [{
        name : names[parseInt(Math.random()*10)],
        phone : Math.floor((Math.random()*1000)+1)
    }]
    return contacts;
}
export {selData}