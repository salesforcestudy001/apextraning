/*
 * @Author: your name
 * @Date: 2021-09-28 10:29:33
 * @LastEditTime: 2021-10-07 12:03:57
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \trainingProject\force-app\main\default\lwc\jsLibrary\learnJsMethod.js
 */
function person(namee,age,gender){
    this.name=namee;
    this.age=age;
    this.gender=gender;
    var that = this;
    this.sayName= function() {
        console.log(that.name);
    }
}
class contact{
    constructor(id,name,title ){
        this.Id=id;
        this.Name=name;
        this.Title=title;
    }
}
person.prototype.toString=function(){
    return " name: "+this.name+" age: "+this.age;
}
Array.prototype.toString=function(){
    var str="";
    for (var index = 0; index < this.length; index++) {
        str=str+this[index].toString();
    }
    return str;
}
export {person,contact};