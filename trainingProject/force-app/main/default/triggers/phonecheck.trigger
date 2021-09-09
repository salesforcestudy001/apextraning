trigger phonecheck on Contact (before insert,before update,after update) {
    for(contact c:trigger.new){
        if(c.phone=='110'){
            c.phone='119';
        }else if(c.phone=='112'){
            c.addError('错误号码');
        }
    }
}